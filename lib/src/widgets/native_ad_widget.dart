import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatefulWidget {
  static const double minWidth = 320;
  static const double minHeight = 320;

  final NativeAd ad;
  final double? maxWidth;
  final double? maxHeight;

  NativeAdWidget({
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
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  @override
  void dispose() {
    widget.ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: NativeAdWidget.minWidth,
          minHeight: NativeAdWidget.minHeight,
          maxWidth: widget.maxWidth ?? 400,
          maxHeight: widget.maxHeight ?? 350,
        ),
        child: AdWidget(ad: widget.ad),
      );
}
