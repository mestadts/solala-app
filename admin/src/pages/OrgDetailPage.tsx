import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { doc, getDoc, collection, getDocs, setDoc, deleteDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import Pagination from '../components/Pagination'
import { ArrowLeft, MapPin, User, Users, Hash, Tag, RotateCcw, Save } from 'lucide-react'

interface OrgData {
  name: string
  location: string
  ownerUserId: string
  workerIds: string[]
  createdAt?: { seconds: number }
}

interface Animal {
  id: string
  systemAnimalId: string
  name: string
  species: string
  breed: string
  gender: string
  status: string
  breederTag: string
  dateOfBirth: string
  colorId: string
}

interface HealthRecord {
  id: string
  recordType: string
  date: string
  nextDue?: string
  animalId: string
  vaccineName?: string
  dewormingProduct?: string
  dewormingDose?: string
  treatmentType?: string
  medications?: string[]
  vetName?: string
  notes?: string
}

interface BreedingRecord {
  id: string
  damSystemId?: string
  damTagDisplay?: string
  sireSystemId?: string
  sireTagDisplay?: string
  matingDate?: string
  deliveryDate?: string
  offspringCount?: number
  survivingCount?: number
  malesBorn?: number
  femalesBorn?: number
  notes?: string
}

interface WeightRecord {
  id: string
  animalId: string
  value: number
  unit: string
  recordedAt: string
  isOfficial?: boolean
  notes?: string
}

interface OwnershipRecord {
  id: string
  animalId: string
  transferType: string
  toOwnerName?: string
  toOwnerPhone?: string
  salePrice?: number
  currency?: string
  transferDate?: string
  notes?: string
}

const speciesEmoji: Record<string, string> = {
  sheep: '🐑', goat: '🐐', camel: '🐪', cow: '🐄', horse: '🐎',
}

const PAGE_SIZE = 20

type Tab = 'animals' | 'health' | 'breeding' | 'weight' | 'ownership' | 'labels'

export default function OrgDetailPage() {
  const params = useParams<{ orgId: string }>()
  const orgId = params.orgId!
  const navigate = useNavigate()

  const [org, setOrg] = useState<OrgData | null>(null)
  const [animals, setAnimals] = useState<Animal[]>([])
  const [healthRecords, setHealthRecords] = useState<HealthRecord[]>([])
  const [breedingRecords, setBreedingRecords] = useState<BreedingRecord[]>([])
  const [weightRecords, setWeightRecords] = useState<WeightRecord[]>([])
  const [ownershipRecords, setOwnershipRecords] = useState<OwnershipRecord[]>([])
  const [ownerName, setOwnerName] = useState<string>('')
  const [loading, setLoading] = useState(true)
  const [activeTab, setActiveTab] = useState<Tab>('animals')
  const [animalSearch, setAnimalSearch] = useState('')
  const [animalPage, setAnimalPage] = useState(1)
  const [healthPage, setHealthPage] = useState(1)
  const [breedingPage, setBreedingPage] = useState(1)
  const [weightPage, setWeightPage] = useState(1)
  const [ownershipPage, setOwnershipPage] = useState(1)

  // Field labels state
  interface FieldLabels {
    tagLabelAr: string; tagLabelEn: string
    tagColorLabelAr: string; tagColorLabelEn: string
    animalColorLabelAr: string; animalColorLabelEn: string
    breedLabelAr: string; breedLabelEn: string
    penLabelAr: string; penLabelEn: string
  }
  const emptyLabels: FieldLabels = {
    tagLabelAr: '', tagLabelEn: '',
    tagColorLabelAr: '', tagColorLabelEn: '',
    animalColorLabelAr: '', animalColorLabelEn: '',
    breedLabelAr: '', breedLabelEn: '',
    penLabelAr: '', penLabelEn: '',
  }
  const [labels, setLabels] = useState<FieldLabels>(emptyLabels)
  const [labelsLoaded, setLabelsLoaded] = useState(false)
  const [labelsSaving, setLabelsSaving] = useState(false)
  const [labelsSavedMsg, setLabelsSavedMsg] = useState('')

  useEffect(() => {
    if (!orgId) { setLoading(false); return; }
    async function load() {
      try {
        const orgSnap = await getDoc(doc(db, 'organizations', orgId))
        if (!orgSnap.exists()) { setLoading(false); return }
        const orgData = orgSnap.data() as OrgData
        setOrg(orgData)

        if (orgData.ownerUserId) {
          const userSnap = await getDoc(doc(db, 'users', orgData.ownerUserId))
          if (userSnap.exists()) setOwnerName(userSnap.data().displayName ?? orgData.ownerUserId)
          else setOwnerName(orgData.ownerUserId)
        }

        const [animalsSnap, healthSnap, breedingSnap, weightSnap, ownershipSnap] = await Promise.all([
          getDocs(collection(db, 'organizations', orgId, 'animals')),
          getDocs(collection(db, 'organizations', orgId, 'healthRecords')),
          getDocs(collection(db, 'organizations', orgId, 'breedingRecords')),
          getDocs(collection(db, 'organizations', orgId, 'weightRecords')),
          getDocs(collection(db, 'organizations', orgId, 'ownershipRecords')),
        ])

        const animalList = animalsSnap.docs.map(d => ({ id: d.id, ...d.data() } as Animal))
        animalList.sort((a, b) => (a.systemAnimalId ?? '').localeCompare(b.systemAnimalId ?? ''))
        setAnimals(animalList)

        const healthList = healthSnap.docs.map(d => ({ id: d.id, ...d.data() } as HealthRecord))
        healthList.sort((a, b) => (b.date ?? '').localeCompare(a.date ?? ''))
        setHealthRecords(healthList)

        const breedingList = breedingSnap.docs.map(d => ({ id: d.id, ...d.data() } as BreedingRecord))
        breedingList.sort((a, b) => (b.matingDate ?? '').localeCompare(a.matingDate ?? ''))
        setBreedingRecords(breedingList)

        const weightList = weightSnap.docs.map(d => ({ id: d.id, ...d.data() } as WeightRecord))
        weightList.sort((a, b) => (b.recordedAt ?? '').localeCompare(a.recordedAt ?? ''))
        setWeightRecords(weightList)

        const ownershipList = ownershipSnap.docs.map(d => ({ id: d.id, ...d.data() } as OwnershipRecord))
        ownershipList.sort((a, b) => (b.transferDate ?? '').localeCompare(a.transferDate ?? ''))
        setOwnershipRecords(ownershipList)

        try {
          const labelsSnap = await getDoc(doc(db, 'organizations', orgId, 'config', 'fieldLabels'))
          if (labelsSnap.exists()) {
            const d = labelsSnap.data()
            setLabels({
              tagLabelAr: d.tagLabelAr ?? '', tagLabelEn: d.tagLabelEn ?? '',
              tagColorLabelAr: d.tagColorLabelAr ?? '', tagColorLabelEn: d.tagColorLabelEn ?? '',
              animalColorLabelAr: d.animalColorLabelAr ?? '', animalColorLabelEn: d.animalColorLabelEn ?? '',
              breedLabelAr: d.breedLabelAr ?? '', breedLabelEn: d.breedLabelEn ?? '',
              penLabelAr: d.penLabelAr ?? '', penLabelEn: d.penLabelEn ?? '',
            })
          }
        } catch {
          // labels not accessible yet — non-fatal
        }
        setLabelsLoaded(true)
      } catch (err) {
        console.error('Failed to load org detail:', err)
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [orgId])

  const filteredAnimals = animals.filter(a => {
    const q = animalSearch.toLowerCase()
    if (!q) return true
    return (
      a.systemAnimalId?.toLowerCase().includes(q) ||
      a.name?.toLowerCase().includes(q) ||
      String(a.breederTag).includes(q) ||
      a.species?.toLowerCase().includes(q)
    )
  })

  const speciesCounts = animals.reduce<Record<string, number>>((acc, a) => {
    acc[a.species] = (acc[a.species] ?? 0) + 1
    return acc
  }, {})

  const saveLabels = async () => {
    setLabelsSaving(true)
    try {
      const payload: Record<string, string | null> = {}
      Object.entries(labels).forEach(([k, v]) => { payload[k] = v.trim() || null })
      await setDoc(doc(db, 'organizations', orgId, 'config', 'fieldLabels'), payload)
      setLabelsSavedMsg('Saved ✓')
      setTimeout(() => setLabelsSavedMsg(''), 2500)
    } finally {
      setLabelsSaving(false)
    }
  }

  const resetLabels = async () => {
    if (!confirm('Reset all field labels to defaults for this org?')) return
    await deleteDoc(doc(db, 'organizations', orgId, 'config', 'fieldLabels'))
    setLabels(emptyLabels)
    setLabelsSavedMsg('Reset to defaults ✓')
    setTimeout(() => setLabelsSavedMsg(''), 2500)
  }

  const healthTypeColor: Record<string, string> = {
    vaccination: 'bg-blue-50 text-blue-700',
    deworming:   'bg-green-50 text-green-700',
    treatment:   'bg-orange-50 text-orange-700',
    pregnancy:   'bg-pink-50 text-pink-700',
    checkup:     'bg-purple-50 text-purple-700',
  }

  if (loading) return <div className="p-8 text-center text-gray-400">Loading…</div>
  if (!org) return (
    <div className="p-8">
      <button onClick={() => navigate(-1)} className="flex items-center gap-2 text-sm text-gray-500 hover:text-gray-800 mb-6">
        <ArrowLeft size={16} /> Back
      </button>
      <p className="text-gray-500">Organization not found.</p>
    </div>
  )

  const tabs: { key: Tab; label: string; count: number }[] = [
    { key: 'animals',   label: 'Animals',   count: animals.length },
    { key: 'health',    label: 'Health',     count: healthRecords.length },
    { key: 'breeding',  label: 'Breeding',   count: breedingRecords.length },
    { key: 'weight',    label: 'Weight',     count: weightRecords.length },
    { key: 'ownership', label: 'Ownership',  count: ownershipRecords.length },
    { key: 'labels',    label: 'Field Labels', count: -1 },
  ]

  return (
    <div className="p-8 space-y-6">
      <button onClick={() => navigate(-1)} className="flex items-center gap-2 text-sm text-[#3B1500] hover:opacity-70">
        <ArrowLeft size={16} /> Organizations
      </button>

      {/* Header card */}
      <div className="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 space-y-4">
        <div className="flex items-start justify-between">
          <div>
            <h1 className="text-2xl font-bold text-[#3B1500]">{org.name || '—'}</h1>
            {org.location && (
              <div className="flex items-center gap-1.5 mt-1 text-sm text-gray-500">
                <MapPin size={14} /><span>{org.location}</span>
              </div>
            )}
          </div>
          {org.createdAt && (
            <span className="text-xs text-gray-400">
              Created {new Date(org.createdAt.seconds * 1000).toLocaleDateString()}
            </span>
          )}
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-5 gap-3 pt-2">
          {[
            { label: 'Animals',   val: animals.length },
            { label: 'Health',    val: healthRecords.length },
            { label: 'Breeding',  val: breedingRecords.length },
            { label: 'Weight',    val: weightRecords.length },
            { label: 'Transfers', val: ownershipRecords.length },
          ].map(s => (
            <div key={s.label} className="bg-[#FAF6EF] rounded-xl p-3 text-center">
              <div className="text-2xl font-bold text-[#3B1500]">{s.val}</div>
              <div className="text-xs text-gray-500 mt-1">{s.label}</div>
            </div>
          ))}
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div className="flex items-center gap-1.5 text-sm text-gray-600 bg-gray-50 rounded-lg px-3 py-2">
            <User size={14} /><span className="truncate">{ownerName || '—'}</span>
            <span className="text-xs text-gray-400 ml-auto">Owner</span>
          </div>
          <div className="flex items-center gap-1.5 text-sm text-gray-600 bg-gray-50 rounded-lg px-3 py-2">
            <Users size={14} /><span>{org.workerIds?.length ?? 0} workers</span>
          </div>
        </div>

        {Object.keys(speciesCounts).length > 0 && (
          <div className="flex flex-wrap gap-2">
            {Object.entries(speciesCounts).map(([sp, count]) => (
              <span key={sp} className="flex items-center gap-1 bg-gray-100 text-gray-700 text-xs px-3 py-1 rounded-full font-medium">
                {speciesEmoji[sp] ?? '🐾'} {sp} ({count})
              </span>
            ))}
          </div>
        )}
      </div>

      {/* Tabs */}
      <div className="flex gap-1 border-b border-gray-200 overflow-x-auto">
        {tabs.map(t => (
          <button
            key={t.key}
            onClick={() => setActiveTab(t.key)}
            className={`px-4 py-2.5 text-sm font-medium whitespace-nowrap transition-colors border-b-2 -mb-px ${
              activeTab === t.key ? 'border-[#3B1500] text-[#3B1500]' : 'border-transparent text-gray-500 hover:text-gray-700'
            }`}
          >
            {t.key === 'labels' ? <span className="flex items-center gap-1"><Tag size={13} /> Field Labels</span>
              : `${t.label} (${t.count})`}
          </button>
        ))}
      </div>

      {/* ── Animals tab ── */}
      {activeTab === 'animals' && (
        <div className="space-y-3">
          <input
            value={animalSearch}
            onChange={e => { setAnimalSearch(e.target.value); setAnimalPage(1) }}
            placeholder="Filter by ID, name, tag, species…"
            className="w-full max-w-sm px-4 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
          />
          <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
            <table className="w-full text-sm">
              <thead className="bg-gray-50 border-b border-gray-100">
                <tr>
                  <th className="text-left px-5 py-3 text-gray-500 font-medium">System ID</th>
                  <th className="text-left px-5 py-3 text-gray-500 font-medium">Name</th>
                  <th className="text-left px-5 py-3 text-gray-500 font-medium">Species</th>
                  <th className="text-left px-5 py-3 text-gray-500 font-medium">Breed</th>
                  <th className="text-left px-5 py-3 text-gray-500 font-medium">Gender</th>
                  <th className="text-left px-5 py-3 text-gray-500 font-medium">Tag</th>
                  <th className="text-left px-5 py-3 text-gray-500 font-medium">DOB</th>
                  <th className="text-left px-5 py-3 text-gray-500 font-medium">Status</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {filteredAnimals.slice((animalPage - 1) * PAGE_SIZE, animalPage * PAGE_SIZE).map(a => (
                  <tr key={a.id} className="hover:bg-gray-50/50">
                    <td className="px-5 py-3 font-mono text-xs text-gray-700">{a.systemAnimalId || '—'}</td>
                    <td className="px-5 py-3 font-medium text-gray-900">{a.name || '—'}</td>
                    <td className="px-5 py-3">{speciesEmoji[a.species] ?? ''} <span className="capitalize text-gray-600">{a.species}</span></td>
                    <td className="px-5 py-3 text-gray-600 text-xs">{a.breed || '—'}</td>
                    <td className="px-5 py-3 text-gray-600 capitalize">{a.gender || '—'}</td>
                    <td className="px-5 py-3 text-gray-600"><span className="flex items-center gap-1"><Hash size={12} />{a.breederTag || '—'}</span></td>
                    <td className="px-5 py-3 text-gray-600 text-xs">{a.dateOfBirth || '—'}</td>
                    <td className="px-5 py-3">
                      <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${a.status === 'active' ? 'bg-green-50 text-green-700' : 'bg-gray-100 text-gray-600'}`}>
                        {a.status}
                      </span>
                    </td>
                  </tr>
                ))}
                {filteredAnimals.length === 0 && (
                  <tr><td colSpan={8} className="px-5 py-8 text-center text-gray-400">No animals found.</td></tr>
                )}
              </tbody>
            </table>
            <Pagination page={animalPage} total={filteredAnimals.length} pageSize={PAGE_SIZE} onChange={setAnimalPage} />
          </div>
        </div>
      )}

      {/* ── Health tab ── */}
      {activeTab === 'health' && (
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Type</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Date</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Next Due</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Animal ID</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Details</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Vet</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Notes</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {healthRecords.slice((healthPage - 1) * PAGE_SIZE, healthPage * PAGE_SIZE).map(r => {
                const details = [
                  r.vaccineName,
                  r.dewormingProduct && `${r.dewormingProduct}${r.dewormingDose ? ` (${r.dewormingDose})` : ''}`,
                  r.treatmentType,
                  ...(r.medications ?? []),
                ].filter(Boolean).join(', ')

                return (
                  <tr key={r.id} className="hover:bg-gray-50/50">
                    <td className="px-4 py-3">
                      <span className={`capitalize text-xs px-2 py-0.5 rounded-full font-medium ${healthTypeColor[r.recordType] ?? 'bg-gray-100 text-gray-600'}`}>
                        {r.recordType}
                      </span>
                    </td>
                    <td className="px-4 py-3 text-gray-600 text-xs">{r.date || '—'}</td>
                    <td className="px-4 py-3 text-xs">
                      {r.nextDue ? (
                        <span className={`font-medium ${new Date(r.nextDue) < new Date() ? 'text-red-600' : 'text-gray-600'}`}>
                          {r.nextDue}
                        </span>
                      ) : '—'}
                    </td>
                    <td className="px-4 py-3 font-mono text-xs text-gray-400">{r.animalId}</td>
                    <td className="px-4 py-3 text-gray-700 text-xs max-w-[160px] truncate">{details || '—'}</td>
                    <td className="px-4 py-3 text-gray-600 text-xs">{r.vetName || '—'}</td>
                    <td className="px-4 py-3 text-gray-400 text-xs max-w-[120px] truncate">{r.notes || '—'}</td>
                  </tr>
                )
              })}
              {healthRecords.length === 0 && (
                <tr><td colSpan={7} className="px-5 py-8 text-center text-gray-400">No health records.</td></tr>
              )}
            </tbody>
          </table>
          <Pagination page={healthPage} total={healthRecords.length} pageSize={PAGE_SIZE} onChange={setHealthPage} />
        </div>
      )}

      {/* ── Breeding tab ── */}
      {activeTab === 'breeding' && (
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Dam (Mother)</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Sire (Father)</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Mating Date</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Delivery Date</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Offspring</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Surviving</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Notes</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {breedingRecords.slice((breedingPage - 1) * PAGE_SIZE, breedingPage * PAGE_SIZE).map(r => (
                <tr key={r.id} className="hover:bg-gray-50/50">
                  <td className="px-4 py-3">
                    <div className="font-mono text-xs text-gray-700">{r.damSystemId || '—'}</div>
                    {r.damTagDisplay && <div className="text-xs text-gray-400">{r.damTagDisplay}</div>}
                  </td>
                  <td className="px-4 py-3">
                    <div className="font-mono text-xs text-gray-700">{r.sireSystemId || '—'}</div>
                    {r.sireTagDisplay && <div className="text-xs text-gray-400">{r.sireTagDisplay}</div>}
                  </td>
                  <td className="px-4 py-3 text-gray-600 text-xs">{r.matingDate || '—'}</td>
                  <td className="px-4 py-3 text-gray-600 text-xs">{r.deliveryDate || '—'}</td>
                  <td className="px-4 py-3 text-center">
                    {r.offspringCount != null ? (
                      <div>
                        <span className="font-medium text-gray-800">{r.offspringCount}</span>
                        <div className="text-xs text-gray-400">♂{r.malesBorn ?? 0} ♀{r.femalesBorn ?? 0}</div>
                      </div>
                    ) : '—'}
                  </td>
                  <td className="px-4 py-3 text-center text-gray-600">{r.survivingCount ?? '—'}</td>
                  <td className="px-4 py-3 text-gray-400 text-xs max-w-[120px] truncate">{r.notes || '—'}</td>
                </tr>
              ))}
              {breedingRecords.length === 0 && (
                <tr><td colSpan={7} className="px-5 py-8 text-center text-gray-400">No breeding records.</td></tr>
              )}
            </tbody>
          </table>
          <Pagination page={breedingPage} total={breedingRecords.length} pageSize={PAGE_SIZE} onChange={setBreedingPage} />
        </div>
      )}

      {/* ── Weight tab ── */}
      {activeTab === 'weight' && (
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Animal ID</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Weight</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Date</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Official</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Notes</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {weightRecords.slice((weightPage - 1) * PAGE_SIZE, weightPage * PAGE_SIZE).map(r => (
                <tr key={r.id} className="hover:bg-gray-50/50">
                  <td className="px-5 py-3 font-mono text-xs text-gray-400">{r.animalId}</td>
                  <td className="px-5 py-3 font-medium text-gray-900">
                    {r.value} <span className="text-xs text-gray-400">{r.unit}</span>
                  </td>
                  <td className="px-5 py-3 text-gray-600 text-xs">{r.recordedAt || '—'}</td>
                  <td className="px-5 py-3">
                    <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${r.isOfficial ? 'bg-blue-50 text-blue-700' : 'bg-gray-100 text-gray-500'}`}>
                      {r.isOfficial ? 'Official' : 'Informal'}
                    </span>
                  </td>
                  <td className="px-5 py-3 text-gray-400 text-xs">{r.notes || '—'}</td>
                </tr>
              ))}
              {weightRecords.length === 0 && (
                <tr><td colSpan={5} className="px-5 py-8 text-center text-gray-400">No weight records.</td></tr>
              )}
            </tbody>
          </table>
          <Pagination page={weightPage} total={weightRecords.length} pageSize={PAGE_SIZE} onChange={setWeightPage} />
        </div>
      )}

      {/* ── Ownership / Transfer tab ── */}
      {activeTab === 'ownership' && (
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Animal ID</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Type</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">To Owner</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Phone</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Sale Price</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Date</th>
                <th className="text-left px-4 py-3 text-gray-500 font-medium">Notes</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {ownershipRecords.slice((ownershipPage - 1) * PAGE_SIZE, ownershipPage * PAGE_SIZE).map(r => (
                <tr key={r.id} className="hover:bg-gray-50/50">
                  <td className="px-4 py-3 font-mono text-xs text-gray-400">{r.animalId}</td>
                  <td className="px-4 py-3">
                    <span className="capitalize bg-amber-50 text-amber-700 text-xs px-2 py-0.5 rounded-full font-medium">
                      {r.transferType}
                    </span>
                  </td>
                  <td className="px-4 py-3 font-medium text-gray-900">{r.toOwnerName || '—'}</td>
                  <td className="px-4 py-3 text-gray-600 text-xs">{r.toOwnerPhone || '—'}</td>
                  <td className="px-4 py-3 text-gray-700">
                    {r.salePrice != null && r.salePrice > 0
                      ? `${r.salePrice} ${r.currency ?? ''}`
                      : '—'}
                  </td>
                  <td className="px-4 py-3 text-gray-600 text-xs">{r.transferDate || '—'}</td>
                  <td className="px-4 py-3 text-gray-400 text-xs max-w-[120px] truncate">{r.notes || '—'}</td>
                </tr>
              ))}
              {ownershipRecords.length === 0 && (
                <tr><td colSpan={7} className="px-5 py-8 text-center text-gray-400">No ownership / transfer records.</td></tr>
              )}
            </tbody>
          </table>
          <Pagination page={ownershipPage} total={ownershipRecords.length} pageSize={PAGE_SIZE} onChange={setOwnershipPage} />
        </div>
      )}

      {/* ── Field Labels tab ── */}
      {activeTab === 'labels' && (
        <div className="space-y-4 max-w-2xl">
          <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 text-sm text-amber-800">
            <strong>Note:</strong> Changes apply immediately in the mobile app (streamed in real-time).
            Leave a field blank to use the app's default label.
          </div>

          {!labelsLoaded ? (
            <div className="text-gray-400 text-sm">Loading labels…</div>
          ) : (
            <>
              {[
                { key: 'tag',         icon: '🏷️', title: 'Tag / ID Number',  arKey: 'tagLabelAr',         enKey: 'tagLabelEn',         defaultAr: 'رقم الوسم',    defaultEn: 'Tag Number' },
                { key: 'tagColor',    icon: '🎨', title: 'Tag Color',         arKey: 'tagColorLabelAr',    enKey: 'tagColorLabelEn',    defaultAr: 'لون الوسم',    defaultEn: 'Tag Color' },
                { key: 'animalColor', icon: '🔵', title: 'Animal Color',      arKey: 'animalColorLabelAr', enKey: 'animalColorLabelEn', defaultAr: 'لون الحيوان', defaultEn: 'Animal Color' },
                { key: 'breed',       icon: '🐑', title: 'Breed',             arKey: 'breedLabelAr',       enKey: 'breedLabelEn',       defaultAr: 'السلالة',      defaultEn: 'Breed' },
                { key: 'pen',         icon: '🏠', title: 'Pen',               arKey: 'penLabelAr',         enKey: 'penLabelEn',         defaultAr: 'الحظيرة',     defaultEn: 'Pen' },
              ].map(field => (
                <div key={field.key} className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
                  <div className="flex items-center justify-between mb-3">
                    <div className="flex items-center gap-2">
                      <span className="text-base">{field.icon}</span>
                      <span className="font-semibold text-gray-800 text-sm">{field.title}</span>
                    </div>
                    {(labels[field.arKey as keyof FieldLabels] || labels[field.enKey as keyof FieldLabels]) && (
                      <button
                        onClick={() => setLabels(l => ({ ...l, [field.arKey]: '', [field.enKey]: '' }))}
                        className="text-xs text-gray-400 hover:text-red-500 transition-colors"
                      >
                        Clear
                      </button>
                    )}
                  </div>
                  <div className="grid grid-cols-2 gap-3">
                    <div>
                      <label className="block text-xs text-gray-500 mb-1">Arabic <span className="text-gray-300">(default: {field.defaultAr})</span></label>
                      <input
                        dir="rtl"
                        value={labels[field.arKey as keyof FieldLabels]}
                        onChange={e => setLabels(l => ({ ...l, [field.arKey]: e.target.value }))}
                        placeholder={field.defaultAr}
                        className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
                      />
                    </div>
                    <div>
                      <label className="block text-xs text-gray-500 mb-1">English <span className="text-gray-300">(default: {field.defaultEn})</span></label>
                      <input
                        value={labels[field.enKey as keyof FieldLabels]}
                        onChange={e => setLabels(l => ({ ...l, [field.enKey]: e.target.value }))}
                        placeholder={field.defaultEn}
                        className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
                      />
                    </div>
                  </div>
                </div>
              ))}

              <div className="flex items-center gap-3 pt-2">
                <button
                  onClick={saveLabels}
                  disabled={labelsSaving}
                  className="flex items-center gap-2 bg-[#3B1500] text-white px-5 py-2.5 rounded-xl text-sm font-medium hover:bg-[#5C2A00] disabled:opacity-50 transition-colors"
                >
                  <Save size={15} />
                  {labelsSaving ? 'Saving…' : 'Save Labels'}
                </button>
                <button
                  onClick={resetLabels}
                  className="flex items-center gap-2 border border-gray-200 text-gray-600 px-4 py-2.5 rounded-xl text-sm hover:bg-gray-50 transition-colors"
                >
                  <RotateCcw size={15} />
                  Reset to Defaults
                </button>
                {labelsSavedMsg && (
                  <span className="text-sm font-medium text-green-600">{labelsSavedMsg}</span>
                )}
              </div>
            </>
          )}
        </div>
      )}
    </div>
  )
}
