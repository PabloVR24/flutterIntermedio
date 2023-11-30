import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/sensors/magnetometter_provider.dart';

class MagnetometterScreen extends ConsumerWidget {
  const MagnetometterScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final magnetometter$ = ref.watch(magnetometterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnetometro'),
      ),
      body: Center(
        child: magnetometter$.when(
            data: (data) => Text(data.toString()), error: (error, stackTrace) => Text('$error'), loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
