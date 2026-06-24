import { useEffect, useState } from 'react'
import { collection, getDocs } from 'firebase/firestore'
import { db } from '../firebase/config'
import StatCard from '../components/StatCard'
import PageHeader from '../components/PageHeader'
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, PieChart, Pie, Cell, Legend } from 'recharts'

const SPECIES_COLORS: Record<string, string> = {
  sheep: '#22c55e',
  goat: '#eab308',
  camel: '#f97316',
  cow: '#3b82f6',
  horse: '#a855f7',
}

const SPECIES_LABELS: Record<string, string> = {
  sheep: 'Sheep', goat: 'Goat', camel: 'Camel', cow: 'Cow', horse: 'Horse',
}

export default function DashboardPage() {
  const [stats, setStats] = useState({ users: 0, orgs: 0, animals: 0, health: 0 })
  const [speciesData, setSpeciesData] = useState<{ name: string; value: number; color: string }[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function load() {
      try {
        const [usersSnap, orgsSnap] = await Promise.all([
          getDocs(collection(db, 'users')),
          getDocs(collection(db, 'organizations')),
        ])

        // Count animals across all orgs
        let animalCount = 0
        let healthCount = 0
        const speciesCounts: Record<string, number> = {}

        for (const org of orgsSnap.docs) {
          const animalsSnap = await getDocs(collection(db, 'organizations', org.id, 'animals'))
          animalCount += animalsSnap.size
          animalsSnap.docs.forEach(d => {
            const sp = d.data().species as string
            speciesCounts[sp] = (speciesCounts[sp] ?? 0) + 1
          })
          const healthSnap = await getDocs(collection(db, 'organizations', org.id, 'healthRecords'))
          healthCount += healthSnap.size
        }

        setStats({
          users: usersSnap.size,
          orgs: orgsSnap.size,
          animals: animalCount,
          health: healthCount,
        })

        setSpeciesData(
          Object.entries(speciesCounts).map(([sp, val]) => ({
            name: SPECIES_LABELS[sp] ?? sp,
            value: val,
            color: SPECIES_COLORS[sp] ?? '#8B6340',
          }))
        )
      } catch (err) {
        console.error(err)
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [])

  return (
    <div>
      <PageHeader title="Dashboard" subtitle="Platform overview" />
      <div className="p-8 space-y-8">
        {/* Stat Cards */}
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
          <StatCard label="Total Users" value={loading ? '…' : stats.users} icon="👤" color="bg-blue-50" />
          <StatCard label="Organizations" value={loading ? '…' : stats.orgs} icon="🏢" color="bg-amber-50" />
          <StatCard label="Total Animals" value={loading ? '…' : stats.animals} icon="🐄" color="bg-green-50" />
          <StatCard label="Health Records" value={loading ? '…' : stats.health} icon="🏥" color="bg-purple-50" />
        </div>

        {/* Charts */}
        {!loading && speciesData.length > 0 && (
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {/* Bar chart */}
            <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
              <h2 className="font-semibold text-gray-900 mb-4">Animals by Species</h2>
              <ResponsiveContainer width="100%" height={220}>
                <BarChart data={speciesData}>
                  <XAxis dataKey="name" tick={{ fontSize: 12 }} />
                  <YAxis tick={{ fontSize: 12 }} />
                  <Tooltip />
                  <Bar dataKey="value" radius={[6, 6, 0, 0]}>
                    {speciesData.map((entry, i) => (
                      <Cell key={i} fill={entry.color} />
                    ))}
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>

            {/* Pie chart */}
            <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
              <h2 className="font-semibold text-gray-900 mb-4">Species Distribution</h2>
              <ResponsiveContainer width="100%" height={220}>
                <PieChart>
                  <Pie data={speciesData} dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={80} label>
                    {speciesData.map((entry, i) => (
                      <Cell key={i} fill={entry.color} />
                    ))}
                  </Pie>
                  <Legend />
                  <Tooltip />
                </PieChart>
              </ResponsiveContainer>
            </div>
          </div>
        )}

        {!loading && speciesData.length === 0 && (
          <div className="bg-white rounded-xl p-10 text-center text-gray-400 shadow-sm border border-gray-100">
            No animal data yet. Charts will appear once animals are added.
          </div>
        )}
      </div>
    </div>
  )
}
