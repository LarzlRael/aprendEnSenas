part of 'utils.dart';

final winSoundsList = [
  "assets/sounds/win_sound.wav",
];

final correctsSounds = [
  "assets/sounds/correct_sound_1.mp3",
  "assets/sounds/correct_sound_2.mp3",
  "assets/sounds/correct_sound_3.mp3",
];

String getRandomWinSound(List<String> sourcesList) {
  return sourcesList[Random().nextInt(sourcesList.length)];
}
