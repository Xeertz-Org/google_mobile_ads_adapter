import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/dismissible_ad_adapter.dart';

class InterstitialAdAdapter extends DismissibleAdAdapter<InterstitialAd> {
  InterstitialAdAdapter(
    super.id, {
    super.request,
  });

  @override
  Future<void> getAd() => InterstitialAd.load(
        adUnitId: id,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) async {
            await onAdInitialized?.call();
            ad.fullScreenContentCallback = fullScreenContentCallback;
            return onAdLoaded.call(ad);
          },
          onAdFailedToLoad: onAdFailedToLoad,
        ),
      );
}
