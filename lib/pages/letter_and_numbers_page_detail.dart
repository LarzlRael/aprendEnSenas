part of 'pages.dart';

class LetterAndNumbersPageDetail extends StatelessWidget {
  final Sign sing;
  const LetterAndNumbersPageDetail({super.key, required this.sing});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final style = TextStyle(fontSize: 45, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: Text("${sing.type!.name} ${sing.letter}".toCapitalize()),
      ),
      body: Center(
        child: Container(
          /* color: Colors.amber, */
          width: media.width * 0.74,
          height: media.height * 0.60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                sing.iconSign,
                size: 100,
              ),
              Text(sing.letter, style: style),
            ],
          ),
        ),
      ),
    );
  }
}
