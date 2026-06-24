import { useEffect, useState } from 'react'
import { collection, getDocs } from 'firebase/firestore'
import { useNavigate } from 'react-router-dom'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Pagination from '../components/Pagination'
import { Search, ChevronRight } from 'lucide-react'
import type { OrgSummary } from '../types'

const PAGE_SIZE = 20

export default function OrganizationsPage() {
  const navigate = useNavigate()
  const [orgs, setOrgs] = useState<OrgSummary[]>([])
  const [filtered, setFiltered] = useState<OrgSummary[]>([])
  const [search, setSearch] = useState('')
  const [loading, setLoading] = useState(true)
  const [page, setPage] = useState(1)

  useEffect(() => {
    async function load() {
      try {
        const snap = await getDocs(collection(db, 'organizations'))
        const data: OrgSummary[] = []
        for (const d of snap.docs) {
          const animalsSnap = await getDocs(collection(db, 'organizations', d.id, 'animals'))
          data.push({ id: d.id, ...d.data(), animalCount: animalsSnap.size } as OrgSummary)
        }
        setOrgs(data)
        setFiltered(data)
      } catch (err) {
        console.error('Failed to load organizations:', err)
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [])

  useEffect(() => {
    const q = search.toLowerCase()
    setFiltered(orgs.filter(o =>
      o.name?.toLowerCase().includes(q) ||
      o.country?.toLowerCase().includes(q) ||
      o.type?.toLowerCase().includes(q)
    ))
    setPage(1)
  }, [search, orgs])

  const paginated = filtered.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE)

  return (
    <div>
      <PageHeader title="Organizations" subtitle={`${orgs.length} organizations`} />
      <div className="p-8 space-y-4">
        <div className="relative max-w-sm">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            value={search}
            onChange={e => setSearch(e.target.value)}
            placeholder="Search by name, country, type…"
            className="w-full pl-9 pr-4 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Name</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Location</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Workers</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Animals</th>
                <th className="px-5 py-3" />
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {loading && (
                <tr><td colSpan={5} className="px-5 py-8 text-center text-gray-400">Loading…</td></tr>
              )}
              {!loading && paginated.map(org => (
                <tr
                  key={org.id}
                  className="hover:bg-gray-50/50 cursor-pointer"
                  onClick={() => navigate(`/organizations/${org.id}`)}
                >
                  <td className="px-5 py-3 font-medium text-gray-900">{org.name || '—'}</td>
                  <td className="px-5 py-3 text-gray-600">{(org as any).location || '—'}</td>
                  <td className="px-5 py-3 text-gray-600">{org.workerIds?.length ?? 0}</td>
                  <td className="px-5 py-3 text-gray-600">{org.animalCount ?? 0}</td>
                  <td className="px-5 py-3 text-gray-400"><ChevronRight size={16} /></td>
                </tr>
              ))}
              {!loading && filtered.length === 0 && (
                <tr><td colSpan={5} className="px-5 py-8 text-center text-gray-400">No organizations found.</td></tr>
              )}
            </tbody>
          </table>
          <Pagination page={page} total={filtered.length} pageSize={PAGE_SIZE} onChange={setPage} />
        </div>
      </div>
    </div>
  )
}
