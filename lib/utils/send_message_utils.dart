part of 'utils.dart';

List<Sign> generateListToMessage(
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
        : Sign(letter, 'assets/signs/0_number.svg');

    return correspondingSign;
  }).toList();
}
