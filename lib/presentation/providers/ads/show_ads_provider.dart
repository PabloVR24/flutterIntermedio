import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/plugins/share_preferencias_plugin.dart';

const storeKey = 'showAds';

class ShowAdsNotifier extends StateNotifier<bool> {
  ShowAdsNotifier() : super(false) {
    checkAdsState();
  }

  void checkAdsState() async {
    state = await SharePreferenciasPlugin.getBool(storeKey) ?? true;
  }

  void removeAds() {
    SharePreferenciasPlugin.setBool(storeKey, false);
    state = false;
  }

  void showAds() {
    SharePreferenciasPlugin.setBool(storeKey, true);
    state = true;
  }

  void toggleAds() {
    state ? removeAds() : showAds();
  }
}

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});
