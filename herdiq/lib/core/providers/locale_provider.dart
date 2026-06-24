import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Arabic is the default locale (primary language).
final localeProvider = StateProvider<Locale>((ref) => const Locale('ar'));
