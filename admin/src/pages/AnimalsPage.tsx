import { useEffect, useState } from 'react'
import { collection, getDocs } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Pagination from '../components/Pagination'
import { Search } from 'lucide-react'

interface AnimalResult {
  id: string
  systemAnimalId: string
  name: string
  species: string
  status: string
  orgId: string
  orgName?: string
  breederTag: string | number
  breed: string
}

const PAGE_SIZE = 20

const speciesEmoji: Record<string, string> = {
  sheep: '🐑', goat: '🐐', camel: '🐪', cow: '🐄', horse: '🐎',
}

export default function AnimalsPage() {
  const [all, setAll] = useState<AnimalResult[]>([])
  const [filtered, setFiltered] = useState<AnimalResult[]>([])
  const [search, setSearch] = useState('')
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [page, setPage] = useState(1)

  useEffect(() => {
    async function load() {
      try {
        const orgsSnap = await getDocs(collection(db, 'organizations'))
        const found: AnimalResult[] = []
        for (const org of orgsSnap.docs) {
          const orgName = org.data().name ?? org.id
          const animalsSnap = await getDocs(collection(db, 'organizations', org.id, 'animals'))
          animalsSnap.docs.forEach(d => {
            found.push({ id: d.id, orgId: org.id, orgName, ...d.data() } as AnimalResult)
          })
        }
        found.sort((a, b) => (a.systemAnimalId ?? '').localeCompare(b.systemAnimalId ?? ''))
        setAll(found)
        setFiltered(found)
      } catch (err: any) {
        setError(err?.code === 'permission-denied'
          ? 'Permission denied — Firestore rules may not be deployed or your UID is not in the admins collection.'
          : `Error: ${err?.message ?? String(err)}`)
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [])

  useEffect(() => {
    const q = search.toLowerCase()
    setFiltered(q ? all.filter(a =>
      a.systemAnimalId?.toLowerCase().includes(q) ||
      a.name?.toLowerCase().includes(q) ||
      String(a.breederTag).includes(q) ||
      a.orgName?.toLowerCase().includes(q) ||
      a.species?.toLowerCase().includes(q)
    ) : all)
    setPage(1)
  }, [search, all])

  const paginated = filtered.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE)

  return (
    <div>
      <PageHeader title="Animals" subtitle={loading ? 'Loading…' : `${all.length} animals across all organizations`} />
      <div className="p-8 space-y-4">
        <div className="relative max-w-sm">
          <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            value={search}
            onChange={e => setSearch(e.target.value)}
            placeholder="Search by ID, name, tag, org…"
            className="w-full pl-9 pr-4 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">System ID</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Name</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Species</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Breed</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Tag</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Status</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Organization</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {loading && (
                <tr><td colSpan={7} className="px-5 py-8 text-center text-gray-400">Loading…</td></tr>
              )}
              {!loading && paginated.map(a => (
                <tr key={`${a.orgId}-${a.id}`} className="hover:bg-gray-50/50">
                  <td className="px-5 py-3 font-mono text-xs text-gray-700">{a.systemAnimalId || '—'}</td>
                  <td className="px-5 py-3 font-medium text-gray-900">{a.name || '—'}</td>
                  <td className="px-5 py-3">{speciesEmoji[a.species] ?? ''} <span className="capitalize text-gray-600">{a.species}</span></td>
                  <td className="px-5 py-3 text-gray-600 text-xs">{a.breed || '—'}</td>
                  <td className="px-5 py-3 text-gray-600">{a.breederTag || '—'}</td>
                  <td className="px-5 py-3">
                    <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${
                      a.status === 'active' ? 'bg-green-50 text-green-700' : 'bg-gray-100 text-gray-600'
                    }`}>
                      {a.status}
                    </span>
                  </td>
                  <td className="px-5 py-3 text-gray-600 text-xs">{a.orgName || a.orgId}</td>
                </tr>
              ))}
              {!loading && error && (
                <tr><td colSpan={7} className="px-5 py-8 text-center text-red-500 text-sm">{error}</td></tr>
              )}
              {!loading && !error && filtered.length === 0 && (
                <tr>
                  <td colSpan={7} className="px-5 py-8 text-center text-gray-400">
                    {search ? `No animals matching "${search}".` : 'No animals found.'}
                  </td>
                </tr>
              )}
            </tbody>
          </table>
          <Pagination page={page} total={filtered.length} pageSize={PAGE_SIZE} onChange={setPage} />
        </div>
      </div>
    </div>
  )
}
