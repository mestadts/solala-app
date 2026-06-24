// Pen/Group management — per-organization enclosure tracking.
// Confirmed from Mqane: رقم الحظيرة dropdown on add-animal form.
// In Phase 9+: pens are stored in Firestore orgs/{orgId}/pens
// In UI prototype: mock pens are used.

class PenGroup {
  final String id;
  final String name;
  final String? description;

  const PenGroup({
    required this.id,
    required this.name,
    this.description,
  });
}

/// Sample pens for the UI prototype.
/// Replaced with per-org Firestore data in Phase 9.
final List<PenGroup> mockPens = [
  const PenGroup(id: 'pen_1', name: 'الحظيرة الرئيسية',  description: 'Main pen'),
  const PenGroup(id: 'pen_2', name: 'حظيرة الحوامل',     description: 'Pregnant females'),
  const PenGroup(id: 'pen_3', name: 'حظيرة المرضعات',    description: 'Nursing mothers'),
  const PenGroup(id: 'pen_4', name: 'حظيرة التسمين',     description: 'Fattening pen'),
  const PenGroup(id: 'pen_5', name: 'حظيرة الذكور',      description: 'Males'),
  const PenGroup(id: 'pen_6', name: 'حظيرة البهم',       description: 'Lambs/young'),
];

PenGroup? penById(String id, List<PenGroup> pens) {
  try {
    return pens.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
}
