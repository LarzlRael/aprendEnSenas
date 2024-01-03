part of 'pages.dart';

class LetterAndNumbersPageDetail extends HookWidget {
  final String signChar;
  const LetterAndNumbersPageDetail({super.key, required this.signChar});
  @override
  Widget build(BuildContext context) {
    final sign = getIconSign(signChar);

    final media = MediaQuery.of(context).size;
    final style = TextStyle(fontSize: 175, fontWeight: FontWeight.w600);
    return Scaffold(
      appBar: AppBar(
        title: Text("${sign.type!.name} ${sign.letter}".toCapitalize()),
        leading: BackIcon(
          margin: EdgeInsets.only(left: 10),
        ),
      ),
      body: SizedBox.expand(
        /* color: Colors.amber, */
        /* width: media.width * 0.75,
        height: media.height * 0.65, */
        child: Center(
          child: Card(
            child: Container(
              width: media.width * 0.90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, -35),
                    child: Text(sign.letter, style: style),
                  ),
                  Icon(
                    sign.iconSign,
                    size: 175,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
