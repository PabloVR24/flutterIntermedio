import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/plugins/share_preferencias_plugin.dart';
import 'package:workmanager/workmanager.dart';

import '../../../config/workmanager/callback_dispatcher.dart';

class BackgroundFetchNotifier extends StateNotifier<bool> {
  final String processKeyName;
  BackgroundFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  toggleProcess() {
    if (state == true) {
      deactivateProcess();
    } else {
      activateTask();
    }
  }

  checkCurrentStatus() async {
    state = await SharePreferenciasPlugin.getBool(processKeyName) ?? false;
  }

  activateTask() async {
    await Workmanager().registerPeriodicTask(processKeyName, processKeyName,
        frequency: const Duration(seconds: 10), constraints: Constraints(networkType: NetworkType.connected), tag: processKeyName);
    await SharePreferenciasPlugin.setBool(processKeyName, true);
    state = true;
  }

  deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    await SharePreferenciasPlugin.setBool(processKeyName, false);
    state = false;
  }
}

final backgroundFetchProvider = StateNotifierProvider<BackgroundFetchNotifier, bool>((ref) {
  return BackgroundFetchNotifier(processKeyName: fetchPeriodicTaskKey);
});
