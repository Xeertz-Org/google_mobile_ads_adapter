import 'package:flutter/material.dart';
import 'package:gma_mediation_liftoffmonetize/gma_mediation_liftoffmonetize.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/google_mobile_ads_adapter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AdsController adsController = AdsController(
    mediationAdapters: [
      LiftoffmonetizeAdapter(),
    ],
  );

  Future<void> loadAd(BuildContext context) async {
    // Choose an ad to load
    InterstitialAdAdapter interstitialAdAdapter =
        InterstitialAdAdapter('AD_ID');

    // Load the ad
    InterstitialAd? ad = await adsController.load<InterstitialAd>(context,
        adapter: interstitialAdAdapter);

    // Show the ad
    ad?.show();
  }

  @override
  void initState() async {
    super.initState();

    // BE CAREFUL: This is an async method, so you should not call it in initState directly.
    // The async and await keywords are just for demonstration purposes.
    // Initialize the AdsController with the Liftoffmonetize adapter
    await adsController.init();
    await loadAd(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
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
