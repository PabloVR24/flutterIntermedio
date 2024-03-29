import 'dart:async';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

final adBannerID = Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716';
final adInterstitialID = Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/4411468910';
final adRewardedId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-3940256099942544/1712485313';

class AdMobPlugin {
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  static Future<BannerAd> loadBannerAd() async {
    return BannerAd(
      adUnitId: adBannerID,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          print('$ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  static Future<InterstitialAd> loadInterstitialAd() async {
    Completer<InterstitialAd> completer = Completer();

    InterstitialAd.load(
        adUnitId: adInterstitialID,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            completer.complete(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
            completer.completeError(error);
          },
        ));

    return completer.future;
  }

  static Future<RewardedAd> loadRewardedAd() async {
    Completer<RewardedAd> completer = Completer();
    RewardedAd.load(
        adUnitId: adRewardedId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            print('$ad loaded.');
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
            // Keep a reference to the ad so you can show it later.
            completer.complete(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            completer.completeError(error);
          },
        ));

    return completer.future;
  }
}
