const { onSchedule } = require('firebase-functions/v2/scheduler');
const { onCall }     = require('firebase-functions/v2/https');
const admin          = require('firebase-admin');

admin.initializeApp();

const db  = admin.firestore();
const fcm = admin.messaging();

// ── Constants ──────────────────────────────────────────────────────────────────

const CHANNEL_ID     = 'herdiq_alerts';
const ALERT_DAYS_AHEAD = 7; // match app's notificationsProvider window

// ── Helpers ────────────────────────────────────────────────────────────────────

function toDateStr(date) {
  return date.toISOString().split('T')[0]; // 'YYYY-MM-DD'
}

function daysUntil(dueDateStr) {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const due   = new Date(dueDateStr + 'T00:00:00');
  return Math.round((due - today) / (1000 * 60 * 60 * 24));
}

// Returns the alert count for an org from its health records.
async function computeAlertCount(orgId) {
  const today     = new Date();
  today.setHours(0, 0, 0, 0);
  const cutoffStr = toDateStr(new Date(today.getTime() + ALERT_DAYS_AHEAD * 86400000));

  // Upcoming (≤7 days) + overdue (nextDue < today)
  const [upcoming, overdue] = await Promise.all([
    db.collection('organizations').doc(orgId)
      .collection('healthRecords')
      .where('nextDue', '>=', toDateStr(today))
      .where('nextDue', '<=', cutoffStr)
      .get(),
    db.collection('organizations').doc(orgId)
      .collection('healthRecords')
      .where('nextDue', '<', toDateStr(today))
      .get(),
  ]);

  // Weaning alerts: animals with weaningFromDays set where today is in window
  const animalsSnap = await db.collection('organizations').doc(orgId)
    .collection('animals')
    .where('weaningFromDays', '>', 0)
    .get();

  let weaningCount = 0;
  animalsSnap.forEach((doc) => {
    const { dateOfBirth, weaningFromDays, weaningToDays } = doc.data();
    if (!dateOfBirth || !weaningFromDays) return;
    const dob = new Date(dateOfBirth + 'T00:00:00');
    const ageInDays = Math.round((today - dob) / 86400000);
    const weanEnd = weaningToDays ?? (weaningFromDays + 30);
    if (ageInDays >= weaningFromDays && ageInDays <= weanEnd) weaningCount++;
  });

  return upcoming.size + overdue.size + weaningCount;
}

// Build the Arabic notification body text
function buildBody(count) {
  if (count === 1) return 'لديك تنبيه واحد يحتاج إلى متابعة';
  if (count === 2) return 'لديك تنبيهان يحتاجان إلى متابعة';
  if (count <= 10) return `لديك ${count} تنبيهات تحتاج إلى متابعة`;
  return `لديك ${count} تنبيهاً تحتاج إلى متابعة`;
}

// ── Scheduled daily alert push — 7 AM Arabian Standard Time (UTC+3 = 04:00 UTC) ─

exports.checkDailyAlerts = onSchedule(
  {
    schedule: '0 4 * * *',   // 04:00 UTC = 07:00 AST
    timeZone: 'UTC',
    region: 'us-central1',
    memory: '256MiB',
  },
  async () => {
    const orgsSnap = await db.collection('organizations').get();
    const tasks    = [];

    orgsSnap.forEach((orgDoc) => {
      tasks.push(
        (async () => {
          const orgId = orgDoc.id;
          try {
            // Get owner's FCM token from users/{orgId}
            const userDoc = await db.collection('users').doc(orgId).get();
            const fcmToken = userDoc.data()?.fcmToken;
            if (!fcmToken) return;

            const alertCount = await computeAlertCount(orgId);
            if (alertCount === 0) return;

            await fcm.send({
              token: fcmToken,
              notification: {
                title: '🔔 تنبيهات المزرعة',
                body: buildBody(alertCount),
              },
              data: {
                route: '/home/notifications',
                alertCount: String(alertCount),
              },
              android: {
                notification: {
                  channelId: CHANNEL_ID,
                  priority:  'high',
                  sound:     'default',
                },
                priority: 'high',
              },
              apns: {
                payload: {
                  aps: {
                    badge: alertCount,
                    sound: 'default',
                  },
                },
              },
            });
          } catch (err) {
            console.error(`[checkDailyAlerts] org=${orgId}`, err.message);
          }
        })()
      );
    });

    await Promise.allSettled(tasks);
  }
);

// ── Admin broadcast notification (callable from admin panel) ──────────────────

exports.broadcastNotification = onCall({ region: 'us-central1' }, async (request) => {
  const uid = request.auth?.uid;
  if (!uid) throw new Error('Unauthenticated');

  // Verify caller is an admin
  const adminDoc = await db.collection('admins').doc(uid).get();
  if (!adminDoc.exists) throw new Error('Not authorized');

  const { title, body, target, country } = request.data;
  if (!title || !body) throw new Error('title and body are required');

  // Collect FCM tokens
  const usersSnap = await db.collection('users').get();
  const tokens = [];

  usersSnap.forEach((doc) => {
    const data = doc.data();
    if (!data.fcmToken) return;
    if (target === 'country' && country && data.country !== country) return;
    tokens.push(data.fcmToken);
  });

  if (tokens.length === 0) return { success: true, sent: 0 };

  // Send in batches of 500 (FCM limit)
  let sent = 0;
  for (let i = 0; i < tokens.length; i += 500) {
    const batch = tokens.slice(i, i + 500);
    const result = await fcm.sendEachForMulticast({
      tokens: batch,
      notification: { title, body },
      android: {
        notification: { channelId: CHANNEL_ID, priority: 'high', sound: 'default' },
        priority: 'high',
      },
      apns: { payload: { aps: { sound: 'default' } } },
    });
    sent += result.successCount;
  }

  return { success: true, sent };
});

// ── Manual trigger (callable from admin panel or for testing) ──────────────────

exports.sendTestAlert = onCall({ region: 'us-central1' }, async (request) => {
  const uid = request.auth?.uid;
  if (!uid) throw new Error('Unauthenticated');

  const userDoc = await db.collection('users').doc(uid).get();
  const fcmToken = userDoc.data()?.fcmToken;
  if (!fcmToken) return { success: false, reason: 'No FCM token on file' };

  await fcm.send({
    token: fcmToken,
    notification: {
      title: '🔔 اختبار التنبيهات',
      body:  'التنبيهات تعمل بشكل صحيح ✅',
    },
    android: {
      notification: { channelId: CHANNEL_ID, priority: 'high', sound: 'default' },
      priority: 'high',
    },
  });

  return { success: true };
});
