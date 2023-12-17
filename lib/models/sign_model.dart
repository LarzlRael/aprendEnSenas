part of 'models.dart';

enum SignType {
  letter,
  number,
}

class Sign {
  String letter;
  String pathImage;
  SignType? type;
  Sign(this.letter, this.pathImage, {this.type = SignType.letter});
}