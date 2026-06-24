// ─────────────────────────────────────────────────────────────────────────────
// Mock data models (simple maps for UI prototype — replaced with Freezed
// entities in Phase 10 when the real backend is wired in)
// ─────────────────────────────────────────────────────────────────────────────
import '../local/schemas/ownership_record_local_model.dart';
import '../local/schemas/weight_record_local_model.dart';

import 'dart:convert';
import '../constants/livestock_species.dart';
import '../constants/animal_status.dart';
import '../constants/animal_purpose.dart';
import '../local/schemas/animal_local_model.dart';
import '../local/schemas/health_record_local_model.dart';
import '../local/schemas/breeding_record_local_model.dart';

// ── User / Org ────────────────────────────────────────────────────────────────
class MockUser {
  static const id          = 'user-001';
  static const displayName = 'Ahmed Al-Rashidi';
  static const phone       = '+966501234567';
  static const photoUrl    = '';
  static const country     = 'Saudi Arabia';
  static const orgId       = 'org-001';
}

class MockOrg {
  static const id      = 'org-001';
  static const name    = 'Al-Rashidi Farm';
  static const type    = 'Farm';
  static const country = 'Saudi Arabia';
}

// ── Animals ───────────────────────────────────────────────────────────────────
class MockAnimal {
  final String id;
  final String systemAnimalId;
  final String name;
  final LivestockSpecies species;
  final String gender;
  final String breed;       // breedEntry.id from breed_data.dart
  final String dateOfBirth;
  final double weight;
  final AnimalStatus status;
  final String breederTag;
  final String colorId;          // animalColor.id from color_data.dart
  final String tagColorId;       // color of the ear/ID tag
  final int tagNumber;           // numeric tag 0–500
  final String photoUrl;
  final Map<String, dynamic> speciesAttributes;
  // ── Mqane-derived fields (Phase 7B) ──────────────────────────────────────
  final String? penId;           // PenGroup.id from pen_data.dart
  final String? ageClassId;      // AgeClass.id from age_class_data.dart (auto or manual)
  final AnimalPurpose? purpose;  // تربية | تسمين
  final double? price;           // optional market/asking price in SAR
  final int? weaningFromDays;    // weaning window start (age in days)
  final int? weaningToDays;      // weaning window end (age in days)
  final String? officialTagNumber; // optional government/regulatory tag number
  // ── Phase 16 fields ──────────────────────────────────────────────────────
  final String? damId;             // parent animal id (dam/mother)
  final String? sireId;            // parent animal id (sire/father)
  final Map<String, dynamic> customValues; // custom field values {fieldId: value}

  const MockAnimal({
    required this.id,
    required this.systemAnimalId,
    required this.name,
    required this.species,
    required this.gender,
    required this.breed,
    required this.dateOfBirth,
    required this.weight,
    required this.status,
    required this.breederTag,
    this.colorId = 'brown',
    this.tagColorId = '',
    this.tagNumber = 0,
    this.photoUrl = '',
    this.speciesAttributes = const {},
    this.penId,
    this.ageClassId,
    this.purpose,
    this.price,
    this.weaningFromDays,
    this.weaningToDays,
    this.officialTagNumber,
    this.damId,
    this.sireId,
    this.customValues = const {},
  });

  MockAnimal copyWith({
    String? id,
    String? systemAnimalId,
    String? name,
    LivestockSpecies? species,
    String? gender,
    String? breed,
    String? dateOfBirth,
    double? weight,
    AnimalStatus? status,
    String? breederTag,
    String? colorId,
    String? tagColorId,
    int? tagNumber,
    String? photoUrl,
    Map<String, dynamic>? speciesAttributes,
    String? penId,
    String? ageClassId,
    AnimalPurpose? purpose,
    double? price,
    int? weaningFromDays,
    int? weaningToDays,
    String? officialTagNumber,
    String? damId,
    String? sireId,
    Map<String, dynamic>? customValues,
  }) => MockAnimal(
    id: id ?? this.id,
    systemAnimalId: systemAnimalId ?? this.systemAnimalId,
    name: name ?? this.name,
    species: species ?? this.species,
    gender: gender ?? this.gender,
    breed: breed ?? this.breed,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    weight: weight ?? this.weight,
    status: status ?? this.status,
    breederTag: breederTag ?? this.breederTag,
    colorId: colorId ?? this.colorId,
    tagColorId: tagColorId ?? this.tagColorId,
    tagNumber: tagNumber ?? this.tagNumber,
    photoUrl: photoUrl ?? this.photoUrl,
    speciesAttributes: speciesAttributes ?? this.speciesAttributes,
    penId: penId ?? this.penId,
    ageClassId: ageClassId ?? this.ageClassId,
    purpose: purpose ?? this.purpose,
    price: price ?? this.price,
    weaningFromDays: weaningFromDays ?? this.weaningFromDays,
    weaningToDays: weaningToDays ?? this.weaningToDays,
    officialTagNumber: officialTagNumber ?? this.officialTagNumber,
    damId: damId ?? this.damId,
    sireId: sireId ?? this.sireId,
    customValues: customValues ?? this.customValues,
  );

