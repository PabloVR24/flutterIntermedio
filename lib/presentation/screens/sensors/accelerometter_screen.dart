import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/sensors/acelerometter_providers.dart';

class AccelerometterScreen extends ConsumerWidget {
  const AccelerometterScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final accelerometter$ = ref.watch(accelerometterGravityProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acelerometro'),
      ),
      body: Center(
        child: accelerometter$.when(
            data: (data) => Text(data.toString()), error: (error, stackTrace) => Text('$error'), loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
