import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/ads/admob_points_provider.dart';
import 'package:miscelaneos/presentation/providers/ads/admob_providers.dart';

class AdRewarded extends ConsumerWidget {
  const AdRewarded({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adRewardedAsync = ref.watch(adRewardedProvider);
    final adPointsAsync = ref.watch(adPointsProvider);

    ref.listen(adRewardedProvider, (previous, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;

      next.value!.show(onUserEarnedReward: (ad, reward) {
        print('$reward');
        ref.read(adPointsProvider.notifier).update((state) => state + 10);
      });
    });

    if (adRewardedAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: Text('Cargando Anuncio'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Full Screen'),
      ),
      body: Center(
        child: Text('Puntos actuales: $adPointsAsync'),
      ),
    );
  }
}
