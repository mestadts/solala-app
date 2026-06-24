import { useEffect, useState } from 'react'
import { collection, getDocs, doc, setDoc, updateDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Modal from '../components/Modal'
import Pagination from '../components/Pagination'
import { Plus, Pencil, Archive, ArchiveRestore } from 'lucide-react'
import type { Medication, Species } from '../types'

const PAGE_SIZE = 20

const SPECIES_LIST: Species[] = ['sheep', 'goat', 'camel', 'cow', 'horse']

const empty: Omit<Medication, 'id'> = { nameAr: '', nameEn: '', type: 'deworming', species: ['sheep', 'goat'], isArchived: false }

export default function MedicationsPage() {
  const [meds, setMeds] = useState<Medication[]>([])
  const [activeType, setActiveType] = useState<'deworming' | 'treatment'>('deworming')
  const [showModal, setShowModal] = useState(false)
  const [editing, setEditing] = useState<Medication | null>(null)
  const [form, setForm] = useState(empty)
  const [saving, setSaving] = useState(false)
  const [page, setPage] = useState(1)

  useEffect(() => { load() }, [])

  const load = async () => {
    const snap = await getDocs(collection(db, 'global', 'lists', 'medications'))
    setMeds(snap.docs.map(d => ({ id: d.id, ...d.data() } as Medication)))
  }

  const openAdd = () => { setEditing(null); setForm({ ...empty, type: activeType }); setShowModal(true) }
  const openEdit = (m: Medication) => { setEditing(m); setForm({ nameAr: m.nameAr, nameEn: m.nameEn, type: m.type, species: m.species, isArchived: m.isArchived }); setShowModal(true) }

  const save = async () => {
    if (!form.nameEn) return
    setSaving(true)
    const id = editing?.id ?? `med_${Date.now()}`
    await setDoc(doc(db, 'global', 'lists', 'medications', id), { ...form })
    await load()
    setSaving(false)
    setShowModal(false)
  }

  const toggleArchive = async (m: Medication) => {
    await updateDoc(doc(db, 'global', 'lists', 'medications', m.id), { isArchived: !m.isArchived })
    await load()
  }

  const toggleSpecies = (sp: Species) => {
    setForm(f => ({
      ...f,
      species: f.species.includes(sp) ? f.species.filter(s => s !== sp) : [...f.species, sp],
    }))
  }

  const visible = meds.filter(m => m.type === activeType)
  const paginated = visible.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE)

  return (
    <div>
      <PageHeader
        title="Medications"
        subtitle="Manage deworming drugs and treatment medications"
        action={
          <button onClick={openAdd} className="flex items-center gap-2 bg-[#3B1500] text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-[#5a2200]">
            <Plus size={16} /> Add Medication
          </button>
        }
      />
      <div className="p-8 space-y-5">
        <div className="flex gap-2">
          {(['deworming', 'treatment'] as const).map(t => (
            <button key={t} onClick={() => { setActiveType(t); setPage(1) }}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors capitalize ${activeType === t ? 'bg-[#3B1500] text-white' : 'bg-white text-gray-600 border border-gray-200 hover:border-gray-300'}`}>
              {t === 'deworming' ? '🐛 Deworming' : '💊 Treatment'}
            </button>
          ))}
        </div>

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
              {visible.length === 0 && (
                <tr><td colSpan={5} className="px-5 py-8 text-center text-gray-400">No {activeType} medications yet.</td></tr>
              )}
              {paginated.map(m => (
                <tr key={m.id} className={`hover:bg-gray-50/50 ${m.isArchived ? 'opacity-50' : ''}`}>
                  <td className="px-5 py-3 text-right" dir="rtl">{m.nameAr || '—'}</td>
                  <td className="px-5 py-3 font-medium text-gray-900">{m.nameEn}</td>
                  <td className="px-5 py-3">
                    <div className="flex flex-wrap gap-1">
                      {m.species.map(sp => (
                        <span key={sp} className="px-1.5 py-0.5 bg-gray-100 text-gray-600 rounded text-xs">{sp}</span>
                      ))}
                    </div>
                  </td>
                  <td className="px-5 py-3">
                    <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${m.isArchived ? 'bg-red-50 text-red-600' : 'bg-green-50 text-green-700'}`}>
                      {m.isArchived ? 'Archived' : 'Active'}
                    </span>
                  </td>
                  <td className="px-5 py-3 text-right">
                    <div className="flex justify-end gap-2">
                      <button onClick={() => openEdit(m)} className="text-gray-400 hover:text-gray-700 p-1"><Pencil size={15} /></button>
                      <button onClick={() => toggleArchive(m)} className="text-gray-400 hover:text-gray-700 p-1">
                        {m.isArchived ? <ArchiveRestore size={15} /> : <Archive size={15} />}
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
        <Modal title={editing ? 'Edit Medication' : 'Add Medication'} onClose={() => setShowModal(false)}
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
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" placeholder="اسم الدواء (اختياري)" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">English Name <span className="text-red-500">*</span></label>
              <input value={form.nameEn} onChange={e => setForm(f => ({ ...f, nameEn: e.target.value }))}
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" placeholder="e.g. Ivermectin" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Type</label>
              <select value={form.type} onChange={e => setForm(f => ({ ...f, type: e.target.value as 'deworming' | 'treatment' }))}
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none">
                <option value="deworming">🐛 Deworming</option>
                <option value="treatment">💊 Treatment</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">Species</label>
              <div className="flex flex-wrap gap-2">
                {SPECIES_LIST.map(sp => (
                  <button key={sp} type="button" onClick={() => toggleSpecies(sp)}
                    className={`px-3 py-1.5 rounded-lg text-xs font-medium transition-colors ${form.species.includes(sp) ? 'bg-[#3B1500] text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>
                    {sp}
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
