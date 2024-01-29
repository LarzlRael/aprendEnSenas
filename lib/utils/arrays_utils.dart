part of 'utils.dart';

String getValueSoundFromList(List<String> sourcesList) {
  int randomIndex = Random().nextInt(sourcesList.length);
  // Devolver el elemento correspondiente al índice aleatorio
  return sourcesList[randomIndex];
}
