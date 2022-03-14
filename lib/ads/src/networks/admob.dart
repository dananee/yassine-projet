import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:admosttest/ads/src/data/admob_data.dart';
import 'package:admosttest/ads/src/networks/ads.dart';
import 'package:admosttest/ads/src/utils/log.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart' as native_admob;

class AdmobAD extends Ads {
  final AdmobData _admobData;

  int _bannerIndex = 0;
  int _interIndex = 0;
  int _rewardIndex = 0;
  int _nativeIndex = 0;

  AdmobAD(this._admobData);

  final _banners = <Key, CBannerAd>{};
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  int _numInterstitialLoadAttempts = 0;
  int _numBannerLoadAttempts = 0;
  int _numRewardedLoadAttempts = 0;
  final int _maxAttempts = 5;

  // init
  @override
  Future<void> init() async {
    await native_admob.MobileAds.initialize();
    await MobileAds.instance.initialize();
  }

  // Banner
  @override
  loadBannerAd(onLoaded, Key key) {
    if (++_bannerIndex >= _admobData.bannerIds.length) {
      _bannerIndex = 0;
    }
    Log.log("Admob >> loadBannerAd > ${_admobData.bannerIds[_bannerIndex]} ");
    _banners[key] = CBannerAd(
      isReady: false,
      bannerAd: BannerAd(
        adUnitId: _admobData.bannerIds[_bannerIndex],
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(onAdLoaded: (_) {
          Log.log('Admob >> banner ad loaded $key');
          _numBannerLoadAttempts = 0;
          _banners[key]?.isReady = true;
          onLoaded!();
        }, onAdFailedToLoad: (ad, err) {
          Log.log('Admob >> Failed to load banner ad $key: ${err.message}');
          ad.dispose();
          _banners[key]?.isReady = false;
          _numBannerLoadAttempts += 1;
          if (_numBannerLoadAttempts <= _maxAttempts) {
            loadBannerAd(onLoaded, key);
          }
        }),
      ),
    );
    return _banners[key]!.bannerAd.load();
  }

  @override
  Widget getBannerAdWidget(Key key) {
    if (!_banners[key]!.isReady) return Container();
    Log.log("Admob >> banner is visible $key");
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: _banners[key]?.bannerAd.size.width.toDouble(),
        height: _banners[key]?.bannerAd.size.height.toDouble(),
        child: AdWidget(ad: _banners[key]!.bannerAd),
      ),
    );
  }

  @override
  Future<void> disposeBanner(Key key) async {
    await _banners[key]?.bannerAd.dispose();
    Log.log("Admob >> Dispose Banner $key");
    _banners[key]?.isReady = false;
  }

  // Interstitial
  @override
  Future<void> loadInterstitialAd() {
    if (++_interIndex >= _admobData.interIds.length) {
      _interIndex = 0;
    }
    Log.log(
        ">> Admob > loadInterstitialAd > ${_admobData.rewardIds[_rewardIndex]}");
    return InterstitialAd.load(
      adUnitId: _admobData.interIds[_interIndex],
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        Log.log('Admob >> $ad loaded');
        _interstitialAd = ad;
        _numInterstitialLoadAttempts = 0;
      }, onAdFailedToLoad: (err) {
        Log.log('Admob >> Failed to load interstitial ad: ${err.message}');
        _numInterstitialLoadAttempts += 1;
        _interstitialAd = null;
        if (_numInterstitialLoadAttempts <= _maxAttempts) loadInterstitialAd();
      }),
    );
  }

  @override
  void showInterstitialAd() {
    if (_interstitialAd == null) {
      Log.log("Admob >> Warning: attempt to show interstitial before loaded.");
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) =>
            Log.log('Admob >> $ad onAdShowedFullScreenContent'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          Log.log('Admob >> $ad onAdDismissedFullScreenContent');
          ad.dispose();
          loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          Log.log('Admob >> $ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          loadInterstitialAd();
        });
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  
  // Native Ad
  @override
  Widget getNativeAdWidget() {
    if (++_nativeIndex >= _admobData.nativeIds.length) {
      _nativeIndex = 0;
    }
    Log.log(
        ">> admob > getNativeAdWidget > ${_admobData.nativeIds[_nativeIndex]}");
    return native_admob.NativeAd(
      height: 300,
      buildLayout: native_admob.mediumAdTemplateLayoutBuilder,
      loading: Container(),
      error: Container(),
      unitId: _admobData.nativeIds[_nativeIndex],
    );
  }

  @override
  Future<void> loadRewardAd() {
    // TODO: implement loadRewardAd
    throw UnimplementedError();
  }

  @override
  void showRewardAd(Function rewarded) {
    // TODO: implement showRewardAd
  }
}

class CBannerAd {
  bool isReady;
  BannerAd bannerAd;

  CBannerAd({required this.isReady, required this.bannerAd});
}
