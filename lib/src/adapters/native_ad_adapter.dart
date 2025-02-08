
import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads_adapter/src/adapters/base/ad_adapter.dart';

class NativeAdAdapter extends AdAdapter<NativeAd> {
  final TemplateType templateType;
  final Color? mainBackgroundColor;
  final Color? callToActionBackgroundColor;
  final Color? callToActionTextColor;
  final Color? textColor;

  NativeAdAdapter(
    super.id, {
    this.templateType = TemplateType.small,
    this.mainBackgroundColor,
    this.callToActionBackgroundColor,
    this.callToActionTextColor,
    this.textColor,
  });

  @override
  Future<void> getAd() => NativeAd(
        adUnitId: id,
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (ad) async {
            await onAdInitialized?.call();
            return onAdLoaded.call(ad as NativeAd);
          },
          onAdFailedToLoad: (ad, error) {
            onAdFailedToLoad.call(error);
            ad.dispose();
          },
        ),
        nativeTemplateStyle: NativeTemplateStyle(
          templateType: templateType,
          mainBackgroundColor: mainBackgroundColor,
          cornerRadius: 10.0,
          callToActionTextStyle: NativeTemplateTextStyle(
            textColor: callToActionTextColor,
            backgroundColor: callToActionBackgroundColor,
            style: NativeTemplateFontStyle.monospace,
            size: 16.0,
          ),
          primaryTextStyle: NativeTemplateTextStyle(
            textColor: textColor,
            backgroundColor: mainBackgroundColor,
            style: NativeTemplateFontStyle.italic,
            size: 16.0,
          ),
          secondaryTextStyle: NativeTemplateTextStyle(
            textColor: textColor,
            backgroundColor: mainBackgroundColor,
            style: NativeTemplateFontStyle.bold,
            size: 16.0,
          ),
          tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: textColor,
            backgroundColor: mainBackgroundColor,
            style: NativeTemplateFontStyle.normal,
            size: 16.0,
          ),
        ),
      ).load();

  NativeAdAdapter copyWith({
    String? id,
    TemplateType? templateType,
    Color? mainBackgroundColor,
    Color? callToActionBackgroundColor,
    Color? callToActionTextColor,
    Color? textColor,
  }) =>
      NativeAdAdapter(
        id ?? this.id,
        templateType: templateType ?? this.templateType,
        mainBackgroundColor: mainBackgroundColor ?? this.mainBackgroundColor,
        callToActionBackgroundColor:
            callToActionBackgroundColor ?? this.callToActionBackgroundColor,
        callToActionTextColor:
            callToActionTextColor ?? this.callToActionTextColor,
        textColor: textColor ?? this.textColor,
      );
}
