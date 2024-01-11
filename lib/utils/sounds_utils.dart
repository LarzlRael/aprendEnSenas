part of 'utils.dart';

final winSoundsList = [
  "assets/sounds/win_sound_1.mp3",
];
final loseSoundsList = [
  "assets/sounds/lose_sound_1.mp3",
  "assets/sounds/lose_sound_2.mp3",
];

final correctsSounds = [
  "assets/sounds/correct_sound_1.mp3",
  "assets/sounds/correct_sound_2.mp3",
  "assets/sounds/correct_sound_3.mp3",
];

String getRandomSound(List<String> sourcesList) {
  return sourcesList[Random().nextInt(sourcesList.length)];
}
