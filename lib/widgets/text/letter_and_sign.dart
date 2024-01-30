part of '../widgets.dart';

class LetterAndSign extends StatelessWidget {
  final String text;
  final double? iconSize;
  final double? letterSize;
  final Color? color;
  const LetterAndSign({
    super.key,
    required this.text,
    this.iconSize,
    this.letterSize,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: generateListToMessageUtil(
              listAllSign, text.removeDiacriticsFromString())
          .map((sign) => IconAndLetter(
                sign: sign,
                iconSize: iconSize,
                letterSize: letterSize,
                color: color,
              ))
          .toList(),
    );
  }
}

class IconAndLetter extends StatelessWidget {
  final Sign sign;
  final double? iconSize;
  final double? letterSize;
  final Color? color;
  const IconAndLetter({
    super.key,
    required this.sign,
    this.iconSize = 30,
    this.letterSize = 12,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          sign.iconSign,
          size: iconSize,
          /* color: Colors.white, */
        ),
        SimpleText(
          text: sign.letter.toUpperCase(),
          fontSize: letterSize,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
          color: color,
        ),
      ],
    );
  }
}