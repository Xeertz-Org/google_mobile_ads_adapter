import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/base/ad_adapter.dart';
import 'package:google_mobile_ads_adapter/src/mediation/mediation_adapter.dart';
import 'package:logging/logging.dart';

class AdsController {
  static final _log = Logger('AdsController');

  final MobileAds _mobileAds;
  final List<MediationAdapter>? mediationAdapters;

  AdsController({
    this.mediationAdapters,
    MobileAds? mobileAds,
  }) : _mobileAds = mobileAds ?? MobileAds.instance;

  Future<void> init() async {
    _log.info('Initializing AdsController');

    for (MediationAdapter adapter in mediationAdapters ?? []) {
      await adapter.init();
    }

    await _mobileAds.initialize();
  }

  Future<T?> load<T extends Ad>(AdAdapter<T> adapter) {
    _log.info('Trying to load ad: ${adapter.id}');
    return adapter.load();
  }
}
