import { useEffect, useState } from 'react'
import { collection, getDocs, doc, setDoc, updateDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Modal from '../components/Modal'
import Pagination from '../components/Pagination'
import { Plus, Pencil, Archive, ArchiveRestore } from 'lucide-react'
import type { Vaccine, Species } from '../types'

const PAGE_SIZE = 20

const SPECIES_LIST: Species[] = ['sheep', 'goat', 'camel', 'cow', 'horse']
const SPECIES_LABELS: Record<Species, string> = {
  sheep: '🐑 Sheep', goat: '🐐 Goat', camel: '🐪 Camel', cow: '🐄 Cow', horse: '🐎 Horse',
}

const empty: Omit<Vaccine, 'id'> = { nameAr: '', nameEn: '', species: ['sheep'], isArchived: false }

export default function VaccinesPage() {
  const [vaccines, setVaccines] = useState<Vaccine[]>([])
  const [showModal, setShowModal] = useState(false)
  const [editing, setEditing] = useState<Vaccine | null>(null)
  const [form, setForm] = useState(empty)
  const [saving, setSaving] = useState(false)
  const [page, setPage] = useState(1)

  useEffect(() => { load() }, [])

  const load = async () => {
    const snap = await getDocs(collection(db, 'global', 'lists', 'vaccines'))
    setVaccines(snap.docs.map(d => ({ id: d.id, ...d.data() } as Vaccine)))
  }

  const openAdd = () => { setEditing(null); setForm(empty); setShowModal(true) }
  const openEdit = (v: Vaccine) => {
    setEditing(v)
    setForm({ nameAr: v.nameAr, nameEn: v.nameEn, species: v.species, isArchived: v.isArchived })
    setShowModal(true)
  }

  const save = async () => {
    if (!form.nameEn) return
    setSaving(true)
    const id = editing?.id ?? `vac_${Date.now()}`
    await setDoc(doc(db, 'global', 'lists', 'vaccines', id), { ...form })
    await load()
    setSaving(false)
    setShowModal(false)
  }

  const toggleArchive = async (v: Vaccine) => {
    await updateDoc(doc(db, 'global', 'lists', 'vaccines', v.id), { isArchived: !v.isArchived })
    await load()
  }

  const toggleSpecies = (sp: Species) => {
    setForm(f => ({
      ...f,
      species: f.species.includes(sp) ? f.species.filter(s => s !== sp) : [...f.species, sp],
    }))
  }

  const paginated = vaccines.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE)

  return (
    <div>
      <PageHeader
        title="Vaccines"
        subtitle="Manage preset vaccine options per species"
        action={
          <button onClick={openAdd} className="flex items-center gap-2 bg-[#3B1500] text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-[#5a2200]">
            <Plus size={16} /> Add Vaccine
          </button>
        }
      />
      <div className="p-8">
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Arabic Name</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">English Name</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Species</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Status</th>
                <th className="px-5 py-3" />
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {vaccines.length === 0 && (
                <tr><td colSpan={5} className="px-5 py-8 text-center text-gray-400">No vaccines yet.</td></tr>
              )}
              {paginated.map(v => (
                <tr key={v.id} className={`hover:bg-gray-50/50 ${v.isArchived ? 'opacity-50' : ''}`}>
                  <td className="px-5 py-3 text-right" dir="rtl">{v.nameAr || '—'}</td>
                  <td className="px-5 py-3 font-medium text-gray-900">{v.nameEn}</td>
                  <td className="px-5 py-3">
                    <div className="flex flex-wrap gap-1">
                      {v.species.map(sp => (
                        <span key={sp} className="px-1.5 py-0.5 bg-gray-100 text-gray-600 rounded text-xs">{sp}</span>
                      ))}
                    </div>
                  </td>
                  <td className="px-5 py-3">
                    <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${v.isArchived ? 'bg-red-50 text-red-600' : 'bg-green-50 text-green-700'}`}>
                      {v.isArchived ? 'Archived' : 'Active'}
                    </span>
                  </td>
                  <td className="px-5 py-3 text-right">
                    <div className="flex justify-end gap-2">
                      <button onClick={() => openEdit(v)} className="text-gray-400 hover:text-gray-700 p-1"><Pencil size={15} /></button>
                      <button onClick={() => toggleArchive(v)} className="text-gray-400 hover:text-gray-700 p-1">
                        {v.isArchived ? <ArchiveRestore size={15} /> : <Archive size={15} />}
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          <Pagination page={page} total={vaccines.length} pageSize={PAGE_SIZE} onChange={setPage} />
        </div>
      </div>

      {showModal && (
        <Modal title={editing ? 'Edit Vaccine' : 'Add Vaccine'} onClose={() => setShowModal(false)}
          footer={
            <>
              <button onClick={() => setShowModal(false)} className="px-4 py-2 text-sm text-gray-600">Cancel</button>
              <button onClick={save} disabled={saving} className="px-4 py-2 bg-[#3B1500] text-white text-sm rounded-lg disabled:opacity-60">
                {saving ? 'Saving…' : 'Save'}
              </button>
            </>
          }
        >
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Arabic Name</label>
              <input dir="rtl" value={form.nameAr} onChange={e => setForm(f => ({ ...f, nameAr: e.target.value }))}
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" placeholder="اسم اللقاح (اختياري)" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">English Name <span className="text-red-500">*</span></label>
              <input value={form.nameEn} onChange={e => setForm(f => ({ ...f, nameEn: e.target.value }))}
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" placeholder="e.g. FMD Vaccine" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">Species</label>
              <div className="flex flex-wrap gap-2">
                {SPECIES_LIST.map(sp => (
                  <button key={sp} type="button" onClick={() => toggleSpecies(sp)}
                    className={`px-3 py-1.5 rounded-lg text-xs font-medium transition-colors ${form.species.includes(sp) ? 'bg-[#3B1500] text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>
                    {SPECIES_LABELS[sp]}
                  </button>
                ))}
              </div>
            </div>
          </div>
        </Modal>
      )}
    </div>
  )
}
