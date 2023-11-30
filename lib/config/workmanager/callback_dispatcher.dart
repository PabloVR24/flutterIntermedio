import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey = 'com.pablovalera.miscelaneos.fetch-background-pokemon';
const fetchPeriodicTaskKey = 'com.pablovalera.miscelaneos.fetch-background-pokemon';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case fetchBackgroundTaskKey:
        print('fetchBackgroundTaskKey');
        break;
      case fetchPeriodicTaskKey:
        print('fetchPeriodicTaskKey');
        break;
      case Workmanager.iOSBackgroundTask:
        print('iosBack');
    }
    return Future.value(true);
  });
}
