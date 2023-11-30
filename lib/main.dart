import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/plugins/admob_plugin.dart';
import 'package:miscelaneos/config/plugins/quick_actions_plugin.dart';
import 'package:miscelaneos/config/router/app_router.dart';
import 'package:miscelaneos/config/theme/app_theme.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:workmanager/workmanager.dart';

import 'config/workmanager/callback_dispatcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  QuickActionsPlugin.registerActions();
  await AdMobPlugin.initialize();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  // Workmanager().registerOneOffTask("com.pablovalera.miscelaneos.simpleTask", "com.pablovalera.miscelaneos.simpleTask",
  //     inputData: {'hola': 'mundo'},
  //     constraints: Constraints(
  //         networkType: NetworkType.connected,
  //         // requiresBatteryNotLow: true,
  //         // requiresCharging: true,
  //         // requiresDeviceIdle: true,
  //         // requiresStorageNotLow: true
  //         ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(appStateProvider.notifier).state = state;
    if (state == AppLifecycleState.resumed) {
      ref.read(permissionsProvider.notifier).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
