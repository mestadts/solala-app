import { useEffect, useState } from 'react'
import { doc, getDoc, setDoc } from 'firebase/firestore'
import { db } from '../firebase/config'
import PageHeader from '../components/PageHeader'
import { Save, RotateCcw } from 'lucide-react'
import type { Species, SpeciesTermEntry, SpeciesTermsMap } from '../types'

const SPECIES: Species[] = ['sheep', 'goat', 'camel', 'cow', 'horse']

const SPECIES_META: Record<Species, { label: string; emoji: string }> = {
  sheep: { label: 'Sheep', emoji: '🐑' },
  goat:  { label: 'Goat',  emoji: '🐐' },
  camel: { label: 'Camel', emoji: '🐪' },
  cow:   { label: 'Cow',   emoji: '🐄' },
  horse: { label: 'Horse', emoji: '🐎' },
}

const DEFAULT_TERMS: SpeciesTermsMap = {
  sheep: { maleAr: 'طلي',   femaleAr: 'رخلة',  maleEn: 'Ram',        femaleEn: 'Ewe' },
  goat:  { maleAr: 'تيس',   femaleAr: 'عنزة',  maleEn: 'Buck',       femaleEn: 'Doe' },
  camel: { maleAr: 'جمل',   femaleAr: 'ناقة',  maleEn: 'Bull Camel', femaleEn: 'Cow Camel' },
  cow:   { maleAr: 'ثور',   femaleAr: 'بقرة',  maleEn: 'Bull',       femaleEn: 'Cow' },
  horse: {
    maleAr: 'حصان',  femaleAr: 'فرس',     maleEn: 'Stallion',  femaleEn: 'Mare',
    maleYoungAr: 'مهر', femaleYoungAr: 'مهرة', maleYoungEn: 'Foal', femaleYoungEn: 'Filly',
    matingAr: 'تشبيه', heatAr: 'شياع',
  },
}

