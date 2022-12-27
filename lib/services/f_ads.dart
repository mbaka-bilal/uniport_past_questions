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
        adUnitId: 'ca-app-pub-3197842556924641/3568041502',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: ((ad) {
          emit(ad);
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: ((ad) {
            ad.dispose();
            emit(null);
          }));
        }), onAdFailedToLoad: ((adErr) {
          print ("failed to load interstitial ad $adErr");
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
            adUnitId: "ca-app-pub-3197842556924641/8820368180",
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
