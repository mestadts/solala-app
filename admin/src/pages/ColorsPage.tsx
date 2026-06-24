import { useEffect, useState } from 'react'
import { collection, getDocs, doc, setDoc, updateDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import Modal from '../components/Modal'
import { Plus, Pencil, Archive, ArchiveRestore } from 'lucide-react'
import type { AnimalColor } from '../types'

const defaultGeneralColors: Omit<AnimalColor, 'id'>[] = [
  { nameAr: 'أحمر', nameEn: 'Red', hex: '#FF3B30', isArchived: false },
  { nameAr: 'أصفر', nameEn: 'Yellow', hex: '#FFD60A', isArchived: false },
  { nameAr: 'أزرق', nameEn: 'Blue', hex: '#00C7BE', isArchived: false },
  { nameAr: 'أبيض', nameEn: 'White', hex: '#F5F5F5', isArchived: false },
  { nameAr: 'أخضر', nameEn: 'Green', hex: '#30D158', isArchived: false },
  { nameAr: 'برتقالي', nameEn: 'Orange', hex: '#FF9F0A', isArchived: false },
  { nameAr: 'بنفسجي', nameEn: 'Purple', hex: '#BF5AF2', isArchived: false },
  { nameAr: 'وردي', nameEn: 'Pink', hex: '#FF375F', isArchived: false },
  { nameAr: 'أسود', nameEn: 'Black', hex: '#1C1C1E', isArchived: false },
  { nameAr: 'رمادي', nameEn: 'Gray', hex: '#8E8E93', isArchived: false },
  { nameAr: 'وردي فاتح', nameEn: 'Light Pink', hex: '#FFB3C6', isArchived: false },
  { nameAr: 'أحمر فاتح', nameEn: 'Light Red', hex: '#FF6B6B', isArchived: false },
  { nameAr: 'بنفسجي فاتح', nameEn: 'Light Purple', hex: '#DDA0DD', isArchived: false },
  { nameAr: 'أخضر فاتح', nameEn: 'Light Green', hex: '#90EE90', isArchived: false },
  { nameAr: 'تفاحي', nameEn: 'Lime', hex: '#BFFF00', isArchived: false },
  { nameAr: 'أزرق فاتح', nameEn: 'Light Blue', hex: '#AEF0F0', isArchived: false },
]

const defaultHorseColors: Omit<AnimalColor, 'id'>[] = [
  { nameAr: 'الأشقر',            nameEn: 'Chestnut',         hex: '#C0622F', isArchived: false },
  { nameAr: 'الأحمر',            nameEn: 'Bay',              hex: '#8B3A2A', isArchived: false },
  { nameAr: 'الأدهم',            nameEn: 'Black',            hex: '#1C1C1E', isArchived: false },
  { nameAr: 'الأصفر',            nameEn: 'Gray/White',       hex: '#E8E4D9', isArchived: false },
  { nameAr: 'الأشقر المذهب',     nameEn: 'Palomino',         hex: '#D4A017', isArchived: false },
  { nameAr: 'الكميت',            nameEn: 'Dark Bay',         hex: '#4A1C0A', isArchived: false },
  { nameAr: 'الأزرق',            nameEn: 'Blue Roan',        hex: '#7A8C9A', isArchived: false },
  { nameAr: 'الأصفر المرشوش',    nameEn: 'Dapple Gray',      hex: '#B0B8B8', isArchived: false },
  { nameAr: 'الأشقر المحروق',    nameEn: 'Dark Chestnut',    hex: '#7B3A1E', isArchived: false },
  { nameAr: 'الأحمر ورد',        nameEn: 'Rose Bay',         hex: '#B5664E', isArchived: false },
  { nameAr: 'الأبلق',            nameEn: 'Piebald',          hex: '#AAAAAA', isArchived: false },
  { nameAr: 'الأشعل',            nameEn: 'Flea-bitten Gray', hex: '#9E9E9E', isArchived: false },
]

const empty: Omit<AnimalColor, 'id'> = { nameAr: '', nameEn: '', hex: '#8B6340', isArchived: false }

export default function ColorsPage() {
  const [colors, setColors] = useState<AnimalColor[]>([])
  const [horseColors, setHorseColors] = useState<AnimalColor[]>([])
  const [showModal, setShowModal] = useState(false)
  const [editing, setEditing] = useState<AnimalColor | null>(null)
  const [form, setForm] = useState(empty)
  const [saving, setSaving] = useState(false)
  const [seeding, setSeeding] = useState(false)
  const [seedingHorse, setSeedingHorse] = useState(false)

  useEffect(() => { loadColors() }, [])

  const loadColors = async () => {
    const [generalSnap, horseSnap] = await Promise.all([
      getDocs(collection(db, 'global', 'lists', 'colors')),
      getDocs(collection(db, 'global', 'lists', 'horseColors')),
    ])
    setColors(generalSnap.docs.map(d => ({ id: d.id, ...d.data() } as AnimalColor)))
    setHorseColors(horseSnap.docs.map(d => ({ id: d.id, ...d.data() } as AnimalColor)))
  }

  const seedDefaults = async () => {
    setSeeding(true)
    for (const c of defaultGeneralColors) {
      const id = c.nameEn.toLowerCase().replace(/\s+/g, '_')
      await setDoc(doc(db, 'global', 'lists', 'colors', id), c)
    }
    await loadColors()
    setSeeding(false)
  }

  const seedHorseColors = async () => {
    setSeedingHorse(true)
    for (const c of defaultHorseColors) {
      const id = 'horse_' + c.nameEn.toLowerCase().replace(/[\s/\-]+/g, '_')
      await setDoc(doc(db, 'global', 'lists', 'horseColors', id), c)
    }
    await loadColors()
    setSeedingHorse(false)
  }

  const openAdd = () => { setEditing(null); setForm(empty); setShowModal(true) }
  const openEdit = (c: AnimalColor) => { setEditing(c); setForm({ nameAr: c.nameAr, nameEn: c.nameEn, hex: c.hex, isArchived: c.isArchived }); setShowModal(true) }

  const save = async () => {
    if (!form.nameAr || !form.nameEn) return
    setSaving(true)
    const id = editing?.id ?? form.nameEn.toLowerCase().replace(/\s+/g, '_') + '_' + Date.now()
    await setDoc(doc(db, 'global', 'lists', 'colors', id), { ...form })
    await loadColors()
    setSaving(false)
    setShowModal(false)
  }

  const toggleArchive = async (c: AnimalColor) => {
    await updateDoc(doc(db, 'global', 'lists', 'colors', c.id), { isArchived: !c.isArchived })
    await loadColors()
  }

  return (
    <div>
      <PageHeader
        title="Color Lists"
        subtitle="Manage the 16-color animal palette"
        action={
          <div className="flex gap-2">
            {colors.length === 0 && (
              <button onClick={seedDefaults} disabled={seeding} className="flex items-center gap-2 bg-amber-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-amber-700 disabled:opacity-60">
                {seeding ? 'Seeding…' : '⚡ Seed Default 16 Colors'}
              </button>
            )}
            <button onClick={openAdd} className="flex items-center gap-2 bg-[#3B1500] text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-[#5a2200] transition-colors">
              <Plus size={16} /> Add Color
            </button>
          </div>
        }
      />
      <div className="p-8">
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-3">
          {colors.map(c => (
            <div key={c.id} className={`bg-white rounded-xl border border-gray-100 shadow-sm p-4 ${c.isArchived ? 'opacity-50' : ''}`}>
              <div className="flex items-center gap-3 mb-3">
                <div className="w-10 h-10 rounded-lg border border-gray-200 flex-shrink-0" style={{ background: c.hex }} />
                <div className="min-w-0">
                  <div className="text-sm font-medium text-gray-900 truncate" dir="rtl">{c.nameAr}</div>
                  <div className="text-xs text-gray-500 truncate">{c.nameEn}</div>
                </div>
              </div>
              <div className="text-xs font-mono text-gray-400 mb-3">{c.hex}</div>
              <div className="flex gap-1">
                <button onClick={() => openEdit(c)} className="flex-1 text-xs text-gray-500 hover:text-gray-700 border border-gray-200 rounded py-1 flex items-center justify-center gap-1 hover:bg-gray-50">
                  <Pencil size={12} /> Edit
                </button>
                <button onClick={() => toggleArchive(c)} className="flex-1 text-xs text-gray-500 hover:text-gray-700 border border-gray-200 rounded py-1 flex items-center justify-center gap-1 hover:bg-gray-50">
                  {c.isArchived ? <ArchiveRestore size={12} /> : <Archive size={12} />}
                  {c.isArchived ? 'Restore' : 'Archive'}
                </button>
              </div>
            </div>
          ))}
          {colors.length === 0 && (
            <div className="col-span-full py-10 text-center text-gray-400 text-sm">
              No colors yet. Click "Seed Default 16 Colors" to populate the standard palette.
            </div>
          )}
        </div>
      </div>

      {/* Horse Colors Section */}
      <div className="px-8 pb-8">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h2 className="text-base font-semibold text-[#3B1500]">🐎 Horse Coat Colors</h2>
            <p className="text-xs text-gray-400 mt-0.5">Stored in global/lists/horseColors — shown only when adding a horse</p>
          </div>
          {horseColors.length === 0 && (
            <button onClick={seedHorseColors} disabled={seedingHorse}
              className="flex items-center gap-2 bg-amber-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-amber-700 disabled:opacity-60">
              {seedingHorse ? 'Seeding…' : '⚡ Seed 12 Horse Colors'}
            </button>
          )}
        </div>
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 gap-3">
          {horseColors.map(c => (
            <div key={c.id} className="bg-white rounded-xl border border-gray-100 shadow-sm p-3">
              <div className="flex items-center gap-2 mb-1">
                <div className="w-8 h-8 rounded-lg border border-gray-200 flex-shrink-0" style={{ background: c.hex }} />
                <div className="min-w-0">
                  <div className="text-xs font-medium text-gray-900 truncate" dir="rtl">{c.nameAr}</div>
                  <div className="text-xs text-gray-400 truncate">{c.nameEn}</div>
                </div>
              </div>
            </div>
          ))}
          {horseColors.length === 0 && (
            <div className="col-span-full py-8 text-center text-gray-400 text-sm">
              No horse colors yet. Click "Seed 12 Horse Colors" to populate.
            </div>
          )}
        </div>
      </div>

      {showModal && (
        <Modal
          title={editing ? 'Edit Color' : 'Add Color'}
          onClose={() => setShowModal(false)}
          footer={
            <>
              <button onClick={() => setShowModal(false)} className="px-4 py-2 text-sm text-gray-600">Cancel</button>
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
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" placeholder="اسم اللون" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">English Name <span className="text-red-500">*</span></label>
              <input value={form.nameEn} onChange={e => setForm(f => ({ ...f, nameEn: e.target.value }))}
                className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none" placeholder="Color name" />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Hex Color</label>
              <div className="flex gap-3 items-center">
                <input type="color" value={form.hex} onChange={e => setForm(f => ({ ...f, hex: e.target.value }))}
                  className="w-12 h-10 rounded border border-gray-200 cursor-pointer p-0.5" />
                <input value={form.hex} onChange={e => setForm(f => ({ ...f, hex: e.target.value }))}
                  className="flex-1 px-3 py-2 border border-gray-200 rounded-lg text-sm font-mono focus:outline-none" placeholder="#RRGGBB" />
              </div>
            </div>
          </div>
        </Modal>
      )}
    </div>
  )
}
