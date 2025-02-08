import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/dismissible_ad_adapter.dart';

class InterstitialAdAdapter
    extends DismissibleAdAdapter<InterstitialAd> {
  InterstitialAdAdapter(super.id);

  @override
  Future<void> getAd() => InterstitialAd.load(
        adUnitId: id,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) async {
            await onAdInitialized?.call();

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdClicked: (ad) {},
              onAdShowedFullScreenContent: (ad) {},
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) => ad.dispose(),
              onAdDismissedFullScreenContent: (ad) async {
                await onAdDismissed?.call();
                await ad.dispose();
              },
            );

            return onAdLoaded.call(ad);
          },
          onAdFailedToLoad: onAdFailedToLoad,
        ),
      );
}
