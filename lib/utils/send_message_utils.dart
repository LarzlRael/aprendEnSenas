part of 'utils.dart';

List<Sign> generateListToMessageUtil(
  List<Sign> listOnlySingAndNumbers,
  String inputString,
) {
  Set<String> validLetters =
      Set.from(listOnlySingAndNumbers.map((sign) => sign.letter.toLowerCase()));

  return inputString.toLowerCase().codeUnits.map((codeUnit) {
    String letter = String.fromCharCode(codeUnit);

    Sign correspondingSign = validLetters.contains(letter)
        ? listOnlySingAndNumbers
            .firstWhere((sign) => sign.letter.toLowerCase() == letter)
        : Sign(letter, Icons.error, type: SignType.letter);

    return correspondingSign;
  }).toList();
}
