/// Passed as GoRouter `extra` when navigating to AddAnimalPage to add a
/// newborn that is automatically linked to a specific dam (mother).
class NewbornExtra {
  final String damId;
  final String damDisplay;   // human-readable identity string for the dam
  final String damSpecies;   // LivestockSpecies.name — pre-selects species

  const NewbornExtra({
    required this.damId,
    required this.damDisplay,
    required this.damSpecies,
  });
}
