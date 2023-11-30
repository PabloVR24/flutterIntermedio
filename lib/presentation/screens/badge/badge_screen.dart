import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/plugins/app_badge_plugin.dart';
import 'package:miscelaneos/presentation/providers/bage/badge_counter_provider.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final badgeCounter = ref.watch(badgeCounterProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              label: Text('$badgeCounter'),
              alignment: Alignment.lerp(Alignment.topRight, Alignment.bottomRight, 0.2),
              child: Text(
                '$badgeCounter',
                style: const TextStyle(fontSize: 150),
              ),
            ),
            FilledButton(
                onPressed: () {
                  ref.invalidate(badgeCounterProvider);
                },
                child: const Text('Borrar Badge'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(badgeCounterProvider.notifier).update((state) => state + 1);
          AppBadgePlugin.updateBadgeCount(badgeCounter + 1);
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