export default function SpeciesTermsPage() {
  const [terms, setTerms] = useState<SpeciesTermsMap>({ ...DEFAULT_TERMS })
  const [saving, setSaving] = useState(false)
  const [savedMsg, setSavedMsg] = useState('')
  const [loading, setLoading] = useState(true)

  useEffect(() => { loadTerms() }, [])

  const loadTerms = async () => {
    setLoading(true)
    try {
      const snap = await getDoc(doc(db, 'global', 'speciesTerms'))
      if (snap.exists()) {
        const data = snap.data() as Partial<SpeciesTermsMap>
        setTerms(prev => {
          const merged = { ...prev }
          for (const s of SPECIES) {
            if (data[s]) merged[s] = { ...DEFAULT_TERMS[s], ...data[s] }
          }
          return merged
        })
      }
    } finally {
      setLoading(false)
    }
  }

  const save = async () => {
    setSaving(true)
    try {
      await setDoc(doc(db, 'global', 'speciesTerms'), terms)
      setSavedMsg('Saved successfully')
      setTimeout(() => setSavedMsg(''), 2500)
    } catch (e) {
      setSavedMsg('Error saving — try again')
      setTimeout(() => setSavedMsg(''), 3000)
    } finally {
      setSaving(false)
    }
  }

  const reset = () => setTerms({ ...DEFAULT_TERMS })

  const update = (species: Species, field: keyof SpeciesTermEntry, value: string) => {
    setTerms(prev => ({ ...prev, [species]: { ...prev[species], [field]: value } }))
  }

  return (
    <div className="p-6 space-y-6">
      <PageHeader
        title="Species Gender Terms"
        subtitle="Configure male/female labels per species — used in the mobile app"
      />

      {loading ? (
        <div className="text-gray-400 text-sm">Loading…</div>
      ) : (
        <>
          {/* Table */}
          <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
            {/* Header */}
            <div className="grid grid-cols-5 gap-4 px-5 py-3 bg-gray-50 border-b border-gray-100 text-xs font-semibold text-gray-500 uppercase tracking-wide">
              <div>Species</div>
              <div className="text-right">♂ Arabic</div>
              <div className="text-right">♀ Arabic</div>
              <div>♂ English</div>
              <div>♀ English</div>
            </div>

            {/* Rows */}
            {SPECIES.map(s => {
              const meta = SPECIES_META[s]
              const t = terms[s]
              return (
                <div key={s}>
                  {/* Main row */}
                  <div className="grid grid-cols-5 gap-4 px-5 py-4 border-b border-gray-50 items-center hover:bg-gray-50/50 transition-colors">
                    <div className="flex items-center gap-2">
                      <span className="text-xl">{meta.emoji}</span>
                      <span className="font-medium text-[#3B1500] text-sm">{meta.label}</span>
                    </div>
                    <input dir="rtl" value={t.maleAr} onChange={e => update(s, 'maleAr', e.target.value)}
                      className="border border-gray-200 rounded-lg px-3 py-1.5 text-sm text-right focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20 focus:border-[#3B1500]" placeholder="مثال: طلي" />
                    <input dir="rtl" value={t.femaleAr} onChange={e => update(s, 'femaleAr', e.target.value)}
                      className="border border-gray-200 rounded-lg px-3 py-1.5 text-sm text-right focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20 focus:border-[#3B1500]" placeholder="مثال: رخلة" />
                    <input value={t.maleEn} onChange={e => update(s, 'maleEn', e.target.value)}
                      className="border border-gray-200 rounded-lg px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20 focus:border-[#3B1500]" placeholder="e.g. Ram" />
                    <input value={t.femaleEn} onChange={e => update(s, 'femaleEn', e.target.value)}
                      className="border border-gray-200 rounded-lg px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-[#3B1500]/20 focus:border-[#3B1500]" placeholder="e.g. Ewe" />
                  </div>

                  {/* Horse extra fields */}
                  {s === 'horse' && (
                    <div className="bg-amber-50/60 border-b border-gray-100 px-5 py-4 space-y-3">
                      <p className="text-xs font-semibold text-amber-700 uppercase tracking-wide">🐎 Horse — Age-aware & Breeding Terms</p>
                      <div className="grid grid-cols-2 gap-4">
                        <div>
                          <label className="text-xs text-gray-500 mb-1 block">♂ Young Arabic (مهر)</label>
                          <input dir="rtl" value={t.maleYoungAr ?? ''} onChange={e => update(s, 'maleYoungAr', e.target.value)}
                            className="w-full border border-gray-200 rounded-lg px-3 py-1.5 text-sm text-right focus:outline-none focus:ring-2 focus:ring-amber-400/30 focus:border-amber-500" placeholder="مهر" />
                        </div>
                        <div>
                          <label className="text-xs text-gray-500 mb-1 block">♀ Young Arabic (مهرة)</label>
                          <input dir="rtl" value={t.femaleYoungAr ?? ''} onChange={e => update(s, 'femaleYoungAr', e.target.value)}
                            className="w-full border border-gray-200 rounded-lg px-3 py-1.5 text-sm text-right focus:outline-none focus:ring-2 focus:ring-amber-400/30 focus:border-amber-500" placeholder="مهرة" />
                        </div>
                        <div>
                          <label className="text-xs text-gray-500 mb-1 block">♂ Young English (Foal)</label>
                          <input value={t.maleYoungEn ?? ''} onChange={e => update(s, 'maleYoungEn', e.target.value)}
                            className="w-full border border-gray-200 rounded-lg px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-amber-400/30 focus:border-amber-500" placeholder="Foal" />
                        </div>
                        <div>
                          <label className="text-xs text-gray-500 mb-1 block">♀ Young English (Filly)</label>
                          <input value={t.femaleYoungEn ?? ''} onChange={e => update(s, 'femaleYoungEn', e.target.value)}
                            className="w-full border border-gray-200 rounded-lg px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-amber-400/30 focus:border-amber-500" placeholder="Filly" />
                        </div>
                        <div>
                          <label className="text-xs text-gray-500 mb-1 block">Mating Term (تشبيه)</label>
                          <input dir="rtl" value={t.matingAr ?? ''} onChange={e => update(s, 'matingAr', e.target.value)}
                            className="w-full border border-gray-200 rounded-lg px-3 py-1.5 text-sm text-right focus:outline-none focus:ring-2 focus:ring-amber-400/30 focus:border-amber-500" placeholder="تشبيه" />
                        </div>
                        <div>
                          <label className="text-xs text-gray-500 mb-1 block">In Heat Term (شياع)</label>
                          <input dir="rtl" value={t.heatAr ?? ''} onChange={e => update(s, 'heatAr', e.target.value)}
                            className="w-full border border-gray-200 rounded-lg px-3 py-1.5 text-sm text-right focus:outline-none focus:ring-2 focus:ring-amber-400/30 focus:border-amber-500" placeholder="شياع" />
                        </div>
                      </div>
                      <p className="text-xs text-amber-600">Young terms apply to horses under 1 year old. Mating/heat terms appear in breeding records.</p>
                    </div>
                  )}
                </div>
              )
            })}
          </div>

          {/* Actions */}
          <div className="flex items-center gap-3">
            <button
              onClick={save}
              disabled={saving}
              className="flex items-center gap-2 bg-[#3B1500] text-white px-5 py-2.5 rounded-xl text-sm font-medium hover:bg-[#5C2A00] disabled:opacity-50 transition-colors"
            >
              <Save size={15} />
              {saving ? 'Saving…' : 'Save All'}
            </button>
            <button
              onClick={reset}
              className="flex items-center gap-2 border border-gray-200 text-gray-600 px-4 py-2.5 rounded-xl text-sm hover:bg-gray-50 transition-colors"
            >
              <RotateCcw size={15} />
              Reset to Defaults
            </button>
            {savedMsg && (
              <span className={`text-sm font-medium ${savedMsg.startsWith('Error') ? 'text-red-600' : 'text-green-600'}`}>
                {savedMsg}
              </span>
            )}
          </div>

          {/* Info box */}
          <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 text-sm text-amber-800">
            <strong>Note:</strong> Changes take effect in the mobile app the next time users open it
            (the app streams this config from Firestore in real-time).
            The mobile app falls back to the default terms if this document is missing.
          </div>
        </>
      )}
    </div>
  )
}
