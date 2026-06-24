export type Species = 'sheep' | 'goat' | 'camel' | 'cow' | 'horse'

export interface SpeciesTermEntry {
  maleAr: string
  femaleAr: string
  maleEn: string
  femaleEn: string
  // Horse-only: age-aware young terms + breeding terminology
  maleYoungAr?: string
  femaleYoungAr?: string
  maleYoungEn?: string
  femaleYoungEn?: string
  matingAr?: string
  heatAr?: string
}

export type SpeciesTermsMap = Record<Species, SpeciesTermEntry>

export interface Breed {
  id: string
  nameAr: string
  nameEn: string
  species: Species
  isGlobal: boolean
  isArchived: boolean
}

export interface AnimalColor {
  id: string
  nameAr: string
  nameEn: string
  hex: string
  isArchived: boolean
}

export interface AgeClass {
  id: string
  nameAr: string
  nameEn: string
  minMonths: number
  maxMonths: number
  order: number
}

export interface Vaccine {
  id: string
  nameEn: string
  nameAr: string
  species: Species[]
  isArchived: boolean
}

export interface Medication {
  id: string
  nameEn: string
  nameAr: string
  type: 'deworming' | 'treatment'
  species: Species[]
  isArchived: boolean
}

export interface OrgSummary {
  id: string
  name: string
  type: string
  country: string
  ownerUserId: string
  workerIds: string[]
  animalCount?: number
  createdAt?: string
}

export interface UserSummary {
  id: string
  displayName: string
  phone: string
  country: string
  organizationIds: string[]
  createdAt?: string
  isDisabled?: boolean
}

export type CustomFieldType = 'text' | 'number' | 'select' | 'boolean'

export interface CustomField {
  id: string
  nameAr: string
  nameEn: string
  fieldType: CustomFieldType
  options: string[]          // for 'select' type
  species: Species[] | null  // null = all species
  required: boolean
  isArchived: boolean
  order: number
}
