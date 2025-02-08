import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeSmallAdWidget extends StatelessWidget {
  static const double minWidth = 320;
  static const double minHeight = 90;

  final NativeAd ad;
  final double? maxWidth;
  final double? maxHeight;

  NativeSmallAdWidget({
    super.key,
    required this.ad,
    this.maxWidth,
    this.maxHeight,
  }) {
    if (maxWidth != null && maxWidth! < minWidth) {
      throw ArgumentError(
          'maxWidth must be greater than or equal to $minWidth');
    }
    if (maxHeight != null && maxHeight! < minHeight) {
      throw ArgumentError(
          'maxHeight must be greater than or equal to $minHeight');
    }
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          minHeight: minHeight,
          maxWidth: maxWidth ?? 400,
          maxHeight: maxHeight ?? 100,
        ),
        child: AdWidget(ad: ad),
      );
}
