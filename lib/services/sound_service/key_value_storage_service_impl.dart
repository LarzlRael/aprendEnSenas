part of '../services.dart';

class SoundServiceImpl implements SoundService {
  @override
  void playSound(String assetPath) {
    AssetsAudioPlayer assetsAudioPlayer = new AssetsAudioPlayer();
    assetsAudioPlayer.open(
      Audio(assetPath),
    );
    assetsAudioPlayer.play();
  }
}
