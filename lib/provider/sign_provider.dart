import 'package:asl/data/sign_list.dart';
import 'package:asl/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_provider.g.dart';

@riverpod
class SignProvider extends _$SignProvider {
  @override
  List<Sign> build() {
    return [];
  }

  void generateListToMessage(String inputString) {
    state = [];
    Set<String> validLetters = Set.from(
        listOnlySingAndNumbers.map((sign) => sign.letter.toLowerCase()));

    state = inputString.toLowerCase().codeUnits.map((codeUnit) {
      String letter = String.fromCharCode(codeUnit);

      Sign correspondingSign = validLetters.contains(letter)
          ? listOnlySingAndNumbers
              .firstWhere((sign) => sign.letter.toLowerCase() == letter)
          : Sign(letter, 'assets/signs/0_number.svg');

      return correspondingSign;
    }).toList();
  }
}

@riverpod
class CurrentMessage extends _$CurrentMessage {
  @override
  String build() {
    return '';
  }

  setCurrentMessage(String message) {
    state = message;
  }
}
