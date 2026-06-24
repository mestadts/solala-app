import { useEffect, useState } from 'react'
import { collection, getDocs, doc, updateDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Pagination from '../components/Pagination'
import { Search, UserCheck, UserX } from 'lucide-react'
import type { UserSummary } from '../types'

const PAGE_SIZE = 20

export default function UsersPage() {
  const [users, setUsers] = useState<UserSummary[]>([])
  const [filtered, setFiltered] = useState<UserSummary[]>([])
  const [search, setSearch] = useState('')
  const [loading, setLoading] = useState(true)
  const [page, setPage] = useState(1)

  useEffect(() => {
    getDocs(collection(db, 'users'))
      .then(snap => {
        const data = snap.docs.map(d => ({ id: d.id, ...d.data() } as UserSummary))
        setUsers(data)
        setFiltered(data)
      })
      .catch(err => console.error('Failed to load users:', err))
      .finally(() => setLoading(false))
  }, [])

  useEffect(() => {
    const q = search.toLowerCase()
    setFiltered(users.filter(u =>
      u.displayName?.toLowerCase().includes(q) ||
      u.phone?.includes(q) ||
      u.country?.toLowerCase().includes(q)
    ))
    setPage(1)
  }, [search, users])

  const toggleDisabled = async (user: UserSummary) => {
    await updateDoc(doc(db, 'users', user.id), { isDisabled: !user.isDisabled })
    setUsers(prev => prev.map(u => u.id === user.id ? { ...u, isDisabled: !u.isDisabled } : u))
  }

  const paginated = filtered.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE)

  return (
    <div>
      <PageHeader title="Users" subtitle={`${users.length} registered users`} />
      <div className="p-8 space-y-4">
        {/* Search */}
        <div className="relative max-w-sm">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            value={search}
            onChange={e => setSearch(e.target.value)}
            placeholder="Search by name, phone, country…"
            className="w-full pl-9 pr-4 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
          />
        </div>

        {/* Table */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Name</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Phone</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Country</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Orgs</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Status</th>
                <th className="px-5 py-3" />
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {loading && (
                <tr><td colSpan={6} className="px-5 py-8 text-center text-gray-400">Loading…</td></tr>
              )}
              {!loading && paginated.map(user => (
                <tr key={user.id} className="hover:bg-gray-50/50">
                  <td className="px-5 py-3 font-medium text-gray-900">{user.displayName || '—'}</td>
                  <td className="px-5 py-3 text-gray-600">{user.phone || '—'}</td>
                  <td className="px-5 py-3 text-gray-600">{user.country || '—'}</td>
                  <td className="px-5 py-3 text-gray-600">{user.organizationIds?.length ?? 0}</td>
                  <td className="px-5 py-3">
                    <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${user.isDisabled ? 'bg-red-50 text-red-600' : 'bg-green-50 text-green-700'}`}>
                      {user.isDisabled ? 'Disabled' : 'Active'}
                    </span>
                  </td>
                  <td className="px-5 py-3 text-right">
                    <button
                      onClick={() => toggleDisabled(user)}
                      className="text-gray-400 hover:text-gray-700 p-1 rounded"
                      title={user.isDisabled ? 'Enable' : 'Disable'}
                    >
                      {user.isDisabled ? <UserCheck size={16} /> : <UserX size={16} />}
                    </button>
                  </td>
                </tr>
              ))}
              {!loading && filtered.length === 0 && (
                <tr><td colSpan={6} className="px-5 py-8 text-center text-gray-400">No users found.</td></tr>
              )}
            </tbody>
          </table>
          <Pagination page={page} total={filtered.length} pageSize={PAGE_SIZE} onChange={setPage} />
        </div>
      </div>
    </div>
  )
}
