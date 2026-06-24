import 'dart:io';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart' as xl;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/animal_purpose.dart';
import '../../../../core/constants/animal_status.dart';
import '../../../../core/constants/color_data.dart';
import '../../../../core/constants/age_class_data.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/sync/sync_queue_manager.dart';
import '../../../../core/utils/animal_id_generator.dart';
import '../../../../features/animals/data/datasources/local_animal_datasource.dart';
import '../../../../features/animals/presentation/providers/animal_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/herd_primary_button.dart';

// ── Column header → HerdIQ field auto-mapping ─────────────────────────────────
// Covers Arabic headers from all major livestock apps + English equivalents.
const _fieldMapping = <String, String>{
  // ── Tag / number ──────────────────────────────────────────────────────────
  'رقم الرأس':        'tagNumber',
  'الرقم':            'tagNumber',
  'رقم الوسم':        'tagNumber',
  'رقم':              'tagNumber',
  'Number':           'tagNumber',
  'Tag':              'tagNumber',
  'Tag Number':       'tagNumber',
  // ── Color ─────────────────────────────────────────────────────────────────
  'اللون':            'colorId',
  'اختر اللون':       'colorId',
  'Color':            'colorId',
  // ── Breed / classification ────────────────────────────────────────────────
  'التصنيف':          'breed',
  'النوع':            'breed',
  'السلالة':          'breed',
  'Breed':            'breed',
  'Type':             'breed',
  // ── Species ───────────────────────────────────────────────────────────────
  'الفصيلة':          'species',
  'Species':          'species',
  // ── Gender ────────────────────────────────────────────────────────────────
  'الجنس':            'gender',
  'Gender':           'gender',
  'Sex':              'gender',
  // ── Date of birth ─────────────────────────────────────────────────────────
  'تاريخ الولاده':    'dob',
  'تاريخ الميلاد':    'dob',
  'Date of Birth':    'dob',
  'DOB':              'dob',
  'Birth Date':       'dob',
  // ── Age class (computed field — used to infer age class when DOB is missing)
  'السن':             'ageText',   // e.g. "العمر (43) يوم" — parsed below
  'Age':              'ageText',
  // ── Weight ────────────────────────────────────────────────────────────────
  'وزن الرأس':        'weight',
  'الوزن':            'weight',
  'Weight':           'weight',
  // ── Name ──────────────────────────────────────────────────────────────────
  'إسم الرأس':        'name',
  'الاسم':            'name',
  'Name':             'name',
  // ── Pen / group ───────────────────────────────────────────────────────────
  'رقم الحظيرة':      'penGroup',
  'اسم الحظيرة':      'penGroup',
  'الحظيرة':          'penGroup',
  'Pen':              'penGroup',
  'Group':            'penGroup',
  // ── Parents ───────────────────────────────────────────────────────────────
  'الأم - الرقم':     'damTag',
  'الأم الرقم':       'damTag',
  'الأب - الرقم':     'sireTag',
  'الأب الرقم':       'sireTag',
  'Dam Tag':          'damTag',
  'Sire Tag':         'sireTag',
  // ── Purpose ───────────────────────────────────────────────────────────────
  'الغرض':            'purpose',
  'Purpose':          'purpose',
  // ── Status ────────────────────────────────────────────────────────────────
  'الحالة':           'status',
  'Status':           'status',
  // ── Notes ─────────────────────────────────────────────────────────────────
  'ملاحظات':          'notes',
  'Notes':            'notes',
  // ── Fields to silently skip ───────────────────────────────────────────────
  'السعر':            'skip',
  'المرض':            'skip',    // health column — not an animal field
  'تاريخ الدافع':     'skip',    // vaccination date — handled in health records
  'Official Tag':     'officialTag',
  'الرقم الرسمي':     'officialTag',
};

// ── Value resolver helpers ────────────────────────────────────────────────────

String _resolveColorId(String name) {
  final n = name.trim();
  try {
    return animalColors
        .firstWhere(
          (c) => c.nameAr == n || c.nameEn.toLowerCase() == n.toLowerCase(),
          orElse: () => animalColors.first,
        )
        .id;
  } catch (_) {
    return animalColors.first.id;
  }
}

String _resolveGender(String v) {
  final n = v.trim();
  if (n == 'ذكر' || n.toLowerCase() == 'male') return 'Male';
  if (n == 'أنثى' || n == 'انثى' || n.toLowerCase() == 'female') return 'Female';
  return 'Male';
}