  // ── Isar persistence (Phase 10) ──────────────────────────────────────────
  AnimalLocalModel toLocalModel(String orgId) {
    final model = AnimalLocalModel()
      ..id        = id
      ..orgId     = orgId
      ..systemAnimalId = systemAnimalId
      ..name      = name
      ..species   = species.name
      ..gender    = gender
      ..breed     = breed
      ..dateOfBirth = dateOfBirth
      ..weight    = weight
      ..status    = status.name
      ..breederTag = breederTag
      ..colorId   = colorId
      ..tagColorId = tagColorId
      ..tagNumber = tagNumber
      ..photoUrl  = photoUrl
      ..speciesAttributesJson = jsonEncode(speciesAttributes)
      ..penId     = penId
      ..ageClassId = ageClassId
      ..purpose   = purpose?.name
      ..price     = price
      ..weaningFromDays = weaningFromDays
      ..weaningToDays   = weaningToDays
      ..officialTagNumber = officialTagNumber
      ..damId  = damId
      ..sireId = sireId
      ..customValuesJson = jsonEncode(customValues)
      ..updatedAt = DateTime.now();
    return model;
  }

  factory MockAnimal.fromLocalModel(AnimalLocalModel m) {
    Map<String, dynamic> attrs = {};
    try {
      attrs = Map<String, dynamic>.from(jsonDecode(m.speciesAttributesJson) as Map);
    } catch (_) {}

    return MockAnimal(
      id: m.id,
      systemAnimalId: m.systemAnimalId,
      name: m.name,
      species: LivestockSpecies.values.firstWhere(
          (s) => s.name == m.species,
          orElse: () => LivestockSpecies.sheep),
      gender: m.gender,
      breed: m.breed,
      dateOfBirth: m.dateOfBirth,
      weight: m.weight,
      status: AnimalStatus.values.firstWhere(
          (s) => s.name == m.status,
          orElse: () => AnimalStatus.active),
      breederTag: m.breederTag,
      colorId: m.colorId,
      tagColorId: m.tagColorId,
      tagNumber: m.tagNumber,
      photoUrl: m.photoUrl,
      speciesAttributes: attrs,
      penId: m.penId,
      ageClassId: m.ageClassId,
      purpose: m.purpose == null
          ? null
          : AnimalPurpose.values.firstWhere(
              (p) => p.name == m.purpose,
              orElse: () => AnimalPurpose.breeding),
      price: m.price,
      weaningFromDays: m.weaningFromDays,
      weaningToDays: m.weaningToDays,
      officialTagNumber: m.officialTagNumber,
      damId: m.damId,
      sireId: m.sireId,
      customValues: () {
        try {
          return Map<String, dynamic>.from(
              jsonDecode(m.customValuesJson ?? '{}') as Map);
        } catch (_) {
          return <String, dynamic>{};
        }
      }(),
    );
  }
}

