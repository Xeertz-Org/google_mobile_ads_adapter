import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/google_mobile_ads_adapter.dart';

void main() async {
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
