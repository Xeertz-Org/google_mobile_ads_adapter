import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

abstract class AdAdapter<T extends Ad> {
  static const int maxFailedLoadAttempts = 3;
  @protected
  late final Logger log = Logger('AdAdapter ($runtimeType)');

  final String id;
  FutureOr<void> Function()? _onAdInitialized;

  int loadAttempts;
  Completer<T?>? _completer;

  AdAdapter(
    this.id, {
    FutureOr<void> Function()? onAdInitialized,
    FutureOr<void> Function()? onAdDismissed,
  })  : loadAttempts = 0,
        _onAdInitialized = onAdInitialized;

  @protected
  FutureOr<void> Function()? get onAdInitialized => _onAdInitialized;

  void Function(T) get onAdLoaded => (T ad) {
        log.info('$ad loaded: ${ad.responseInfo?.mediationAdapterClassName}');
        loadAttempts = 0;
        _completer!.complete(ad);
      };

  void Function(LoadAdError) get onAdFailedToLoad => (LoadAdError error) {
        log.warning('Failed to load ad: $error');
        loadAttempts += 1;

        if (loadAttempts < maxFailedLoadAttempts) {
          return getAd();
        }

        _completer!.complete(null);
      };

  void setOnAdInitialized(FutureOr<void> Function() onAdInitialized) =>
      _onAdInitialized = onAdInitialized;

  Future<T?> load() {
    _completer = Completer<T?>();
    getAd();
    return _completer!.future;
  }

  @protected
  void getAd();
}
