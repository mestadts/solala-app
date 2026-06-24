import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

/// Singleton Isar instance.
/// Overridden in [main] after [openIsar()] completes.
final isarProvider = Provider<Isar>(
  (ref) => throw UnimplementedError('Isar not yet initialised'),
);
