import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/base/ad_adapter.dart';

/// Adapter for loading and managing banner ads.
///
/// The [BuildContext] must be set (via constructor or [setBuildContext])
/// before loading the ad, as it is required to determine the device size.
class BannerAdAdapter extends AdAdapter<BannerAd> {
  BuildContext? context;

  void Function(Ad)? _onAdOpened;

  void Function(Ad)? _onAdClicked;

  void Function(Ad)? _onAdClosed;

  void Function(Ad)? _onAdImpression;

  void Function(Ad)? _onAdWillDismissScreen;

  BannerAdAdapter(
    super.id, {
    super.onAdInitialized,
    super.request,
    this.context,
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

  /// Sets the [BuildContext] for the ad. Necessary to determine the device size.
  void setBuildContext(BuildContext context) => this.context = context;

  /// Sets the callback for when the ad opens an overlay covering the screen.
  void setOnAdOpened(void Function(Ad)? onAdOpened) => _onAdOpened = onAdOpened;

  /// /// Sets the callback for when the ad removes an overlay covering the screen.
  void setOnAdClicked(void Function(Ad)? onAdClicked) =>
      _onAdClicked = onAdClicked;

  /// Sets the callback for when the full screen view has been closed.
  /// You should restart anything paused while handling onAdOpened.
  void setOnAdClosed(void Function(Ad)? onAdClosed) => _onAdClosed = onAdClosed;

  /// Sets the callback for when an impression occurs on the ad.
  void setOnAdImpression(void Function(Ad)? onAdImpression) =>
      _onAdImpression = onAdImpression;

  /// For iOS only. Sets the callback called before dismissing a full screen view.
  void setOnAdWillDismissScreen(void Function(Ad)? onAdWillDismissScreen) =>
      _onAdWillDismissScreen = onAdWillDismissScreen;

  @override
  Future<void> getAd() async {
    if (context == null) {
      throw Exception(
          'BuildContext is not set. Please set it before loading the ad.');
    }

    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context!).width.truncate());

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
          onAdFailedToLoad.call(error);
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
