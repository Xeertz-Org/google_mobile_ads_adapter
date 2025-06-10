import 'package:flutter/material.dart';
import 'package:google_mobile_ads_adapter/src/ads_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/base/ad_adapter.dart';
import 'package:google_mobile_ads_adapter/src/mediation/mediation_adapter.dart';
import 'package:test/test.dart';

class MockMediationAdapter extends Mock implements MediationAdapter {}

class MockAdAdapter extends Mock implements AdAdapter {}

class MockMobileAds extends Mock implements MobileAds {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  final MockMediationAdapter mockMediationAdapter = MockMediationAdapter();
  final MockAdAdapter mockAdAdapter = MockAdAdapter();
  final MockMobileAds mockMobileAds = MockMobileAds();
  final BuildContext mockContext = FakeBuildContext();

  final AdsController adsController = AdsController(
    mediationAdapters: [mockMediationAdapter],
    mobileAds: mockMobileAds,
  );

  setUpAll(() {
    registerFallbackValue(MockMediationAdapter());
    registerFallbackValue(MockAdAdapter());
  });

  test('should initialize all mediation adapters and MobileAds', () async {
    when(() => mockMediationAdapter.init()).thenAnswer((_) async {});
    when(() => mockMobileAds.initialize())
        .thenAnswer((_) async => InitializationStatus({}));

    await adsController.init();

    verify(() => mockMediationAdapter.init()).called(1);
    verify(() => mockMobileAds.initialize()).called(1);
  });

  test('should load an ad using the provided AdAdapter', () async {
    when(() => mockAdAdapter.id).thenReturn('AD_ID');
    when(() => mockAdAdapter.load(mockContext))
        .thenAnswer((_) async => Future.value(null));

    await adsController.load(mockContext, adapter: mockAdAdapter);

    verify(() => mockAdAdapter.id).called(1);
    verify(() => mockAdAdapter.load(mockContext)).called(1);
  });
}
