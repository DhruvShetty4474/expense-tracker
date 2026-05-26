import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/app_database.dart';

/// Root-level providers injected via ProviderScope overrides in main.dart.

final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('Override databaseProvider in ProviderScope'),
);
