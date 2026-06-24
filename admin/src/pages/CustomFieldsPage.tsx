import { useEffect, useState } from 'react'
import { collection, getDocs, doc, setDoc, updateDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Modal from '../components/Modal'
import { Plus, Pencil, Archive, ArchiveRestore, GripVertical } from 'lucide-react'
import type { CustomField, CustomFieldType, Species } from '../types'

const SPECIES_LIST: Species[] = ['sheep', 'goat', 'camel', 'cow', 'horse']
const FIELD_TYPES: { value: CustomFieldType; label: string }[] = [
  { value: 'text',    label: 'Text' },
  { value: 'number',  label: 'Number' },
  { value: 'select',  label: 'Select (dropdown)' },
  { value: 'boolean', label: 'Yes / No' },
]

const empty: Omit<CustomField, 'id'> = {
  nameAr: '', nameEn: '', fieldType: 'text', options: [], species: null,
  required: false, isArchived: false, order: 0,
}

export default function CustomFieldsPage() {
  const [fields, setFields]       = useState<CustomField[]>([])
  const [loading, setLoading]     = useState(true)
  const [modalOpen, setModalOpen] = useState(false)
  const [editing, setEditing]     = useState<CustomField | null>(null)
  const [form, setForm]           = useState<Omit<CustomField, 'id'>>(empty)
  const [optionsText, setOptionsText] = useState('')
  const [saving, setSaving]       = useState(false)

  // Filter: show active or archived
  const [showArchived, setShowArchived] = useState(false)

  useEffect(() => { load() }, [])

  async function load() {
    setLoading(true)
    try {
      const snap = await getDocs(collection(db, 'global', 'lists', 'customFields'))
      const data = snap.docs.map(d => ({ id: d.id, ...d.data() } as CustomField))
      data.sort((a, b) => (a.order ?? 0) - (b.order ?? 0))
      setFields(data)
    } finally {
      setLoading(false)
    }
  }

  function openAdd() {
    setEditing(null)
    setForm({ ...empty, order: fields.length })
    setOptionsText('')
    setModalOpen(true)
  }

  function openEdit(f: CustomField) {
    setEditing(f)
    setForm({ nameAr: f.nameAr, nameEn: f.nameEn, fieldType: f.fieldType,
      options: f.options, species: f.species, required: f.required,
      isArchived: f.isArchived, order: f.order })
    setOptionsText(f.options.join('\n'))
    setModalOpen(true)
  }

  async function save() {
    if (!form.nameAr.trim() || !form.nameEn.trim()) return
    setSaving(true)
    try {
      const id = editing?.id ?? `cf_${Date.now()}`
      const parsed = optionsText
        .split('\n')
        .map(s => s.trim())
        .filter(Boolean)
      const data: Omit<CustomField, 'id'> = {
        ...form,
        options: form.fieldType === 'select' ? parsed : [],
      }
      if (editing) {
        await updateDoc(doc(db, 'global', 'lists', 'customFields', id), data as Record<string, unknown>)
      } else {
        await setDoc(doc(db, 'global', 'lists', 'customFields', id), data)
      }
      setModalOpen(false)
      load()
    } finally {
      setSaving(false)
    }
  }

  async function toggleArchive(f: CustomField) {
    await updateDoc(doc(db, 'global', 'lists', 'customFields', f.id), {
      isArchived: !f.isArchived,
    })
    load()
  }

  function toggleSpecies(sp: Species) {
    if (form.species === null) {
      setForm(prev => ({ ...prev, species: SPECIES_LIST.filter(s => s !== sp) }))
    } else {
      const next = form.species.includes(sp)
        ? form.species.filter(s => s !== sp)
        : [...form.species, sp]
      setForm(prev => ({ ...prev, species: next.length === SPECIES_LIST.length ? null : next }))
    }
  }

  const visible = fields.filter(f => f.isArchived === showArchived)

  return (
    <div>
      <PageHeader
        title="Custom Fields"
        subtitle="Define extra fields that appear on animal forms in the mobile app"
        action={
          <button
            onClick={openAdd}
            className="flex items-center gap-2 bg-[#3B1500] text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-[#5a2200] transition-colors"
          >
            <Plus size={16} /> Add Field
          </button>
        }
      />

      {/* Tab strip */}
      <div className="flex gap-2 mb-6">
        {(['active', 'archived'] as const).map(tab => (
          <button
            key={tab}
            onClick={() => setShowArchived(tab === 'archived')}
            className={`px-4 py-1.5 rounded-full text-sm font-medium transition-colors ${
              showArchived === (tab === 'archived')
                ? 'bg-[#3B1500] text-white'
                : 'bg-white text-gray-600 border border-gray-200 hover:border-gray-400'
            }`}
          >
            {tab === 'active' ? 'Active' : 'Archived'}
          </button>
        ))}
      </div>

      {loading ? (
        <div className="text-center py-12 text-gray-400">Loading…</div>
      ) : visible.length === 0 ? (
        <div className="text-center py-16 text-gray-400">
          <div className="text-4xl mb-3">🗂️</div>
          <div>No custom fields yet. Click <strong>Add Field</strong> to create one.</div>
        </div>
      ) : (
        <div className="bg-white rounded-xl border border-gray-100 overflow-hidden">
          <table className="w-full text-sm">
            <thead className="bg-gray-50 text-gray-500 text-xs uppercase">
              <tr>
                <th className="px-4 py-3 text-left w-8"></th>
                <th className="px-4 py-3 text-left">Arabic Name</th>
                <th className="px-4 py-3 text-left">English Name</th>
                <th className="px-4 py-3 text-left">Type</th>
                <th className="px-4 py-3 text-left">Species</th>
                <th className="px-4 py-3 text-left">Required</th>
                <th className="px-4 py-3 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {visible.map(f => (
                <tr key={f.id} className="hover:bg-gray-50/50">
                  <td className="px-4 py-3 text-gray-300">
                    <GripVertical size={14} />
                  </td>
                  <td className="px-4 py-3">
                    <span className="font-medium text-gray-800" dir="rtl">{f.nameAr}</span>
                  </td>
                  <td className="px-4 py-3 text-gray-700">{f.nameEn}</td>
                  <td className="px-4 py-3">
                    <span className="px-2 py-0.5 bg-blue-50 text-blue-700 rounded-full text-xs font-medium capitalize">
                      {f.fieldType}
                    </span>
                    {f.fieldType === 'select' && f.options.length > 0 && (
                      <span className="ml-1 text-gray-400 text-xs">
                        ({f.options.length} options)
                      </span>
                    )}
                  </td>
                  <td className="px-4 py-3 text-gray-600">
                    {f.species === null ? (
                      <span className="text-xs bg-green-50 text-green-700 px-2 py-0.5 rounded-full">All species</span>
                    ) : (
                      <span className="text-xs text-gray-500">{f.species.join(', ')}</span>
                    )}
                  </td>
                  <td className="px-4 py-3">
                    {f.required ? (
                      <span className="text-xs bg-red-50 text-red-600 px-2 py-0.5 rounded-full">Required</span>
                    ) : (
                      <span className="text-xs text-gray-400">Optional</span>
                    )}
                  </td>
                  <td className="px-4 py-3">
                    <div className="flex items-center justify-end gap-2">
                      <button
                        onClick={() => openEdit(f)}
                        className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-500 hover:text-gray-700 transition-colors"
                        title="Edit"
                      >
                        <Pencil size={14} />
                      </button>
                      <button
                        onClick={() => toggleArchive(f)}
                        className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-500 hover:text-gray-700 transition-colors"
                        title={f.isArchived ? 'Restore' : 'Archive'}
                      >
                        {f.isArchived ? <ArchiveRestore size={14} /> : <Archive size={14} />}
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* ── Add / Edit modal ─────────────────────────────────────────── */}
      {modalOpen && <Modal
        title={editing ? 'Edit Custom Field' : 'Add Custom Field'}
        onClose={() => setModalOpen(false)}
        footer={
          <div className="flex justify-end gap-3">
            <button onClick={() => setModalOpen(false)} className="px-4 py-2 text-sm text-gray-600 hover:text-gray-900">
              Cancel
            </button>
            <button
              onClick={save}
              disabled={saving || !form.nameAr.trim() || !form.nameEn.trim()}
              className="px-4 py-2 text-sm bg-[#3B1500] text-white rounded-lg hover:bg-[#5a2200] disabled:opacity-50 transition-colors"
            >
              {saving ? 'Saving…' : 'Save'}
            </button>
          </div>
        }
      >
        <div className="space-y-4">
          {/* Names */}
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">Arabic Name *</label>
              <input
                dir="rtl"
                className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
                value={form.nameAr}
                onChange={e => setForm(p => ({ ...p, nameAr: e.target.value }))}
                placeholder="مثال: رقم التلقيح"
              />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">English Name *</label>
              <input
                className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
                value={form.nameEn}
                onChange={e => setForm(p => ({ ...p, nameEn: e.target.value }))}
                placeholder="e.g. Insemination ID"
              />
            </div>
          </div>

          {/* Field type */}
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">Field Type</label>
            <select
              className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
              value={form.fieldType}
              onChange={e => setForm(p => ({ ...p, fieldType: e.target.value as CustomFieldType }))}
            >
              {FIELD_TYPES.map(t => (
                <option key={t.value} value={t.value}>{t.label}</option>
              ))}
            </select>
          </div>

          {/* Options (for select type) */}
          {form.fieldType === 'select' && (
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">
                Options <span className="text-gray-400">(one per line)</span>
              </label>
              <textarea
                className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20 h-24 resize-none"
                value={optionsText}
                onChange={e => setOptionsText(e.target.value)}
                placeholder="Option 1&#10;Option 2&#10;Option 3"
              />
            </div>
          )}

          {/* Species filter */}
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-2">
              Applies to species{' '}
              <span className="text-gray-400">(leave all checked = all species)</span>
            </label>
            <div className="flex flex-wrap gap-2">
              {SPECIES_LIST.map(sp => {
                const checked = form.species === null || form.species.includes(sp)
                return (
                  <button
                    key={sp}
                    type="button"
                    onClick={() => toggleSpecies(sp)}
                    className={`px-3 py-1 rounded-full text-xs font-medium border transition-colors ${
                      checked
                        ? 'bg-[#3B1500] text-white border-[#3B1500]'
                        : 'bg-white text-gray-500 border-gray-200 hover:border-gray-400'
                    }`}
                  >
                    {sp}
                  </button>
                )
              })}
            </div>
          </div>

          {/* Required toggle */}
          <label className="flex items-center gap-3 cursor-pointer">
            <div className="relative">
              <input
                type="checkbox"
                className="sr-only"
                checked={form.required}
                onChange={e => setForm(p => ({ ...p, required: e.target.checked }))}
              />
              <div className={`w-9 h-5 rounded-full transition-colors ${form.required ? 'bg-[#3B1500]' : 'bg-gray-200'}`} />
              <div className={`absolute top-0.5 left-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${form.required ? 'translate-x-4' : ''}`} />
            </div>
            <span className="text-sm text-gray-700">Required field</span>
          </label>

          {/* Order */}
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">Display Order</label>
            <input
              type="number"
              min={0}
              className="w-24 border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20"
              value={form.order}
              onChange={e => setForm(p => ({ ...p, order: parseInt(e.target.value) || 0 }))}
            />
          </div>
        </div>
      </Modal>}
    </div>
  )
}
