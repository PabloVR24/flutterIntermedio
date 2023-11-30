import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscelaneos/config/plugins/admob_plugin.dart';
import 'package:miscelaneos/presentation/providers/ads/show_ads_provider.dart';

final adBannerProvider = FutureProvider<BannerAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw '';
  final ad = await AdMobPlugin.loadBannerAd();
  return ad;
});

final adInterstitialProvider = FutureProvider.autoDispose<InterstitialAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw '';

  final ad = await AdMobPlugin.loadInterstitialAd();
  return ad;
});
final adRewardedProvider = FutureProvider.autoDispose<RewardedAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);
  if (!showAds) throw '';

  final ad = await AdMobPlugin.loadRewardedAd();
  return ad;
});
