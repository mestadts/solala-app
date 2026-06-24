import { useEffect, useState } from 'react'
import { collection, getDocs, doc, setDoc, deleteDoc, serverTimestamp } from 'firebase/firestore'
import { db, auth } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Modal from '../components/Modal'
import { Plus, Trash2, ShieldCheck, Eye, EyeOff, Copy, Check, UserPlus, UserCheck } from 'lucide-react'

const FIREBASE_API_KEY = 'AIzaSyDbrcTv2b3K_ZRUwd_6JUyhZm6xgxmJ2VM'

interface AdminEntry {
  uid: string
  email: string
  addedAt?: string
}

interface CreatedAdmin {
  email: string
  password: string
  uid: string
}

type Mode = 'create' | 'existing'

export default function AdminsPage() {
  const [admins, setAdmins] = useState<AdminEntry[]>([])
  const [loading, setLoading] = useState(true)
  const [modalOpen, setModalOpen] = useState(false)
  const [mode, setMode] = useState<Mode>('create')

  // Create mode fields
  const [createForm, setCreateForm] = useState({ email: '', password: '', confirmPassword: '' })
  const [showPassword, setShowPassword] = useState(false)
  const [created, setCreated] = useState<CreatedAdmin | null>(null)
  const [copied, setCopied] = useState(false)

  // Existing mode fields
  const [existingForm, setExistingForm] = useState({ email: '', uid: '' })

  const [saving, setSaving] = useState(false)
  const [error, setError] = useState('')

  const currentUid = auth.currentUser?.uid

  useEffect(() => { load() }, [])

  async function load() {
    setLoading(true)
    const snap = await getDocs(collection(db, 'admins'))
    setAdmins(snap.docs.map(d => ({ uid: d.id, ...d.data() } as AdminEntry)))
    setLoading(false)
  }

  function openAdd() {
    setMode('create')
    setCreateForm({ email: '', password: '', confirmPassword: '' })
    setExistingForm({ email: '', uid: '' })
    setError('')
    setCreated(null)
    setShowPassword(false)
    setCopied(false)
    setModalOpen(true)
  }

  function switchMode(m: Mode) {
    setMode(m)
    setError('')
    setCreated(null)
  }

  // ── Create new Firebase account + add as admin ──
  async function saveCreate() {
    const { email, password, confirmPassword } = createForm
    if (!email || !password) return
    if (password.length < 6) { setError('Password must be at least 6 characters.'); return }
    if (password !== confirmPassword) { setError('Passwords do not match.'); return }
    if (admins.some(a => a.email === email)) { setError('This email is already an admin.'); return }

    setSaving(true); setError('')
    try {
      const res = await fetch(
        `https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${FIREBASE_API_KEY}`,
        {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ email, password, returnSecureToken: true }),
        }
      )
      const data = await res.json()
      if (!res.ok) {
        const msg = data?.error?.message ?? 'Failed to create account.'
        setError(msg === 'EMAIL_EXISTS' ? 'This email already has a Firebase account. Use "Add Existing" tab instead.' : msg)
        return
      }
      const uid: string = data.localId
      await setDoc(doc(db, 'admins', uid), { email, addedAt: serverTimestamp() })
      setCreated({ email, password, uid })
      load()
    } catch (e: unknown) {
      setError(e instanceof Error ? e.message : 'Unexpected error.')
    } finally {
      setSaving(false)
    }
  }

  // ── Add existing Firebase account as admin ──
  async function saveExisting() {
    const uid = existingForm.uid.trim()
    const email = existingForm.email.trim()
    if (!uid || !email) return
    if (admins.some(a => a.uid === uid)) { setError('This account is already an admin.'); return }

    setSaving(true); setError('')
    try {
      await setDoc(doc(db, 'admins', uid), { email, addedAt: serverTimestamp() })
      setModalOpen(false)
      load()
    } catch (e: unknown) {
      setError(e instanceof Error ? e.message : 'Failed to save.')
    } finally {
      setSaving(false)
    }
  }

  async function remove(uid: string) {
    if (uid === currentUid) return
    if (!confirm('Remove this admin? They will lose access to the panel.')) return
    await deleteDoc(doc(db, 'admins', uid))
    load()
  }

  function copyCredentials() {
    if (!created) return
    navigator.clipboard.writeText(`Email: ${created.email}\nPassword: ${created.password}\nLogin: https://herdiq-prod.web.app`)
    setCopied(true)
    setTimeout(() => setCopied(false), 2000)
  }

  return (
    <div>
      <PageHeader
        title="Admin Users"
        subtitle="Manage who can access this admin panel"
        action={
          <button
            onClick={openAdd}
            className="flex items-center gap-2 bg-[#3B1500] text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-[#5a2200] transition-colors"
          >
            <Plus size={16} /> Add Admin
          </button>
        }
      />

      {loading ? (
        <div className="text-center py-12 text-gray-400">Loading…</div>
      ) : admins.length === 0 ? (
        <div className="text-center py-16 text-gray-400">
          <ShieldCheck size={32} className="mx-auto mb-3 text-gray-300" />
          <div>No admins in Firestore yet. Add yourself first.</div>
        </div>
      ) : (
        <div className="bg-white rounded-xl border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 text-gray-500 text-xs uppercase">
              <tr>
                <th className="px-4 py-3 text-left">Email</th>
                <th className="px-4 py-3 text-left">UID</th>
                <th className="px-4 py-3 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {admins.map(a => (
                <tr key={a.uid} className="hover:bg-gray-50/50">
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-2">
                      <ShieldCheck size={14} className="text-[#3B1500]" />
                      <span className="font-medium text-gray-800">{a.email}</span>
                      {a.uid === currentUid && (
                        <span className="text-xs bg-green-50 text-green-700 px-2 py-0.5 rounded-full">You</span>
                      )}
                    </div>
                  </td>
                  <td className="px-4 py-3 text-gray-400 font-mono text-xs">{a.uid}</td>
                  <td className="px-4 py-3 text-right">
                    {a.uid !== currentUid && (
                      <button
                        onClick={() => remove(a.uid)}
                        className="p-1.5 rounded-lg hover:bg-red-50 text-gray-400 hover:text-red-600 transition-colors"
                        title="Remove admin access"
                      >
                        <Trash2 size={14} />
                      </button>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* Modal */}
      {modalOpen && (
        <Modal
          title="Add Admin User"
          onClose={() => setModalOpen(false)}
          footer={
            created ? (
              <div className="flex justify-end gap-3">
                <button
                  onClick={copyCredentials}
                  className="flex items-center gap-2 px-4 py-2 text-sm border border-gray-200 rounded-lg hover:bg-gray-50 text-gray-700"
                >
                  {copied ? <Check size={14} className="text-green-600" /> : <Copy size={14} />}
                  {copied ? 'Copied!' : 'Copy Credentials'}
                </button>
                <button onClick={() => setModalOpen(false)} className="px-4 py-2 text-sm bg-[#3B1500] text-white rounded-lg hover:bg-[#5a2200]">
                  Done
                </button>
              </div>
            ) : (
              <div className="flex justify-end gap-3">
                <button onClick={() => setModalOpen(false)} className="px-4 py-2 text-sm text-gray-600 hover:text-gray-900">
                  Cancel
                </button>
                <button
                  onClick={mode === 'create' ? saveCreate : saveExisting}
                  disabled={saving || (mode === 'create' ? (!createForm.email || !createForm.password) : (!existingForm.email || !existingForm.uid))}
                  className="px-4 py-2 text-sm bg-[#3B1500] text-white rounded-lg hover:bg-[#5a2200] disabled:opacity-50 transition-colors"
                >
                  {saving ? 'Saving…' : mode === 'create' ? 'Create Admin' : 'Add Admin'}
                </button>
              </div>
            )
          }
        >
          {/* Mode tabs */}
          {!created && (
            <div className="flex gap-2 mb-5 p-1 bg-gray-100 rounded-lg">
              <button
                onClick={() => switchMode('create')}
                className={`flex-1 flex items-center justify-center gap-2 py-2 rounded-md text-sm font-medium transition-colors ${
                  mode === 'create' ? 'bg-white text-gray-900 shadow-sm' : 'text-gray-500 hover:text-gray-700'
                }`}
              >
                <UserPlus size={14} /> New Account
              </button>
              <button
                onClick={() => switchMode('existing')}
                className={`flex-1 flex items-center justify-center gap-2 py-2 rounded-md text-sm font-medium transition-colors ${
                  mode === 'existing' ? 'bg-white text-gray-900 shadow-sm' : 'text-gray-500 hover:text-gray-700'
                }`}
              >
                <UserCheck size={14} /> Existing Account
              </button>
            </div>
          )}

          {created ? (
            /* Success */
            <div className="space-y-4">
              <div className="flex items-center gap-2 text-green-700 bg-green-50 border border-green-200 rounded-lg px-4 py-3">
                <Check size={16} />
                <span className="text-sm font-medium">Admin account created successfully!</span>
              </div>
              <p className="text-sm text-gray-600">Share these credentials with the new admin:</p>
              <div className="bg-gray-50 border border-gray-200 rounded-lg p-4 space-y-2 font-mono text-sm">
                <div><span className="text-gray-400">Login URL: </span><span className="text-[#3B1500]">https://herdiq-prod.web.app</span></div>
                <div><span className="text-gray-400">Email: </span><span className="text-gray-800">{created.email}</span></div>
                <div><span className="text-gray-400">Password: </span><span className="text-gray-800">{created.password}</span></div>
              </div>
              <p className="text-xs text-amber-700 bg-amber-50 border border-amber-200 rounded-lg px-3 py-2">
                Copy and share these credentials now — the password won't be shown again.
              </p>
            </div>
          ) : mode === 'create' ? (
            /* Create new account */
            <div className="space-y-4">
              <div>
                <label className="block text-xs font-medium text-gray-600 mb-1">Email Address *</label>
                <input
                  type="email"
                  className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
                  value={createForm.email}
                  onChange={e => { setCreateForm(p => ({ ...p, email: e.target.value })); setError('') }}
                  placeholder="newadmin@example.com"
                />
              </div>
              <div>
                <label className="block text-xs font-medium text-gray-600 mb-1">Password *</label>
                <div className="relative">
                  <input
                    type={showPassword ? 'text' : 'password'}
                    className="w-full border border-gray-200 rounded-lg px-3 py-2 pr-10 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
                    value={createForm.password}
                    onChange={e => { setCreateForm(p => ({ ...p, password: e.target.value })); setError('') }}
                    placeholder="Minimum 6 characters"
                  />
                  <button type="button" onClick={() => setShowPassword(v => !v)} className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600">
                    {showPassword ? <EyeOff size={14} /> : <Eye size={14} />}
                  </button>
                </div>
              </div>
              <div>
                <label className="block text-xs font-medium text-gray-600 mb-1">Confirm Password *</label>
                <input
                  type="password"
                  className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
                  value={createForm.confirmPassword}
                  onChange={e => { setCreateForm(p => ({ ...p, confirmPassword: e.target.value })); setError('') }}
                  placeholder="Repeat password"
                />
              </div>
              {error && <p className="text-xs text-red-600 bg-red-50 border border-red-200 rounded-lg px-3 py-2">{error}</p>}
            </div>
          ) : (
            /* Add existing account */
            <div className="space-y-4">
              <p className="text-sm text-gray-500">For accounts that already exist in Firebase. Get the UID from Firebase Console → Authentication → Users.</p>
              <div>
                <label className="block text-xs font-medium text-gray-600 mb-1">Email Address *</label>
                <input
                  type="email"
                  className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
                  value={existingForm.email}
                  onChange={e => { setExistingForm(p => ({ ...p, email: e.target.value })); setError('') }}
                  placeholder="their@email.com"
                />
              </div>
              <div>
                <label className="block text-xs font-medium text-gray-600 mb-1">Firebase UID *</label>
                <input
                  className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
                  value={existingForm.uid}
                  onChange={e => { setExistingForm(p => ({ ...p, uid: e.target.value })); setError('') }}
                  placeholder="e.g. imi48i5pxcRpxOf8kNLNFL9b5LG2"
                />
              </div>
              {error && <p className="text-xs text-red-600 bg-red-50 border border-red-200 rounded-lg px-3 py-2">{error}</p>}
            </div>
          )}
        </Modal>
      )}
    </div>
  )
}