final mockAnimals = <MockAnimal>[
  // a-001: Sheep female, breeding purpose, young (bahm→jadh), pen_1
  const MockAnimal(
    id: 'a-001',
    systemAnimalId: 'SH-26-1',
    name: 'ليلى',
    species: LivestockSpecies.sheep,
    gender: 'female',
    breed: 'sh_najdi',
    dateOfBirth: '2024-03-15',
    weight: 45.5,
    status: AnimalStatus.active,
    breederTag: '1',
    colorId: 'red',
    tagNumber: 1,
    penId: 'pen_1',
    ageClassId: 'jadh',
    purpose: AnimalPurpose.breeding,
    price: 1200.0,
    weaningFromDays: 40,
    weaningToDays: 60,
    speciesAttributes: {'woolType': 'fine', 'hornStatus': 'polled'},
  ),
  // a-002: Camel male, fattening, sudas, pen_4
  const MockAnimal(
    id: 'a-002',
    systemAnimalId: 'CM-26-2',
    name: 'سلطان',
    species: LivestockSpecies.camel,
    gender: 'male',
    breed: 'cm_majaheem',
    dateOfBirth: '2021-07-10',
    weight: 520.0,
    status: AnimalStatus.active,
    breederTag: '7',
    colorId: 'black',
    tagNumber: 7,
    penId: 'pen_5',
    ageClassId: 'sudas',
    purpose: AnimalPurpose.fattening,
    price: 18000.0,
    officialTagNumber: 'SA-CM-2021-007',
    speciesAttributes: {
      'humpType': 'single',
      'classification': 'racing',
      'pedigreeLevel': '1',
      'microchipId': 'MC-20219823',
    },
  ),
  // a-003: Goat female, breeding, bahm, pen_3 (nursing)
  const MockAnimal(
    id: 'a-003',
    systemAnimalId: 'GT-26-3',
    name: 'ريم',
    species: LivestockSpecies.goat,
    gender: 'female',
    breed: 'gt_bishi',
    dateOfBirth: '2023-11-20',
    weight: 32.0,
    status: AnimalStatus.active,
    breederTag: '3',
    colorId: 'black',
    tagNumber: 3,
    penId: 'pen_3',
    ageClassId: 'rubaa',
    purpose: AnimalPurpose.breeding,
    speciesAttributes: {'hornStatus': 'horned'},
  ),
  // a-004: Horse male, breeding, thani, pen_5
  const MockAnimal(
    id: 'a-004',
    systemAnimalId: 'HR-26-4',
    name: 'ثاندر',
    species: LivestockSpecies.horse,
    gender: 'male',
    breed: 'hr_arabian',
    dateOfBirth: '2020-04-05',
    weight: 480.0,
    status: AnimalStatus.active,
    breederTag: '12',
    colorId: 'grey',
    tagNumber: 12,
    penId: 'pen_5',
    ageClassId: 'thani',
    purpose: AnimalPurpose.breeding,
    price: 45000.0,
    speciesAttributes: {
      'height': '15.2 hands',
      'registrationNumber': 'AR-2020-4891',
      'markings': 'white blaze',
    },
  ),
  // a-005: Cow female, breeding, thani, pen_3
  const MockAnimal(
    id: 'a-005',
    systemAnimalId: 'CW-26-5',
    name: 'نور',
    species: LivestockSpecies.cow,
    gender: 'female',
    breed: 'cw_friesian',
    dateOfBirth: '2022-08-12',
    weight: 580.0,
    status: AnimalStatus.active,
    breederTag: '5',
    colorId: 'white',
    tagNumber: 5,
    penId: 'pen_3',
    ageClassId: 'thani',
    purpose: AnimalPurpose.breeding,
    officialTagNumber: 'GOV-CW-2022-005',
    speciesAttributes: {
      'milkYield': '28',
      'lactationCycle': '3',
    },
  ),
  // a-006: Camel male, sold, pen_4 (fattening)
  const MockAnimal(
    id: 'a-006',
    systemAnimalId: 'CM-25-99',
    name: 'فارس',
    species: LivestockSpecies.camel,
    gender: 'male',
    breed: 'cm_omani',
    dateOfBirth: '2019-05-22',
    weight: 610.0,
    status: AnimalStatus.sold,
    breederTag: '99',
    colorId: 'orange',
    tagNumber: 99,
    penId: 'pen_4',
    ageClassId: 'thani',
    purpose: AnimalPurpose.fattening,
    price: 22000.0,
    speciesAttributes: {'humpType': 'single', 'classification': 'pack'},
  ),
  // a-007: Sheep female, for_sale status, bahm (young lamb with weaning window)
  const MockAnimal(
    id: 'a-007',
    systemAnimalId: 'SH-26-7',
    name: '',
    species: LivestockSpecies.sheep,
    gender: 'female',
    breed: 'sh_naeimi',
    dateOfBirth: '2026-01-10',
    weight: 12.0,
    status: AnimalStatus.forSale,
    breederTag: '50',
    colorId: 'white',
    tagNumber: 50,
    penId: 'pen_6',
    ageClassId: 'bahm',
    purpose: AnimalPurpose.breeding,
    price: 800.0,
    weaningFromDays: 40,
    weaningToDays: 60,
    speciesAttributes: {'woolType': 'coarse', 'hornStatus': 'polled'},
  ),
];

