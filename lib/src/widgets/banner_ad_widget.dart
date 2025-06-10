import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final BannerAd ad;

  BannerAdWidget({
    super.key,
    required this.ad,
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  @override
  void dispose() {
    widget.ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: widget.ad.size.width.toDouble(),
        height: widget.ad.size.height.toDouble(),
        child: AdWidget(ad: widget.ad),
      );
}
