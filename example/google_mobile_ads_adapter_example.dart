import 'package:gma_mediation_liftoffmonetize/gma_mediation_liftoffmonetize.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/google_mobile_ads_adapter.dart';

Future<void> main() async {
  AdsController adsController = AdsController(
    mediationAdapters: [
      LiftoffmonetizeAdapter(),
    ],
  );

  // Initialize the AdsController with the Liftoffmonetize adapter
  await adsController.init();

  // Choose an ad to load
  InterstitialAdAdapter interstitialAdAdapter = InterstitialAdAdapter('AD_ID');

  // Load the ad
  InterstitialAd? ad =
      await adsController.load<InterstitialAd>(interstitialAdAdapter);

  // Show the ad
  ad?.show();
}

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
