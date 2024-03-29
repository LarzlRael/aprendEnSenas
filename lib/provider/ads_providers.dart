// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asl/constants/enviroments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:asl/plugin/admob_plugin.dart';
import 'package:asl/services/services.dart';

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

/* class InterstitialAdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;

  static void loadAd() {
    if (!_isAdLoaded) {
      InterstitialAd.load(
        adUnitId: Enviroment.adIntersitialId,
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
} */

void addCounterIntersitialAd(Function callBack) async {
  const MAXCOUNT = 5;
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

final interstiatAdProvider =
    StateNotifierProvider<IntersitialAdNotifier, InterstialState>((ref) {
  return IntersitialAdNotifier();
});

class IntersitialAdNotifier extends StateNotifier<InterstialState> {
  IntersitialAdNotifier()
      : super(InterstialState(isAdLoaded: false, interstitialAd: null));

  void loadAd() {
    if (!state.isAdLoaded) {
      InterstitialAd.load(
        adUnitId: Enviroment.adIntersitialId,
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
                state = state.copyWith(isAdLoaded: false);
              },
              onAdClicked: (ad) {},
            );

            state = state.copyWith(interstitialAd: ad, isAdLoaded: true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            state = state.copyWith(isAdLoaded: false);
          },
        ),
      );
    }
  }

  void showAd() {
    if (state.interstitialAd != null && state.isAdLoaded) {
      state.interstitialAd!.show();
    } else {
      loadAd();
      state.interstitialAd?.fullScreenContentCallback =
          FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          state.interstitialAd?.dispose();
          state = state.copyWith(interstitialAd: null);
        },
      );
    }
  }

  void disposeAd() {
    state.interstitialAd?.dispose();
    state = state.copyWith(interstitialAd: null, isAdLoaded: false);
  }
}

class InterstialState {
  final InterstitialAd? interstitialAd;
  final bool isAdLoaded;
  InterstialState({
    required this.interstitialAd,
    required this.isAdLoaded,
  });

  InterstialState copyWith({
    InterstitialAd? interstitialAd,
    bool? isAdLoaded,
  }) =>
      InterstialState(
        interstitialAd: interstitialAd ?? this.interstitialAd,
        isAdLoaded: isAdLoaded ?? this.isAdLoaded,
      );
}
