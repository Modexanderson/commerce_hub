import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads extends StatefulWidget {
  const Ads({Key? key}) : super(key: key);

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  final adUnitId = 'ca-app-pub-7216719904072437/1600261205';
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _initBannerAd();
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {}),
      request: AdRequest(),
    );
    _bannerAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Container(
            height: _bannerAd?.size.height.toDouble(),
            width: _bannerAd?.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          )
        : SizedBox();
  }
}
