import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/local_auth/local_providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BiometricScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                onPressed: () {
                  ref.read(localAuthProvider.notifier).autenticateUser();
                },
                child: const Text('Autenticar')),
            const SizedBox(height: 40),
            canCheckBiometrics.when(
                data: (canCheck) => Text('Puede revisar biometrics: $canCheck'),
                error: (error, stackTrace) => Text('Error: $error'),
                loading: () => const SizedBox()),
            const Text('Estado del biometrico', style: TextStyle(fontSize: 20)),
            Text('Estado: $localAuthState', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
