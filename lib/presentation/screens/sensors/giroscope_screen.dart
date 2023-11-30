import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/sensors/gyroscope_provider.dart';

class GiroscopeScreen extends ConsumerWidget {
  const GiroscopeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope$ = ref.watch(giroscopeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscopio'),
      ),
      body: Center(
        child: gyroscope$.when(
            data: (data) => Text(data.toString()), error: (error, stackTrace) => Text('$error'), loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
