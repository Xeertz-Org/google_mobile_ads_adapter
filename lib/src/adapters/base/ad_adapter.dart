import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';

abstract class AdAdapter<T extends Ad> {
  static const int defaultMaxLoadAttempts = 3;
  @protected
  late final Logger log = Logger('AdAdapter ($runtimeType)');

  final String id;
  final AdRequest request;
  @protected
  FutureOr<void> Function()? onAdInitialized;

  final int maxLoadAttempts;
  int _loadAttempts;
  Completer<T?>? _completer;

  AdAdapter(
    this.id, {
    this.maxLoadAttempts = defaultMaxLoadAttempts,
    this.request = const AdRequest(),
    this.onAdInitialized,
  }) : _loadAttempts = 0;

  @protected
  void Function(T) get onAdLoaded => (T ad) {
        log.info('$ad loaded: ${ad.responseInfo?.mediationAdapterClassName}');
        _loadAttempts = 0;
        _completer!.complete(ad);
      };

  @protected
  void Function(LoadAdError) get onAdFailedToLoad => (LoadAdError error) {
        log.warning('Failed to load ad: $error');
        _loadAttempts += 1;

        if (_loadAttempts < maxLoadAttempts) {
          return getAd();
        }

        _completer!.complete(null);
      };

  void setOnAdInitialized(FutureOr<void> Function() onAdInitialized) =>
      this.onAdInitialized = onAdInitialized;

  Future<T?> load() {
    if (_completer != null && !_completer!.isCompleted) {
      log.warning('Load operation already in progress');
      return _completer!.future;
    }

    _completer = Completer<T?>();
    getAd();
    return _completer!.future;
  }

  @protected
  void getAd();
}
