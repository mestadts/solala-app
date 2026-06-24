import { useEffect, useState } from 'react'
import { collection, getDocs, doc, setDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Modal from '../components/Modal'
import { Pencil } from 'lucide-react'

interface CountryTemplate {
  id: string
  name: string
  flag: string
  requiredFields: string[]
  notes: string
}

const DEFAULTS: Omit<CountryTemplate, 'id'>[] = [
  { name: 'Saudi Arabia', flag: '🇸🇦', requiredFields: ['tagNumber', 'species', 'gender', 'dateOfBirth', 'breed'], notes: 'NAIS compliance. Official tag required for cattle.' },
  { name: 'UAE', flag: '🇦🇪', requiredFields: ['tagNumber', 'species', 'gender', 'dateOfBirth'], notes: 'UAE Ministry of Climate Change.' },
  { name: 'Kuwait', flag: '🇰🇼', requiredFields: ['tagNumber', 'species', 'gender'], notes: '' },
  { name: 'Qatar', flag: '🇶🇦', requiredFields: ['tagNumber', 'species', 'gender'], notes: '' },
  { name: 'Other', flag: '🌍', requiredFields: ['species', 'gender'], notes: 'Default — no country-specific requirements.' },
]

const FIELD_OPTIONS = ['tagNumber', 'officialTagNumber', 'species', 'breed', 'gender', 'dateOfBirth', 'color', 'weight', 'purpose', 'penGroup']

export default function CountriesPage() {
  const [templates, setTemplates] = useState<CountryTemplate[]>([])
  const [showModal, setShowModal] = useState(false)
  const [editing, setEditing] = useState<CountryTemplate | null>(null)
  const [form, setForm] = useState({ name: '', flag: '', requiredFields: [] as string[], notes: '' })
  const [saving, setSaving] = useState(false)
  const [seeding, setSeeding] = useState(false)

  useEffect(() => { load() }, [])

  const load = async () => {
    const snap = await getDocs(collection(db, 'global', 'lists', 'countryTemplates'))
    setTemplates(snap.docs.map(d => ({ id: d.id, ...d.data() } as CountryTemplate)))
  }

  const seedDefaults = async () => {
    setSeeding(true)
    for (const t of DEFAULTS) {
      await setDoc(doc(db, 'global', 'lists', 'countryTemplates', t.name.toLowerCase().replace(/\s+/g, '_')), t)
    }
    await load()
    setSeeding(false)
  }

  const openEdit = (t: CountryTemplate) => {
    setEditing(t)
    setForm({ name: t.name, flag: t.flag, requiredFields: t.requiredFields, notes: t.notes })
    setShowModal(true)
  }

  const save = async () => {
    if (!editing) return
    setSaving(true)
    await setDoc(doc(db, 'global', 'lists', 'countryTemplates', editing.id), { ...form })
    await load()
    setSaving(false)
    setShowModal(false)
  }

  const toggleField = (f: string) => {
    setForm(prev => ({
      ...prev,
      requiredFields: prev.requiredFields.includes(f)
        ? prev.requiredFields.filter(x => x !== f)
        : [...prev.requiredFields, f],
    }))
  }

  return (
    <div>
      <PageHeader
        title="Country Templates"
        subtitle="Define which fields are required per country"
        action={
          templates.length === 0 && (
            <button onClick={seedDefaults} disabled={seeding} className="flex items-center gap-2 bg-amber-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-amber-700 disabled:opacity-60">
              {seeding ? 'Seeding…' : '⚡ Seed Defaults'}
            </button>
          )
        }
      />
      <div className="p-8">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {templates.map(t => (
            <div key={t.id} className="bg-white rounded-xl border border-gray-100 shadow-sm p-5">
              <div className="flex items-center justify-between mb-3">
                <div className="flex items-center gap-2">
                  <span className="text-2xl">{t.flag}</span>
                  <span className="font-semibold text-gray-900">{t.name}</span>
                </div>
                <button onClick={() => openEdit(t)} className="text-gray-400 hover:text-gray-700 p-1"><Pencil size={15} /></button>
              </div>
              <div className="space-y-1">
                <p className="text-xs text-gray-500 font-medium mb-2">Required Fields:</p>
                <div className="flex flex-wrap gap-1">
                  {t.requiredFields.map(f => (
                    <span key={f} className="px-2 py-0.5 bg-[#3B1500]/10 text-[#3B1500] rounded text-xs font-medium">{f}</span>
                  ))}
                </div>
              </div>
              {t.notes && <p className="text-xs text-gray-400 mt-3">{t.notes}</p>}
            </div>
          ))}
          {templates.length === 0 && (
            <div className="col-span-full py-10 text-center text-gray-400 text-sm">
              No country templates yet. Click "Seed Defaults".
            </div>
          )}
        </div>
      </div>

      {showModal && editing && (
        <Modal title={`Edit: ${editing.flag} ${editing.name}`} onClose={() => setShowModal(false)}
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
              <label className="block text-sm font-medium text-gray-700 mb-2">Required Fields</label>
              <div className="flex flex-wrap gap-2">
                {FIELD_OPTIONS.map(f => (
                  <button key={f} type="button" onClick={() => toggleField(f)}
                    className={`px-3 py-1.5 rounded-lg text-xs font-medium transition-colors ${form.requiredFields.includes(f) ? 'bg-[#3B1500] text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>
                    {f}
                  </button>
                ))}
              </div>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Notes</label>
              <textarea value={form.notes} onChange={e => setForm(f => ({ ...f, notes: e.target.value }))}
                rows={3} className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none resize-none" />
            </div>
          </div>
        </Modal>
      )}
    </div>
  )
}
