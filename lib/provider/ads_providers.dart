import 'package:asl/plugin/admob_plugin.dart';
import 'package:asl/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const COUNTER_ADD = 'COUNTER_ADD';

final adBannerProvider = FutureProvider<BannerAd>((ref) async {
  /* Todo validar si se muestran o no las ads */
  final ad = await AdmobPlugin.loadBannerAd();
  return ad;
});

/* final adIntersitialProvider =
    FutureProvider.autoDispose<InterstitialAd>((ref) async {
  /* Todo validar si se muestran o no las adas */

  final ad = await AdmobPlugin.loadIntersitialAd();
  final keyValueStorageServiceImpl = KeyValueStorageServiceImpl();
  final counterAdd = await keyValueStorageServiceImpl.getValue<int>('counter');

  return ad;
}); */

class InterstitialAdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;

  static void loadAd() {
    if (!_isAdLoaded) {
      InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {},
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                _isAdLoaded =
                    false; // Marcar el anuncio como no cargado al cerrarlo
              },
              onAdClicked: (ad) {},
            );

            _interstitialAd = ad;
            _isAdLoaded = true; // Marcar el anuncio como cargado correctamente
            /* debugPrint('$ad loaded.'); */
          },
          onAdFailedToLoad: (LoadAdError error) {
            /* debugPrint('InterstitialAd failed to load: $error'); */
            _isAdLoaded =
                false; // Marcar el anuncio como no cargado si falla la carga
          },
        ),
      );
    }
  }

  static void showAd() {
    if (_interstitialAd != null && _isAdLoaded) {
      _interstitialAd!.show();
    } else {
      // Si el anuncio no está cargado, vuelve a cargarlo y muestra después de la carga
      loadAd();
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          _interstitialAd?.dispose();
          _interstitialAd = null;
        },
      );
    }
  }

  static void disposeAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isAdLoaded = false;
  }
}

void addCounterIntersitialAd(Function callBack) async {
  const MAXCOUNT = 4;
  final keyValueStorageServiceImpl = KeyValueStorageServiceImpl();
  final getCurrentCounterAdd =
      await keyValueStorageServiceImpl.getValue<int>(COUNTER_ADD) ?? 0;

  await keyValueStorageServiceImpl.setKeyValue<int>(
      COUNTER_ADD, getCurrentCounterAdd + 1);

  if (getCurrentCounterAdd == MAXCOUNT) {
    callBack();
    await keyValueStorageServiceImpl.setKeyValue<int>(COUNTER_ADD, 0);
  }
}

final couterAdProvider = FutureProvider<int>((ref) async {
  final keyValueStorageServiceImpl = KeyValueStorageServiceImpl();
  final getCurrentCounterAdd =
      await keyValueStorageServiceImpl.getValue<int>(COUNTER_ADD);
  return getCurrentCounterAdd ?? 0;
});
