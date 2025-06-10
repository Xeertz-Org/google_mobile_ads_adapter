import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/base/ad_adapter.dart';

class BannerAdAdapter extends AdAdapter<BannerAd> {
  void Function(Ad)? _onAdOpened;

  void Function(Ad)? _onAdClicked;

  void Function(Ad)? _onAdClosed;

  void Function(Ad)? _onAdImpression;

  void Function(Ad)? _onAdWillDismissScreen;

  BannerAdAdapter(
    super.id, {
    super.onAdInitialized,
    super.request,
    void Function(Ad)? onAdOpened,
    void Function(Ad)? onAdClicked,
    void Function(Ad)? onAdClosed,
    void Function(Ad)? onAdImpression,
    void Function(Ad)? onAdWillDismissScreen,
  })  : _onAdOpened = onAdOpened,
        _onAdClicked = onAdClicked,
        _onAdClosed = onAdClosed,
        _onAdImpression = onAdImpression,
        _onAdWillDismissScreen = onAdWillDismissScreen;

  void setOnAdOpened(void Function(Ad)? onAdOpened) => _onAdOpened = onAdOpened;

  void setOnAdClicked(void Function(Ad)? onAdClicked) =>
      _onAdClicked = onAdClicked;

  void setOnAdClosed(void Function(Ad)? onAdClosed) => _onAdClosed = onAdClosed;

  void setOnAdImpression(void Function(Ad)? onAdImpression) =>
      _onAdImpression = onAdImpression;

  void setOnAdWillDismissScreen(void Function(Ad)? onAdWillDismissScreen) =>
      _onAdWillDismissScreen = onAdWillDismissScreen;

  @override
  Future<void> getAd(BuildContext context) async {
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context).width.truncate());

    return BannerAd(
      adUnitId: id,
      request: request,
      size: size!,
      listener: BannerAdListener(
        onAdLoaded: (ad) async {
          await onAdInitialized?.call();
          return onAdLoaded.call(ad as BannerAd);
        },
        onAdFailedToLoad: (ad, error) {
          onAdFailedToLoad.call(context, error);
          ad.dispose();
        },
        onAdOpened: _onAdOpened,
        onAdClosed: _onAdClosed,
        onAdImpression: _onAdImpression,
        onAdClicked: _onAdClicked,
        onAdWillDismissScreen: _onAdWillDismissScreen,
      ),
    ).load();
  }
}
