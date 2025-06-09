# google_mobile_ads_adapter

An adapter package for the [google_mobile_ads](https://pub.dev/packages/google_mobile_ads) plugin, designed to simplify ads integration and management.

## Description

`google_mobile_ads_adapter` provides a comprehensive set of utilities to manage ads using the [Google Mobile Ads SDK](https://developers.google.com/admob/flutter/quick-start) in Flutter applications.
It includes predefined ad adapters, mediation adapters, and an ads controller to easily integrate and manage ads in your Flutter projects.

## Usage

### Ads Controller

The `AdsController` class provides methods to initialize and load ads using different adapters.

```dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/google_mobile_ads_adapter.dart';

void main() {
  // Initialize the AdsController
  AdsController adsController = AdsController();
  adsController.init();

  // Choose an ad to load
  InterstitialAdAdapter interstitialAdAdapter = InterstitialAdAdapter('AD_ID');

  // Load the ad
  InterstitialAd? ad =
      await adsController.load<InterstitialAd>(interstitialAdAdapter);

  // Show the ad
  ad?.show();
}
```

#### Mediation Adapters
To use a mediation provider, implement your own adapter by extending `MediationAdapter`. For example:

```dart
import 'package:google_mobile_ads_adapter/google_mobile_ads_adapter.dart';
import 'package:gma_mediation_liftoffmonetize/gma_mediation_liftoffmonetize.dart';

class LiftoffmonetizeAdapter extends MediationAdapter {
  final GmaMediationLiftoffmonetize _mediation;

  LiftoffmonetizeAdapter({
    GmaMediationLiftoffmonetize? mediation,
  }) : _mediation = mediation ?? GmaMediationLiftoffmonetize();

  @override
  Future<void> init() async {
    await super.init();
    await _mediation.setGDPRStatus(true, '1.0.0');
    await _mediation.setCCPAStatus(true);
  }
}
```
Then provide your adapter to the `AdsController`:
```dart
void main() async {
  AdsController adsController = AdsController(
    mediationAdapters: [
      LiftoffmonetizeAdapter(),
    ],
  );
  await adsController.init();
}
```

## Issues and feedback

Please report any issue, bug or feature request in
our [issue tracker](https://github.com/Xeertz-Org/google_mobile_ads_adapter/issues)