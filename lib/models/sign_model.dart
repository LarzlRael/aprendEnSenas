part of 'models.dart';

enum SignType {
  letter,
  number,
  space,
}

String signType(BuildContext context, SignType sign) {
  final Map<SignType, String> levelNames = {
    SignType.letter: AppLocalizations.of(context)!.letter,
    SignType.number: AppLocalizations.of(context)!.number,
    SignType.space: "",
  };

  return levelNames[sign] ?? '';
}

class Sign {
  String letter;
  IconData iconSign;
  SignType? type;
  Sign(
    this.letter,
    this.iconSign, {
    this.type = SignType.letter,
  });

  getLetterType(BuildContext context) {
    return signType(context, type!);
  }
}
