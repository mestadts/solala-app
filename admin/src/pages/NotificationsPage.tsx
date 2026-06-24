import { useState } from 'react'
import { getFunctions, httpsCallable } from 'firebase/functions'
import PageHeader from '../components/PageHeader'
import { Send } from 'lucide-react'

export default function NotificationsPage() {
  const [title, setTitle] = useState('')
  const [body, setBody] = useState('')
  const [target, setTarget] = useState('all')
  const [country, setCountry] = useState('SA')
  const [sending, setSending] = useState(false)
  const [sent, setSent] = useState(false)
  const [error, setError] = useState('')

  const handleSend = async () => {
    if (!title || !body) return
    setSending(true)
    setError('')
    try {
      const functions = getFunctions(undefined, 'us-central1')
      const broadcast = httpsCallable(functions, 'broadcastNotification')
      await broadcast({ title, body, target, country: target === 'country' ? country : null })
      setSent(true)
      setTimeout(() => setSent(false), 3000)
      setTitle('')
      setBody('')
    } catch (e: any) {
      setError(e?.message ?? 'Failed to send notification.')
    } finally {
      setSending(false)
    }
  }

  return (
    <div>
      <PageHeader title="Broadcast Notifications" subtitle="Send push notifications to all users or by country" />
      <div className="p-8 max-w-xl">
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6 space-y-5">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Target Audience</label>
            <select value={target} onChange={e => setTarget(e.target.value)}
              className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20">
              <option value="all">All Users</option>
              <option value="country">By Country</option>
            </select>
          </div>

          {target === 'country' && (
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Country</label>
              <select value={country} onChange={e => setCountry(e.target.value)}
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20">
                <option value="SA">🇸🇦 Saudi Arabia</option>
                <option value="AE">🇦🇪 UAE</option>
                <option value="KW">🇰🇼 Kuwait</option>
                <option value="QA">🇶🇦 Qatar</option>
              </select>
            </div>
          )}

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Notification Title <span className="text-red-500">*</span></label>
            <input value={title} onChange={e => setTitle(e.target.value)}
              className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
              placeholder="e.g. New Feature Available" />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Message <span className="text-red-500">*</span></label>
            <textarea value={body} onChange={e => setBody(e.target.value)} rows={4}
              className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20 resize-none"
              placeholder="Write your notification message here…" />
          </div>

          {sent && (
            <div className="bg-green-50 text-green-700 text-sm px-4 py-3 rounded-lg">
              ✅ Notification sent successfully.
            </div>
          )}

          {error && (
            <div className="bg-red-50 text-red-600 text-sm px-4 py-3 rounded-lg">{error}</div>
          )}

          <button
            onClick={handleSend}
            disabled={!title || !body || sending}
            className="flex items-center gap-2 bg-[#3B1500] text-white px-5 py-2.5 rounded-lg text-sm font-medium hover:bg-[#5a2200] disabled:opacity-60 transition-colors"
          >
            <Send size={15} />
            {sending ? 'Sending…' : 'Send Notification'}
          </button>
        </div>
      </div>
    </div>
  )
}
