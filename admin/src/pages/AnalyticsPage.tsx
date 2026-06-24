import { useEffect, useState } from 'react'
import { collection, getDocs } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import StatCard from '../components/StatCard'
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, PieChart, Pie, Cell, Legend } from 'recharts'
import { Download } from 'lucide-react'

const COLORS = ['#22c55e', '#eab308', '#f97316', '#3b82f6', '#a855f7', '#ef4444', '#06b6d4']

export default function AnalyticsPage() {
  const [loading, setLoading] = useState(true)
  const [totals, setTotals] = useState({ animals: 0, health: 0, weight: 0, breeding: 0, ownership: 0 })
  const [bySpecies, setBySpecies] = useState<{ name: string; count: number }[]>([])
  const [byStatus, setByStatus] = useState<{ name: string; count: number }[]>([])
  const [byCountry, setByCountry] = useState<{ name: string; count: number }[]>([])

  useEffect(() => { load() }, [])

  const load = async () => {
    try {
      const orgsSnap = await getDocs(collection(db, 'organizations'))
      let animals = 0, health = 0, weight = 0, breeding = 0, ownership = 0
      const species: Record<string, number> = {}
      const status: Record<string, number> = {}
      const country: Record<string, number> = {}

      for (const org of orgsSnap.docs) {
        const orgData = org.data()
        const c = orgData.country ?? 'Unknown'
        country[c] = (country[c] ?? 0) + 1

        const [aSnap, hSnap, wSnap, bSnap, oSnap] = await Promise.all([
          getDocs(collection(db, 'organizations', org.id, 'animals')),
          getDocs(collection(db, 'organizations', org.id, 'healthRecords')),
          getDocs(collection(db, 'organizations', org.id, 'weightRecords')),
          getDocs(collection(db, 'organizations', org.id, 'breedingRecords')),
          getDocs(collection(db, 'organizations', org.id, 'ownershipRecords')),
        ])
        animals += aSnap.size
        health += hSnap.size
        weight += wSnap.size
        breeding += bSnap.size
        ownership += oSnap.size

        aSnap.docs.forEach(d => {
          const sp = d.data().species ?? 'unknown'
          species[sp] = (species[sp] ?? 0) + 1
          const st = d.data().status ?? 'unknown'
          status[st] = (status[st] ?? 0) + 1
        })
      }

      setTotals({ animals, health, weight, breeding, ownership })
      setBySpecies(Object.entries(species).map(([name, count]) => ({ name, count })))
      setByStatus(Object.entries(status).map(([name, count]) => ({ name, count })))
      setByCountry(Object.entries(country).map(([name, count]) => ({ name, count })))
    } finally {
      setLoading(false)
    }
  }

  const exportCSV = () => {
    const rows = [
      ['Metric', 'Value'],
      ['Total Animals', totals.animals],
      ['Health Records', totals.health],
      ['Weight Records', totals.weight],
      ['Breeding Records', totals.breeding],
      ['Ownership Transfers', totals.ownership],
      [''],
      ['Species', 'Count'],
      ...bySpecies.map(r => [r.name, r.count]),
      [''],
      ['Status', 'Count'],
      ...byStatus.map(r => [r.name, r.count]),
    ]
    const csv = rows.map(r => r.join(',')).join('\n')
    const blob = new Blob([csv], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `herdiq_analytics_${new Date().toISOString().split('T')[0]}.csv`
    a.click()
  }

  return (
    <div>
      <PageHeader
        title="Analytics"
        subtitle="Platform-wide statistics"
        action={
          <button onClick={exportCSV} className="flex items-center gap-2 bg-white border border-gray-200 text-gray-700 px-4 py-2 rounded-lg text-sm font-medium hover:bg-gray-50">
            <Download size={16} /> Export CSV
          </button>
        }
      />
      <div className="p-8 space-y-8">
        <div className="grid grid-cols-2 lg:grid-cols-5 gap-4">
          <StatCard label="Animals" value={loading ? '…' : totals.animals} icon="🐄" color="bg-green-50" />
          <StatCard label="Health Records" value={loading ? '…' : totals.health} icon="🏥" color="bg-blue-50" />
          <StatCard label="Weight Records" value={loading ? '…' : totals.weight} icon="⚖️" color="bg-purple-50" />
          <StatCard label="Breeding Records" value={loading ? '…' : totals.breeding} icon="🧬" color="bg-pink-50" />
          <StatCard label="Transfers" value={loading ? '…' : totals.ownership} icon="🔄" color="bg-amber-50" />
        </div>

        {!loading && (
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            {/* By Species */}
            <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
              <h2 className="font-semibold text-gray-900 mb-4">Animals by Species</h2>
              <ResponsiveContainer width="100%" height={200}>
                <BarChart data={bySpecies}>
                  <XAxis dataKey="name" tick={{ fontSize: 11 }} />
                  <YAxis tick={{ fontSize: 11 }} />
                  <Tooltip />
                  <Bar dataKey="count" radius={[4, 4, 0, 0]}>
                    {bySpecies.map((_, i) => <Cell key={i} fill={COLORS[i % COLORS.length]} />)}
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>

            {/* By Status */}
            <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
              <h2 className="font-semibold text-gray-900 mb-4">Animals by Status</h2>
              <ResponsiveContainer width="100%" height={200}>
                <PieChart>
                  <Pie data={byStatus} dataKey="count" nameKey="name" cx="50%" cy="50%" outerRadius={75}>
                    {byStatus.map((_, i) => <Cell key={i} fill={COLORS[i % COLORS.length]} />)}
                  </Pie>
                  <Legend iconSize={10} />
                  <Tooltip />
                </PieChart>
              </ResponsiveContainer>
            </div>

            {/* By Country */}
            <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
              <h2 className="font-semibold text-gray-900 mb-4">Orgs by Country</h2>
              <ResponsiveContainer width="100%" height={200}>
                <BarChart data={byCountry} layout="vertical">
                  <XAxis type="number" tick={{ fontSize: 11 }} />
                  <YAxis dataKey="name" type="category" tick={{ fontSize: 11 }} width={70} />
                  <Tooltip />
                  <Bar dataKey="count" radius={[0, 4, 4, 0]}>
                    {byCountry.map((_, i) => <Cell key={i} fill={COLORS[i % COLORS.length]} />)}
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
