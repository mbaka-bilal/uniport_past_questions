import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitalAdCubit extends Cubit<InterstitialAd?> {
  Future<void> init() async {
    await MobileAds.instance.initialize();
  }

  InterstitalAdCubit() : super(null) {
    init();
  }

  Future<void> loadInterstitialAd() async {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: ((ad) {
          emit(ad);
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: ((ad) {
            ad.dispose();
            emit(null);
          }));
        }), onAdFailedToLoad: ((ad) {
          emit(null);
        })));
  }
}

class GoogleAdDisplay extends Cubit<BannerAd?> {
  BannerAd? _bannerAd;

  Future<void> init() async {
    await MobileAds.instance.initialize();
  }

  GoogleAdDisplay() : super(null) {
    init();
  }

  Future<void> initializeBannerAd() async {
    await BannerAd(
            size: AdSize.banner,
            adUnitId: "ca-app-pub-3940256099942544/6300978111",
            listener: BannerAdListener(onAdLoaded: (ad) {
              print("successfully loaded ad");
              _bannerAd = ad as BannerAd?;
              emit(_bannerAd);
            }, onAdFailedToLoad: ((ad, error) {
              print("could not load ad $error");
              _bannerAd = null;
              emit(null);
            })),
            request: const AdRequest())
        .load();
  }

  // BannerAd? fetchBannerAd() {
  //   return _bannerAd;
  // }

  void disposeAd() {
    _bannerAd!.dispose();
    emit(null);
  }

  @override
  Future<void> close() {
    disposeAd();
    return super.close();
  }
}