LivestockSpecies _resolveSpecies(String v) {
  final n = v.trim().toLowerCase();
  if (n == 'ماعز' || n == 'goat') return LivestockSpecies.goat;
  if (n == 'إبل' || n == 'ابل' || n == 'camel') return LivestockSpecies.camel;
  if (n == 'أبقار' || n == 'ابقار' || n == 'بقر' || n == 'cow') return LivestockSpecies.cow;
  if (n == 'خيول' || n == 'حصان' || n == 'horse') return LivestockSpecies.horse;
  return LivestockSpecies.sheep;
}

String? _resolveAgeClass(String v) {
  final n = v.trim();
  if (n.isEmpty) return null;

  // Try direct name match first (e.g. "بهم", "جذع")
  for (final ac in ageClasses) {
    if (ac.nameAr == n || ac.nameEn.toLowerCase() == n.toLowerCase()) {
      return ac.id;
    }
  }

  // Parse "العمر (X) يوم" or "العمر (X) شهر" formats
  final dayMatch = RegExp(r'العمر\s*\((\d+)\)\s*يوم').firstMatch(n);
  if (dayMatch != null) {
    final days = int.tryParse(dayMatch.group(1) ?? '') ?? 0;
    final months = (days / 30).floor();
    return _ageClassFromMonths(months);
  }
  final monthMatch = RegExp(r'العمر\s*\((\d+)\)\s*شهر').firstMatch(n);
  if (monthMatch != null) {
    final months = int.tryParse(monthMatch.group(1) ?? '') ?? 0;
    return _ageClassFromMonths(months);
  }
  return null;
}

String? _ageClassFromMonths(int months) {
  if (months < 12) return 'bahm';
  if (months < 24) return 'jadh';
  if (months < 36) return 'thani';
  if (months < 48) return 'rubaa';
  if (months < 60) return 'sudas';
  return 'tam';
}

AnimalStatus _resolveStatus(String v) {
  switch (v.trim()) {
    case 'نشط':   case 'active':   return AnimalStatus.active;
    case 'ذبح':   case 'for_sale': return AnimalStatus.forSale;
    case 'صدقة':  case 'charity':  return AnimalStatus.charity;
    case 'عارية': case 'loaned':   return AnimalStatus.loaned;
    case 'للبيع':                  return AnimalStatus.forSale;
    case 'محجوز': case 'reserved': return AnimalStatus.reserved;
    case 'مباع':  case 'sold':     return AnimalStatus.sold;
    case 'نافق':  case 'deceased': return AnimalStatus.deceased;
    case 'مفقود': case 'missing':  return AnimalStatus.missing;
    default:                       return AnimalStatus.active;
  }
}

String? _resolvePurpose(String v) {
  final n = v.trim();
  if (n == 'تربية' || n.toLowerCase() == 'breeding') return 'breeding';
  if (n == 'تسمين' || n.toLowerCase() == 'fattening') return 'fattening';
  return null;
}

// ── Parse CSV bytes to rows ───────────────────────────────────────────────────
List<List<String>> _parseCsv(List<int> bytes) {
  final content = String.fromCharCodes(bytes);
  final result = const CsvToListConverter(eol: '\n').convert(content);
  // Also try \r\n
  if (result.length <= 1) {
    final result2 = const CsvToListConverter(eol: '\r\n').convert(content);
    if (result2.length > result.length) {
      return result2.map((r) => r.map((c) => c.toString().trim()).toList()).toList();
    }
  }
  return result.map((r) => r.map((c) => c.toString().trim()).toList()).toList();
}

