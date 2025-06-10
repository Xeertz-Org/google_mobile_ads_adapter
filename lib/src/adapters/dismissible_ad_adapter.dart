import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/base/ad_adapter.dart';

abstract class DismissibleAdAdapter<T extends Ad> extends AdAdapter<T> {
  FutureOr<void> Function()? _onAdDismissed;

  FutureOr<void> Function(T)? _onAdClicked;

  FutureOr<void> Function(T)? _onAdShowedFullScreenContent;

  FutureOr<void> Function(T)? _onAdImpression;

  FutureOr<void> Function(T, AdError)? _onAdFailedToShowFullScreenContent;

  DismissibleAdAdapter(
    super.id, {
    super.onAdInitialized,
    super.request,
    FutureOr<void> Function()? onAdDismissed,
    FutureOr<void> Function(T)? onAdClicked,
    FutureOr<void> Function(T)? onAdShowedFullScreenContent,
    FutureOr<void> Function(T)? onAdImpression,
    FutureOr<void> Function(T, AdError)? onAdFailedToShowFullScreenContent,
  })  : _onAdFailedToShowFullScreenContent = onAdFailedToShowFullScreenContent,
        _onAdImpression = onAdImpression,
        _onAdShowedFullScreenContent = onAdShowedFullScreenContent,
        _onAdClicked = onAdClicked,
        _onAdDismissed = onAdDismissed;

  @protected
  FullScreenContentCallback<T> get fullScreenContentCallback =>
      FullScreenContentCallback<T>(
        onAdClicked: _onAdClicked,
        onAdShowedFullScreenContent: _onAdShowedFullScreenContent,
        onAdImpression: _onAdImpression,
        onAdFailedToShowFullScreenContent: (ad, error) {
          _onAdFailedToShowFullScreenContent?.call(ad, error);
          ad.dispose();
        },
        onAdDismissedFullScreenContent: (ad) async {
          await _onAdDismissed?.call();
          await ad.dispose();
        },
      );

  /// Sets the callback for when an ad dismisses full screen content.
  void setOnAdDismissed(FutureOr<void> Function() onAdDismissed) =>
      _onAdDismissed = onAdDismissed;

  /// Sets the callback for when an ad is clicked.
  void setOnAdClicked(FutureOr<void> Function(T) onAdClicked) =>
      _onAdClicked = onAdClicked;

  /// Sets the callback for when an ad shows full screen content.
  void setOnAdShowedFullScreenContent(
          FutureOr<void> Function(T) onAdShowedFullScreenContent) =>
      _onAdShowedFullScreenContent = onAdShowedFullScreenContent;

  /// Sets the callback for when an impression occurs on the ad.
  void setOnAdImpression(FutureOr<void> Function(T) onAdImpression) =>
      _onAdImpression = onAdImpression;

  /// Sets the callback for when an ad fails to show full screen content.
  void setOnAdFailedToShowFullScreenContent(
          FutureOr<void> Function(T, AdError)
              onAdFailedToShowFullScreenContent) =>
      _onAdFailedToShowFullScreenContent = onAdFailedToShowFullScreenContent;
}
