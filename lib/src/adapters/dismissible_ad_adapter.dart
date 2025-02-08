import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/base/ad_adapter.dart';
import 'package:meta/meta.dart';

abstract class DismissibleAdAdapter<T extends Ad> extends AdAdapter<T> {
  FutureOr<void> Function()? _onAdDismissed;

  @protected
  FutureOr<void> Function()? get onAdDismissed => _onAdDismissed;

  void setOnAdDismissed(FutureOr<void> Function() onAdDismissed) =>
      _onAdDismissed = onAdDismissed;

  DismissibleAdAdapter(
    super.id, {
    super.onAdInitialized,
    FutureOr<void> Function()? onAdDismissed,
  }) : _onAdDismissed = onAdDismissed;
}
