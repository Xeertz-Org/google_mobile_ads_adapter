import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/dismissible_ad_adapter.dart';

/// Adapter for loading and managing rewarded ads.
class RewardedAdAdapter extends DismissibleAdAdapter<RewardedAd> {
  RewardedAdAdapter(
    super.id, {
    super.request,
    super.onAdInitialized,
    super.onAdDismissed,
    super.onAdClicked,
    super.onAdShowedFullScreenContent,
    super.onAdImpression,
    super.onAdFailedToShowFullScreenContent,
  });

  @override
  Future<void> getAd() => RewardedAd.load(
        adUnitId: id,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) async {
            await onAdInitialized?.call();
            ad.fullScreenContentCallback = fullScreenContentCallback;
            return onAdLoaded.call(ad);
          },
          onAdFailedToLoad: (error) => onAdFailedToLoad.call(error),
        ),
      );
}