// ── Health Records ─────────────────────────────────────────────────────────────
class MockHealthRecord {
  final String id;
  final String animalId;
  final String animalSystemId;
  final String recordType; // vaccination | treatment | checkup
  final String date;
  final String? nextDueDate;
  final String vetName;
  final String notes;
  final String title;

  const MockHealthRecord({
    required this.id,
    required this.animalId,
    required this.animalSystemId,
    required this.recordType,
    required this.date,
    this.nextDueDate,
    required this.vetName,
    required this.notes,
    required this.title,
  });

  HealthRecordLocalModel toLocalModel(String orgId) {
    final model = HealthRecordLocalModel()
      ..id          = id
      ..animalId    = animalId
      ..orgId       = orgId
      ..recordType  = recordType
      ..date        = date
      ..nextDue     = nextDueDate
      ..notes       = notes.isEmpty ? null : notes
      ..vetName     = vetName.isEmpty ? null : vetName
      ..updatedAt   = DateTime.now();
    switch (recordType) {
      case 'vaccination':
        model.vaccineName = title;
      case 'treatment':
        model.treatmentType = title;
      case 'deworming':
        model.dewormingProduct = title;
      case 'pregnancy':
        model.matingDate      = date;
        model.expectedDelivery = nextDueDate;
    }
    return model;
  }

  factory MockHealthRecord.fromLocalModel(HealthRecordLocalModel m) {
    final title = switch (m.recordType) {
      'vaccination' => m.vaccineName    ?? 'Vaccination',
      'treatment'   => m.treatmentType  ?? 'Treatment',
      'deworming'   => m.dewormingProduct ?? 'Deworming',
      'pregnancy'   => 'Pregnancy',
      _             => m.recordType,
    };
    return MockHealthRecord(
      id:             m.id,
      animalId:       m.animalId,
      animalSystemId: '',
      recordType:     m.recordType,
      date:           m.date,
      nextDueDate:    m.nextDue,
      vetName:        m.vetName  ?? '',
      notes:          m.notes    ?? '',
      title:          title,
    );
  }
}

final mockHealthRecords = <MockHealthRecord>[
  const MockHealthRecord(
    id: 'h-001',
    animalId: 'a-001',
    animalSystemId: 'SH-26-1',
    recordType: 'vaccination',
    date: '2026-01-15',
    nextDueDate: '2026-04-15',
    vetName: 'Dr. Khalid Hassan',
    notes: 'Annual FMD vaccination. Animal responded well.',
    title: 'FMD Vaccine',
  ),
  const MockHealthRecord(
    id: 'h-002',
    animalId: 'a-001',
    animalSystemId: 'SH-26-1',
    recordType: 'treatment',
    date: '2025-11-20',
    vetName: 'Dr. Khalid Hassan',
    notes: 'Minor skin irritation treated with topical ointment.',
    title: 'Skin Treatment',
  ),
  const MockHealthRecord(
    id: 'h-003',
    animalId: 'a-002',
    animalSystemId: 'CM-26-2',
    recordType: 'vaccination',
    date: '2026-02-01',
    nextDueDate: '2026-03-01',
    vetName: 'Dr. Sara Al-Mutairi',
    notes: 'MERS-CoV preventive vaccination.',
    title: 'MERS-CoV Vaccine',
  ),
  const MockHealthRecord(
    id: 'h-004',
    animalId: 'a-003',
    animalSystemId: 'GT-26-3',
    recordType: 'vaccination',
    date: '2026-02-20',
    nextDueDate: '2026-02-27',
    vetName: 'Dr. Khalid Hassan',
    notes: 'PPR vaccination — due in 7 days for booster.',
    title: 'PPR Vaccine (Booster due)',
  ),
];

// ── Weight Records ─────────────────────────────────────────────────────────────
class MockWeightRecord {
  final String id;
  final String animalId;
  final double weight;
  final String unit;
  final String recordedAt;
  final bool isOfficial;

