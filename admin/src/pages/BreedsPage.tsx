import { useEffect, useState } from 'react'
import { collection, getDocs, doc, setDoc, updateDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Modal from '../components/Modal'
import Pagination from '../components/Pagination'
import { Plus, Pencil, Archive, ArchiveRestore } from 'lucide-react'
import type { Breed, Species } from '../types'

const PAGE_SIZE = 20

const SPECIES_LIST: Species[] = ['sheep', 'goat', 'camel', 'cow', 'horse']
const SPECIES_LABELS: Record<Species, string> = {
  sheep: '🐑 Sheep', goat: '🐐 Goat', camel: '🐪 Camel', cow: '🐄 Cow', horse: '🐎 Horse',
}

const empty: Omit<Breed, 'id'> = { nameAr: '', nameEn: '', species: 'sheep', isGlobal: true, isArchived: false }

export default function BreedsPage() {
  const [breeds, setBreeds] = useState<Breed[]>([])
  const [activeSpecies, setActiveSpecies] = useState<Species>('sheep')
  const [showModal, setShowModal] = useState(false)
  const [editing, setEditing] = useState<Breed | null>(null)
  const [form, setForm] = useState(empty)
  const [saving, setSaving] = useState(false)
  const [showArchived, setShowArchived] = useState(false)
  const [page, setPage] = useState(1)

  useEffect(() => { loadBreeds() }, [])

  const loadBreeds = async () => {
    const snap = await getDocs(collection(db, 'global', 'lists', 'breeds'))
    setBreeds(snap.docs.map(d => ({ id: d.id, ...d.data() } as Breed)))
  }

  const openAdd = () => {
    setEditing(null)
    setForm({ ...empty, species: activeSpecies })
    setShowModal(true)
  }

  const openEdit = (b: Breed) => {
    setEditing(b)
    setForm({ nameAr: b.nameAr, nameEn: b.nameEn, species: b.species, isGlobal: b.isGlobal, isArchived: b.isArchived })
    setShowModal(true)
  }

  const save = async () => {
    if (!form.nameAr || !form.nameEn) return
    setSaving(true)
    const id = editing?.id ?? `${form.species}_${Date.now()}`
    await setDoc(doc(db, 'global', 'lists', 'breeds', id), { ...form })
    await loadBreeds()
    setSaving(false)
    setShowModal(false)
  }

  const toggleArchive = async (b: Breed) => {
    await updateDoc(doc(db, 'global', 'lists', 'breeds', b.id), { isArchived: !b.isArchived })
    await loadBreeds()
  }

  const visible = breeds.filter(b =>
    b.species === activeSpecies && (showArchived ? true : !b.isArchived)
  )
  const paginated = visible.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE)

  return (
    <div>
      <PageHeader
        title="Breed Lists"
        subtitle="Manage breed options per species — changes reflect in app immediately"
        action={
          <button onClick={openAdd} className="flex items-center gap-2 bg-[#3B1500] text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-[#5a2200] transition-colors">
            <Plus size={16} /> Add Breed
          </button>
        }
      />
      <div className="p-8 space-y-5">
        {/* Species tabs */}
        <div className="flex gap-2 flex-wrap">
          {SPECIES_LIST.map(sp => (
            <button
              key={sp}
              onClick={() => { setActiveSpecies(sp); setPage(1) }}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${activeSpecies === sp ? 'bg-[#3B1500] text-white' : 'bg-white text-gray-600 border border-gray-200 hover:border-gray-300'}`}
            >
              {SPECIES_LABELS[sp]}
            </button>
          ))}
          <button
            onClick={() => setShowArchived(v => !v)}
            className={`ml-auto px-3 py-2 rounded-lg text-xs font-medium transition-colors ${showArchived ? 'bg-amber-100 text-amber-700' : 'bg-gray-100 text-gray-500 hover:bg-gray-200'}`}
          >
            {showArchived ? 'Hide Archived' : 'Show Archived'}
          </button>
        </div>

        {/* Table */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Arabic Name</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">English Name</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Scope</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Status</th>
                <th className="px-5 py-3" />
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {visible.length === 0 && (
                <tr><td colSpan={5} className="px-5 py-8 text-center text-gray-400">No breeds for this species yet.</td></tr>
              )}
              {paginated.map(b => (
                <tr key={b.id} className={`hover:bg-gray-50/50 ${b.isArchived ? 'opacity-50' : ''}`}>
                  <td className="px-5 py-3 font-medium text-gray-900 text-right" dir="rtl">{b.nameAr}</td>
                  <td className="px-5 py-3 text-gray-700">{b.nameEn}</td>
                  <td className="px-5 py-3">
                    <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${b.isGlobal ? 'bg-blue-50 text-blue-700' : 'bg-gray-100 text-gray-600'}`}>
                      {b.isGlobal ? 'Global' : 'Regional'}
                    </span>
                  </td>
                  <td className="px-5 py-3">
                    <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${b.isArchived ? 'bg-red-50 text-red-600' : 'bg-green-50 text-green-700'}`}>
                      {b.isArchived ? 'Archived' : 'Active'}
                    </span>
                  </td>
                  <td className="px-5 py-3 text-right">
                    <div className="flex justify-end gap-2">
                      <button onClick={() => openEdit(b)} className="text-gray-400 hover:text-gray-700 p-1 rounded"><Pencil size={15} /></button>
                      <button onClick={() => toggleArchive(b)} className="text-gray-400 hover:text-gray-700 p-1 rounded" title={b.isArchived ? 'Restore' : 'Archive'}>
                        {b.isArchived ? <ArchiveRestore size={15} /> : <Archive size={15} />}
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          <Pagination page={page} total={visible.length} pageSize={PAGE_SIZE} onChange={setPage} />
        </div>
      </div>

      {showModal && (
        <Modal
          title={editing ? 'Edit Breed' : 'Add Breed'}
          onClose={() => setShowModal(false)}
          footer={
            <>
              <button onClick={() => setShowModal(false)} className="px-4 py-2 text-sm text-gray-600 hover:text-gray-800">Cancel</button>
              <button onClick={save} disabled={saving} className="px-4 py-2 bg-[#3B1500] text-white text-sm rounded-lg hover:bg-[#5a2200] disabled:opacity-60">
                {saving ? 'Saving…' : 'Save'}
              </button>
            </>
          }
        >
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Arabic Name <span className="text-red-500">*</span></label>
              <input dir="rtl" value={form.nameAr} onChange={e => setForm(f => ({ ...f, nameAr: e.target.value }))}
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20" placeholder="اسم السلالة" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">English Name <span className="text-red-500">*</span></label>
              <input value={form.nameEn} onChange={e => setForm(f => ({ ...f, nameEn: e.target.value }))}
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20" placeholder="Breed name" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Species</label>
              <select value={form.species} onChange={e => setForm(f => ({ ...f, species: e.target.value as Species }))}
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20">
                {SPECIES_LIST.map(sp => <option key={sp} value={sp}>{SPECIES_LABELS[sp]}</option>)}
              </select>
            </div>
            <label className="flex items-center gap-2 text-sm text-gray-700 cursor-pointer">
              <input type="checkbox" checked={form.isGlobal} onChange={e => setForm(f => ({ ...f, isGlobal: e.target.checked }))} className="rounded" />
              Global breed (visible to all countries)
            </label>
          </div>
        </Modal>
      )}
    </div>
  )
}