// ── Parse XLSX bytes to rows ──────────────────────────────────────────────────
List<List<String>> _parseXlsx(List<int> bytes) {
  try {
    final excel = xl.Excel.decodeBytes(bytes);
    // Prefer sheet named 'البيانات', fallback to first sheet
    xl.Sheet? sheet;
    for (final name in excel.tables.keys) {
      if (name == 'البيانات') {
        sheet = excel.tables[name];
        break;
      }
    }
    sheet ??= excel.tables[excel.tables.keys.first];
    if (sheet == null) return [];

    final rows = <List<String>>[];
    for (final row in sheet.rows) {
      final cells = row.map((c) => (c?.value?.toString() ?? '').trim()).toList();
      // Skip completely empty rows
      if (cells.every((c) => c.isEmpty)) continue;
      rows.add(cells);
    }
    return rows;
  } catch (_) {
    return [];
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class CsvImportPage extends ConsumerStatefulWidget {
  const CsvImportPage({super.key});

  @override
  ConsumerState<CsvImportPage> createState() => _CsvImportPageState();
}

class _CsvImportPageState extends ConsumerState<CsvImportPage> {
  // 0=Upload  1=Preview  2=Importing  3=Done
  int _step = 0;

  bool _isLoading = false;
  String _fileName = '';
  String _errorMsg = '';

  List<String> _headers = [];
  List<List<String>> _dataRows = []; // excludes header row
  Map<String, String> _mappings = {};  // header → herdiqField

  int _importedCount = 0;

  void _back() {
    if (_step > 0 && _step < 2) {
      setState(() { _step--; _errorMsg = ''; });
    } else if (_step == 0) {
      context.pop();
    }
  }

  void _next() => setState(() => _step++);

  Future<void> _pickFile() async {
    setState(() { _isLoading = true; _errorMsg = ''; });
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'xlsx', 'xls'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        setState(() => _isLoading = false);
        return;
      }

      final file = result.files.first;
      final bytes = file.bytes;
      List<int> fileBytes;

      if (bytes != null) {
        fileBytes = bytes.toList();
      } else if (file.path != null) {
        fileBytes = await File(file.path!).readAsBytes();
      } else {
        setState(() {
          _isLoading = false;
          _errorMsg = 'تعذّر قراءة الملف. حاول مرة أخرى.';
        });
        return;
      }

      List<List<String>> allRows;
      final ext = (file.extension ?? '').toLowerCase();
      if (ext == 'xlsx' || ext == 'xls') {
        allRows = _parseXlsx(fileBytes);
      } else {
        allRows = _parseCsv(fileBytes);
      }

      if (allRows.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMsg = 'الملف فارغ أو تعذّر قراءته. تأكد من صحة الملف وحاول مرة أخرى.';
        });
        return;
      }

      // First row = headers
      final headers = allRows.first;
      final dataRows = allRows.skip(1).where((r) => r.any((c) => c.isNotEmpty)).toList();

      if (dataRows.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMsg = 'لا توجد بيانات في الملف بعد السطر الأول.';
        });
        return;
      }

      // Auto-map columns
      final mappings = <String, String>{};
      for (final h in headers) {
        mappings[h] = _fieldMapping[h] ?? _fieldMapping[h.trim()] ?? 'skip';
      }

      setState(() {
        _isLoading = false;
        _fileName = file.name;
        _headers = headers;
        _dataRows = dataRows;
        _mappings = mappings;
      });
      _next(); // go to preview
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMsg = 'حدث خطأ أثناء فتح الملف: ${e.toString().split('\n').first}';
      });
    }
  }

  void _startImport() {
    _next(); // advance to importing step immediately
    _runImport();
  }

  Future<void> _runImport() async {
    setState(() => _importedCount = 0);

    final orgId = ref.read(currentOrgIdProvider) ?? '';
    final local = ref.read(localAnimalDatasourceProvider);
    final syncQueue = ref.read(syncQueueManagerProvider);
    final ts = DateTime.now().millisecondsSinceEpoch;

    for (int i = 0; i < _dataRows.length; i++) {
      if (!mounted) return;

      final row = _dataRows[i];
      final vals = <String, String>{};
      for (int j = 0; j < _headers.length; j++) {
        final field = _mappings[_headers[j]] ?? 'skip';
        if (field != 'skip' && j < row.length) {
          vals[field] = row[j].trim();
        }
      }

      final species = _resolveSpecies(vals['species'] ?? '');
      final colorId = (vals['colorId'] ?? '').isNotEmpty
          ? _resolveColorId(vals['colorId']!)
          : animalColors.first.id;
      final tagNumber = int.tryParse(vals['tagNumber'] ?? '') ?? (100 + i);

      // Age class: prefer from ageText, fallback to DOB calculation
      String? ageClassId = (vals['ageText'] ?? '').isNotEmpty
          ? _resolveAgeClass(vals['ageText']!)
          : null;
      if (ageClassId == null && (vals['dob'] ?? '').isNotEmpty) {
        try {
          final dob = DateTime.parse(vals['dob']!);
          final months = DateTime.now().difference(dob).inDays ~/ 30;
          ageClassId = _ageClassFromMonths(months);
        } catch (_) {}
      }

      final purposeStr = _resolvePurpose(vals['purpose'] ?? '');
      final purpose = purposeStr == 'breeding'
          ? AnimalPurpose.breeding
          : purposeStr == 'fattening'
              ? AnimalPurpose.fattening
              : null;

      final status = (vals['status'] ?? '').isNotEmpty
          ? _resolveStatus(vals['status']!)
          : AnimalStatus.active;

      final animal = MockAnimal(
        id: 'import-$ts-$i',
        systemAnimalId: AnimalIdGenerator.generateLocal(),
        name: vals['name'] ?? '',
        species: species,
        gender: _resolveGender(vals['gender'] ?? ''),
        breed: vals['breed'] ?? '',
        dateOfBirth: vals['dob'] ?? '',
        weight: double.tryParse(vals['weight'] ?? '') ?? 0,
        status: status,
        breederTag: vals['tagNumber'] ?? '',
        colorId: colorId,
        tagColorId: colorId,
        tagNumber: tagNumber,
        ageClassId: ageClassId,
        purpose: purpose,
        penId: (vals['penGroup'] ?? '').isNotEmpty ? vals['penGroup'] : null,
        officialTagNumber: (vals['officialTag'] ?? '').isNotEmpty
            ? vals['officialTag']
            : null,
      );

      // Phase F1: Write to Isar (real local storage) so dashboard + animals list reflect import
      final model = animal.toLocalModel(orgId)
        ..isSynced = false
        ..pendingOperation = 'create';
      await local.saveModel(model);

      // Enqueue for background Firestore sync when online
      await syncQueue.enqueue(
        entityType: 'animals',
        entityId: model.id,
        operation: 'create',
        payload: {
          'id': model.id,
          'orgId': model.orgId,
          'systemAnimalId': model.systemAnimalId,
          'name': model.name,
          'species': model.species,
          'gender': model.gender,
          'breed': model.breed,
          'dateOfBirth': model.dateOfBirth,
          'weight': model.weight,
          'status': model.status,
          'breederTag': model.breederTag,
          'colorId': model.colorId,
          'tagColorId': model.tagColorId,
          'tagNumber': model.tagNumber,
          'photoUrl': model.photoUrl,
          'speciesAttributesJson': model.speciesAttributesJson,
          'penId': model.penId,
          'ageClassId': model.ageClassId,
          'purpose': model.purpose,
          'price': model.price,
          'weaningFromDays': model.weaningFromDays,
          'weaningToDays': model.weaningToDays,
          'officialTagNumber': model.officialTagNumber,
          'damId': model.damId,
          'sireId': model.sireId,
          'createdAt': model.createdAt.toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      // Phase F2: No artificial delay — update counter immediately
      setState(() => _importedCount = i + 1);
    }

    if (!mounted) return;
    _next(); // go to done step
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // ── App bar ────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isRtl
                            ? Icons.arrow_forward_ios_rounded
                            : Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      onPressed: _back,
                    ),
                    Text(
                      l.importTitle,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Step indicator (3 steps) ───────────────────────────────────
              if (_step < 3)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenPadding, 16,
                      AppSpacing.screenPadding, 0),
                  child: Row(
                    children: [
                      for (int i = 0; i < 3; i++) ...[
                        Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 4,
                            decoration: BoxDecoration(
                              color: i <= _step
                                  ? AppColors.primary
                                  : AppColors.tan.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        if (i < 2) const SizedBox(width: 4),
                      ],
                    ],
                  ),
                ),
              if (_step < 3)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenPadding, 6,
                      AppSpacing.screenPadding, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final label in [
                        l.importStep0,
                        l.importStep2,
                        l.importStep3,
                      ])
                        Text(
                          label,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 10,
                          ),
                        ),
                    ],
                  ),
                ),

              // ── Step content ───────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding),
                  child: _buildStep(l),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(AppL l) {
    switch (_step) {
      case 0:
        return _buildUpload(l);
      case 1:
        return _buildPreview(l);
      case 2:
        return _buildImporting(l);
      case 3:
        return _buildDone(l);
      default:
        return const SizedBox.shrink();
    }
  }

  // ── Step 0: Upload ──────────────────────────────────────────────────────────

  Widget _buildUpload(AppL l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          l.importPickTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.importPickSubtitle,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 28),

        // Upload area
        GestureDetector(
          onTap: _isLoading ? null : _pickFile,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              border: Border.all(
                color: AppColors.tan.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2.5,
                    ),
                  )
                : Column(
                    children: [
                      const Text('📂', style: TextStyle(fontSize: 52)),
                      const SizedBox(height: 14),
                      Text(
                        l.importPickTap,
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l.importPickTypes,
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
          ),
        ),

        // Error message
        if (_errorMsg.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.statusDeceased.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              border: Border.all(
                  color: AppColors.statusDeceased.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.error_outline_rounded,
                    size: 18, color: AppColors.statusDeceased),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _errorMsg,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.statusDeceased),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 32),
      ],
    );
  }

  // ── Step 1: Preview ─────────────────────────────────────────────────────────

  Widget _buildPreview(AppL l) {
    // Count how many columns were successfully mapped (not 'skip')
    final mappedCount = _mappings.values.where((v) => v != 'skip').length;
    final previewRows = _dataRows.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          l.importPreviewTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 6),

        // Summary chips row
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _InfoChip(
              icon: Icons.table_rows_rounded,
              label: l.importRowsDetected(_dataRows.length),
              color: AppColors.primary,
            ),
            _InfoChip(
              icon: Icons.check_circle_outline_rounded,
              label: l.importAutoMapped(mappedCount),
              color: AppColors.statusActive,
            ),
            _InfoChip(
              icon: Icons.insert_drive_file_outlined,
              label: _fileName,
              color: AppColors.brown,
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Column mapping summary (read-only chips)
        Text(
          l.importDetectedColumns,
          style: AppTypography.labelMedium,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _headers.map((h) {
            final field = _mappings[h] ?? 'skip';
            final isMapped = field != 'skip';
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isMapped
                    ? AppColors.primary.withValues(alpha: 0.07)
                    : AppColors.tan.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isMapped
                      ? AppColors.primary.withValues(alpha: 0.25)
                      : AppColors.tan.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                isMapped ? h : '$h ✕',
                style: AppTypography.bodySmall.copyWith(
                  color:
                      isMapped ? AppColors.primary : AppColors.textMuted,
                  fontWeight:
                      isMapped ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // First 5 rows preview table
        if (previewRows.isNotEmpty) ...[
          Text(
            l.importPreviewTitle,
            style: AppTypography.labelMedium,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 36,
                dataRowMinHeight: 36,
                dataRowMaxHeight: 44,
                columnSpacing: 16,
                headingTextStyle: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontSize: 11,
                ),
                dataTextStyle: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
                columns: _headers
                    .map((h) => DataColumn(label: Text(h)))
                    .toList(),
                rows: previewRows
                    .map(
                      (row) => DataRow(
                        cells: List.generate(
                          _headers.length,
                          (j) => DataCell(
                            Text(j < row.length ? row[j] : ''),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          if (_dataRows.length > 5)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '... ${_dataRows.length - 5} ${l.importMoreRows}',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textMuted),
              ),
            ),
        ],

        const SizedBox(height: 28),
        HerdPrimaryButton(
          label: l.importBtn(_dataRows.length),
          onPressed: _startImport,
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  // ── Step 2: Importing ───────────────────────────────────────────────────────

  Widget _buildImporting(AppL l) {
    final progress =
        _dataRows.isEmpty ? 0.0 : _importedCount / _dataRows.length;

    return Column(
      children: [
        const SizedBox(height: 60),
        const Text('🐄', style: TextStyle(fontSize: 64)),
        const SizedBox(height: 20),
        Text(
          l.importProgressTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: AppColors.tan.withValues(alpha: 0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l.importProgress(_importedCount, _dataRows.length),
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.brown,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  // ── Step 3: Done ────────────────────────────────────────────────────────────

  Widget _buildDone(AppL l) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.statusActive.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.check_rounded,
                size: 48, color: AppColors.statusActive),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l.importSuccessTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          l.importSuccessMsg(_importedCount),
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.brown,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          l.importSuccessNote,
          style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: HerdPrimaryButton(
            label: l.importViewAnimals,
            onPressed: () => context.pop(),
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

// ── Info chip widget ──────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _InfoChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
