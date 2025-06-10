import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/base/ad_adapter.dart';
import 'package:google_mobile_ads_adapter/src/mediation/mediation_adapter.dart';
import 'package:logging/logging.dart';

/// Controller for managing ads in the application.
/// This class handles the initialization of mediation adapters and loading ads of various types.
class AdsController {
  static final _log = Logger('AdsController');

  final MobileAds _mobileAds;
  final List<MediationAdapter>? mediationAdapters;

  AdsController({
    this.mediationAdapters,
    MobileAds? mobileAds,
  }) : _mobileAds = mobileAds ?? MobileAds.instance;

  /// Initializes the AdsController by initializing all mediation adapters and the MobileAds SDK.
  Future<void> init() async {
    _log.info('Initializing AdsController');

    for (MediationAdapter adapter in mediationAdapters ?? []) {
      await adapter.init();
    }

    await _mobileAds.initialize();
  }

  /// Loads an ad using the provided [AdAdapter].
  Future<T?> load<T extends Ad>(AdAdapter<T> adapter) {
    _log.info('Trying to load ad: ${adapter.id}');
    return adapter.load();
  }

  /// Requests user consent for personalized ads. (Google UMP)
  /// This method checks if the consent form is available and shows it to the user.
  void showConsentUMP() => ConsentInformation.instance.requestConsentInfoUpdate(
        ConsentRequestParameters(),
        () async {
          if (await ConsentInformation.instance.isConsentFormAvailable()) {
            _loadForm();
          }
        },
        (FormError error) {
          _log.warning('Failed to request consent info update: $error');
        },
      );

  void _loadForm() => ConsentForm.loadConsentForm(
        (ConsentForm consentForm) async {
          var status = await ConsentInformation.instance.getConsentStatus();
          if (status == ConsentStatus.required) {
            consentForm.show(
              (FormError? formError) {
                _loadForm();
              },
            );
          }
        },
        (formError) {
          _log.warning('Failed to load consent form: $formError');
        },
      );
}