  const MockWeightRecord({
    required this.id,
    required this.animalId,
    required this.weight,
    this.unit = 'kg',
    required this.recordedAt,
    this.isOfficial = false,
  });

  WeightRecordLocalModel toLocalModel(String orgId) {
    return WeightRecordLocalModel()
      ..id = id
      ..animalId = animalId
      ..orgId = orgId
      ..value = weight
      ..unit = unit
      ..recordedAt = recordedAt
      ..isOfficial = isOfficial
      ..isSynced = false
      ..pendingOperation = 'create'
      ..updatedAt = DateTime.now()
      ..createdAt = DateTime.now();
  }

  factory MockWeightRecord.fromLocalModel(WeightRecordLocalModel m) {
    return MockWeightRecord(
      id: m.id,
      animalId: m.animalId,
      weight: m.value,
      unit: m.unit,
      recordedAt: m.recordedAt,
      isOfficial: m.isOfficial,
    );
  }
}

final mockWeightRecords = <MockWeightRecord>[
  const MockWeightRecord(id: 'w-001', animalId: 'a-001', weight: 38.0, recordedAt: '2024-06-01'),
  const MockWeightRecord(id: 'w-002', animalId: 'a-001', weight: 41.5, recordedAt: '2024-09-01'),
  const MockWeightRecord(id: 'w-003', animalId: 'a-001', weight: 44.0, recordedAt: '2025-01-10'),
  const MockWeightRecord(id: 'w-004', animalId: 'a-001', weight: 45.5, recordedAt: '2026-01-15', isOfficial: true),
];

// ── Ownership Records ──────────────────────────────────────────────────────────
class MockOwnershipRecord {
  final String id;
  final String animalId;
  final String animalSystemId;
  final String fromOwner;
  final String toOwner;
  final String transferType;
  final String transferDate;
  final double? price;
  final String? currency;
  final String notes;

  const MockOwnershipRecord({
    required this.id,
    required this.animalId,
    required this.animalSystemId,
    required this.fromOwner,
    required this.toOwner,
    required this.transferType,
    required this.transferDate,
    this.price,
    this.currency,
    this.notes = '',
  });

  OwnershipRecordLocalModel toLocalModel(String orgId) {
    return OwnershipRecordLocalModel()
      ..id = id
      ..animalId = animalId
      ..orgId = orgId
      ..transferType = transferType.toLowerCase()
      ..fromOwnerId = fromOwner
      ..toOwnerId = ''
      ..toOwnerName = toOwner
      ..toOwnerPhone = ''
      ..salePrice = price
      ..currency = currency
      ..transferDate = transferDate
      ..notes = notes.isEmpty ? null : notes
      ..isSynced = false
      ..pendingOperation = 'create'
      ..updatedAt = DateTime.now()
      ..createdAt = DateTime.now();
  }

  factory MockOwnershipRecord.fromLocalModel(OwnershipRecordLocalModel m) {
    return MockOwnershipRecord(
      id: m.id,
      animalId: m.animalId,
      animalSystemId: '',
      fromOwner: m.fromOwnerId.isEmpty ? 'Unknown' : m.fromOwnerId,
      toOwner: m.toOwnerName.isEmpty ? m.toOwnerPhone : m.toOwnerName,
      transferType: m.transferType,
      transferDate: m.transferDate,
      price: m.salePrice,
      currency: m.currency,
      notes: m.notes ?? '',
    );
  }
}

final mockOwnershipRecords = <MockOwnershipRecord>[
  const MockOwnershipRecord(
    id: 'o-001',
    animalId: 'a-002',
    animalSystemId: 'CM-26-2',
    fromOwner: 'Ibrahim Al-Rashidi',
    toOwner: 'Ahmed Al-Rashidi',
    transferType: 'Gift',
    transferDate: '2023-06-01',
    notes: 'Inherited from father',
  ),
];

// ── Breeding Records ───────────────────────────────────────────────────────────
class MockBreedingRecord {
  final String id;
  final String animalId;
  final String? damId;
  final String? damName;
  final String? damSystemId;
  final String? sireId;
  final String? sireName;
  final String? sireSystemId;
  final String deliveryDate;
  final int offspringCount;
  final int survivingCount;
  final String notes;

