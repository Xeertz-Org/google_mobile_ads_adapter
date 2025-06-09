import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/dismissible_ad_adapter.dart';

class RewardedInterstitialAdAdapter
    extends DismissibleAdAdapter<RewardedInterstitialAd> {
  RewardedInterstitialAdAdapter(
    super.id, {
    super.request,
  });

  @override
  Future<void> getAd() => RewardedInterstitialAd.load(
        adUnitId: id,
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (ad) async {
            await onAdInitialized?.call();
            ad.fullScreenContentCallback = fullScreenContentCallback;
            return onAdLoaded.call(ad);
          },
          onAdFailedToLoad: onAdFailedToLoad,
        ),
      );
}
