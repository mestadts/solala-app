import 'package:flutter/material.dart';
import '../../../../../core/constants/livestock_species.dart';
import '../../../../../shared/widgets/herd_text_field.dart';

/// Returns a list of labeled form fields specific to the given species.
/// [controllers] is a map from field key → TextEditingController.
/// Keys are set per-species and exposed so the caller can read values.
class SpeciesFormFields extends StatelessWidget {
  final LivestockSpecies species;
  final Map<String, TextEditingController> controllers;

  const SpeciesFormFields({
    super.key,
    required this.species,
    required this.controllers,
  });

  static Map<String, String> labelsFor(LivestockSpecies s) {
    switch (s) {
      case LivestockSpecies.sheep:
        return {
          'woolType': 'Wool Type',
          'purpose': 'Purpose',
          'hornStatus': 'Horn Status',
        };
      case LivestockSpecies.goat:
        return {
          'purpose': 'Purpose',
          'hornStatus': 'Horn Status',
          'colorPattern': 'Color / Pattern',
        };
      case LivestockSpecies.camel:
        return {
          'humpType': 'Hump Type',
          'classification': 'Classification',
          'pedigreeLevel': 'Pedigree Level',
          'microchipId': 'Microchip ID',
        };
      case LivestockSpecies.cow:
        return {
          'purpose': 'Purpose',
          'milkYield': 'Milk Yield (liters/day)',
          'lactationCycle': 'Lactation Cycle #',
        };
      case LivestockSpecies.horse:
        return {
          'purpose': 'Purpose',
          'height': 'Height (hands / cm)',
          'registrationNumber': 'Registration Number',
          'markings': 'Markings',
        };
    }
  }

  static List<String> hintsFor(LivestockSpecies s) {
    switch (s) {
      case LivestockSpecies.sheep:
        return ['e.g. Fine, Coarse', 'e.g. Breeding, Meat', 'e.g. Polled, Horned'];
      case LivestockSpecies.goat:
        return ['e.g. Milk, Meat', 'e.g. Polled, Horned', 'e.g. Solid Black, Spotted'];
      case LivestockSpecies.camel:
        return ['e.g. Single, Double', 'e.g. Racing, Pack', 'e.g. Level 1', 'e.g. MC-2024XXXX'];
      case LivestockSpecies.cow:
        return ['e.g. Dairy, Meat', 'e.g. 28', 'e.g. 3'];
      case LivestockSpecies.horse:
        return ['e.g. Racing, Breeding', 'e.g. 15.2', 'e.g. AR-2020-4891', 'e.g. White blaze'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final labels = labelsFor(species);
    final hints  = hintsFor(species);
    final keys   = labels.keys.toList();

    return Column(
      children: List.generate(keys.length, (i) {
        final key   = keys[i];
        final label = labels[key]!;
        final hint  = i < hints.length ? hints[i] : '';
        controllers.putIfAbsent(key, TextEditingController.new);
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: HerdTextField(
            label: label,
            hint: hint,
            controller: controllers[key]!,
            textInputAction: i < keys.length - 1
                ? TextInputAction.next
                : TextInputAction.done,
          ),
        );
      }),
    );
  }
}
