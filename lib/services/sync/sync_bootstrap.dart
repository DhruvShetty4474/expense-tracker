import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import 'sync_providers.dart';

/// Runs cloud sync once auth + Firebase are ready.
class SyncBootstrap extends ConsumerStatefulWidget {
  final Widget child;
  const SyncBootstrap({super.key, required this.child});

  @override
  ConsumerState<SyncBootstrap> createState() => _SyncBootstrapState();
}

class _SyncBootstrapState extends ConsumerState<SyncBootstrap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  Future<void> _sync() async {
    try {
      await ref.read(syncStatusProvider.notifier).runSync();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (prev, next) {
      if (next.valueOrNull != null && prev?.valueOrNull?.uid != next.valueOrNull?.uid) {
        _sync();
      }
    });
    return widget.child;
  }
}
