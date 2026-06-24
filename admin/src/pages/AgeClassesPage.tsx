import { useEffect, useState } from 'react'
import { collection, getDocs, doc, setDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Modal from '../components/Modal'
import { Pencil, RotateCcw } from 'lucide-react'
import type { AgeClass } from '../types'

const DEFAULTS: Omit<AgeClass, 'id'>[] = [
  { nameAr: 'بهم',  nameEn: 'Bahm (0–11 months)',    minMonths: 0,  maxMonths: 11,  order: 1 },
  { nameAr: 'جذع',  nameEn: 'Jadh (1–2 years)',      minMonths: 12, maxMonths: 23,  order: 2 },
  { nameAr: 'ثني',  nameEn: 'Thani (2–3 years)',     minMonths: 24, maxMonths: 35,  order: 3 },
  { nameAr: 'رباع', nameEn: "Rubaa (3–4 years)",     minMonths: 36, maxMonths: 47,  order: 4 },
  { nameAr: 'سديس', nameEn: 'Sudas (4–5 years)',     minMonths: 48, maxMonths: 59,  order: 5 },
  { nameAr: 'تام',  nameEn: 'Tam (5 years+)',        minMonths: 60, maxMonths: 999, order: 6 },
]

export default function AgeClassesPage() {
  const [classes, setClasses] = useState<AgeClass[]>([])
  const [showModal, setShowModal] = useState(false)
  const [editing, setEditing] = useState<AgeClass | null>(null)
  const [form, setForm] = useState({ nameAr: '', nameEn: '', minMonths: 0, maxMonths: 12, order: 1 })
  const [saving, setSaving] = useState(false)
  const [seeding, setSeeding] = useState(false)

  useEffect(() => { load() }, [])

  const load = async () => {
    const snap = await getDocs(collection(db, 'global', 'lists', 'ageClasses'))
    const data = snap.docs.map(d => ({ id: d.id, ...d.data() } as AgeClass))
    setClasses(data.sort((a, b) => a.order - b.order))
  }

  const seedDefaults = async () => {
    setSeeding(true)
    for (const c of DEFAULTS) {
      await setDoc(doc(db, 'global', 'lists', 'ageClasses', c.nameEn.split(' ')[0].toLowerCase()), c)
    }
    await load()
    setSeeding(false)
  }

  const openEdit = (c: AgeClass) => {
    setEditing(c)
    setForm({ nameAr: c.nameAr, nameEn: c.nameEn, minMonths: c.minMonths, maxMonths: c.maxMonths, order: c.order })
    setShowModal(true)
  }

  const save = async () => {
    if (!editing) return
    setSaving(true)
    await setDoc(doc(db, 'global', 'lists', 'ageClasses', editing.id), { ...form })
    await load()
    setSaving(false)
    setShowModal(false)
  }

  return (
    <div>
      <PageHeader
        title="Age Classifications"
        subtitle="Traditional Arabic age groups — edit month ranges as needed"
        action={
          classes.length === 0 ? (
            <button onClick={seedDefaults} disabled={seeding} className="flex items-center gap-2 bg-amber-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-amber-700 disabled:opacity-60">
              {seeding ? 'Seeding…' : '⚡ Seed Defaults'}
            </button>
          ) : (
            <button onClick={seedDefaults} disabled={seeding} className="flex items-center gap-2 bg-gray-100 text-gray-600 px-4 py-2 rounded-lg text-sm font-medium hover:bg-gray-200 disabled:opacity-60">
              <RotateCcw size={14} /> {seeding ? 'Resetting…' : 'Reset to Defaults'}
            </button>
          )
        }
      />
      <div className="p-8">
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 border-b border-gray-100">
              <tr>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">#</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Arabic Name</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">English Name</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Min Age</th>
                <th className="text-left px-5 py-3 text-gray-500 font-medium">Max Age</th>
                <th className="px-5 py-3" />
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {classes.length === 0 && (
                <tr><td colSpan={6} className="px-5 py-8 text-center text-gray-400">No age classes yet. Click "Seed Defaults".</td></tr>
              )}
              {classes.map(c => (
                <tr key={c.id} className="hover:bg-gray-50/50">
                  <td className="px-5 py-3 text-gray-400 font-mono text-xs">{c.order}</td>
                  <td className="px-5 py-3 font-bold text-xl text-[#3B1500]" dir="rtl">{c.nameAr}</td>
                  <td className="px-5 py-3 text-gray-700">{c.nameEn}</td>
                  <td className="px-5 py-3 text-gray-600">{c.minMonths} months</td>
                  <td className="px-5 py-3 text-gray-600">{c.maxMonths >= 999 ? '∞' : `${c.maxMonths} months`}</td>
                  <td className="px-5 py-3 text-right">
                    <button onClick={() => openEdit(c)} className="text-gray-400 hover:text-gray-700 p-1"><Pencil size={15} /></button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {showModal && editing && (
        <Modal title={`Edit: ${editing.nameAr}`} onClose={() => setShowModal(false)}
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
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Arabic Name</label>
                <input dir="rtl" value={form.nameAr} onChange={e => setForm(f => ({ ...f, nameAr: e.target.value }))}
                  className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">English Name</label>
                <input value={form.nameEn} onChange={e => setForm(f => ({ ...f, nameEn: e.target.value }))}
                  className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" />
              </div>
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Min (months)</label>
                <input type="number" value={form.minMonths} onChange={e => setForm(f => ({ ...f, minMonths: +e.target.value }))}
                  className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Max (months, 999 = unlimited)</label>
                <input type="number" value={form.maxMonths} onChange={e => setForm(f => ({ ...f, maxMonths: +e.target.value }))}
                  className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" />
              </div>
            </div>
          </div>
        </Modal>
      )}
    </div>
  )
}