  const MockBreedingRecord({
    required this.id,
    required this.animalId,
    this.damId,
    this.damName,
    this.damSystemId,
    this.sireId,
    this.sireName,
    this.sireSystemId,
    required this.deliveryDate,
    required this.offspringCount,
    required this.survivingCount,
    this.notes = '',
  });

  BreedingRecordLocalModel toLocalModel(String orgId) {
    return BreedingRecordLocalModel()
      ..id             = id
      ..orgId          = orgId
      ..damAnimalId    = damId ?? animalId
      ..damSystemId    = damSystemId ?? ''
      ..damTagDisplay  = damName ?? ''
      ..sireAnimalId   = sireId
      ..sireSystemId   = sireSystemId
      ..sireTagDisplay = sireName
      ..matingDate     = ''
      ..deliveryDate   = deliveryDate.isEmpty ? null : deliveryDate
      ..offspringCount = offspringCount
      ..survivingCount = survivingCount
      ..notes          = notes.isEmpty ? null : notes
      ..isSynced       = false
      ..pendingOperation = 'create'
      ..updatedAt      = DateTime.now();
  }

  factory MockBreedingRecord.fromLocalModel(BreedingRecordLocalModel m) {
    return MockBreedingRecord(
      id:             m.id,
      animalId:       m.damAnimalId,
      damId:          m.damAnimalId,
      damName:        m.damTagDisplay.isEmpty ? null : m.damTagDisplay,
      damSystemId:    m.damSystemId.isEmpty  ? null : m.damSystemId,
      sireId:         m.sireAnimalId,
      sireName:       m.sireTagDisplay,
      sireSystemId:   m.sireSystemId,
      deliveryDate:   m.deliveryDate   ?? '',
      offspringCount: m.offspringCount ?? 0,
      survivingCount: m.survivingCount ?? 0,
      notes:          m.notes          ?? '',
    );
  }
}

final mockBreedingRecords = <MockBreedingRecord>[
  const MockBreedingRecord(
    id: 'b-001',
    animalId: 'a-001',
    damId: 'a-001',
    damName: 'ليلى',
    damSystemId: 'SH-26-1',
    sireName: 'رامي (خارجي)',
    deliveryDate: '2025-03-10',
    offspringCount: 2,
    survivingCount: 2,
    notes: 'توأم، كلاهما بصحة جيدة.',
  ),
  const MockBreedingRecord(
    id: 'b-002',
    animalId: 'a-003',
    damId: 'a-003',
    damName: 'ريم',
    damSystemId: 'GT-26-3',
    sireName: 'نجم (خارجي)',
    deliveryDate: '2025-05-20',
    offspringCount: 1,
    survivingCount: 1,
    notes: 'مولود واحد، أنثى.',
  ),
  // Active pregnancy — delivery in future (used for countdown banner demo)
  const MockBreedingRecord(
    id: 'b-003',
    animalId: 'a-001',
    damId: 'a-001',
    damName: 'ليلى',
    damSystemId: 'SH-26-1',
    sireName: 'فحل خارجي',
    deliveryDate: '2026-05-15',
    offspringCount: 0,
    survivingCount: 0,
    notes: 'حمل نشط — الولادة المتوقعة مايو 2026',
  ),
];

// ── Activity feed ──────────────────────────────────────────────────────────────
class MockActivity {
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final String icon;
  final DateTime? createdAt; // used for locale-aware time display

  const MockActivity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    this.createdAt,
  });
}

final mockActivities = <MockActivity>[
  const MockActivity(id: 'act-1', title: 'Vaccination recorded', subtitle: 'GT-26-3 — PPR Vaccine', timeAgo: '2h ago', icon: '💉'),
  const MockActivity(id: 'act-2', title: 'New animal added', subtitle: 'CW-26-5 — Noor (Cow)', timeAgo: '1d ago', icon: '🐄'),
  const MockActivity(id: 'act-3', title: 'Weight recorded', subtitle: 'SH-26-1 — Layla: 45.5 kg', timeAgo: '3d ago', icon: '⚖️'),
  const MockActivity(id: 'act-4', title: 'Ownership transferred', subtitle: 'CM-25-99 — Faris (Sold)', timeAgo: '5d ago', icon: '🔄'),
  const MockActivity(id: 'act-5', title: 'Vaccination recorded', subtitle: 'CM-26-2 — Sultan: MERS-CoV', timeAgo: '1w ago', icon: '💉'),
];
