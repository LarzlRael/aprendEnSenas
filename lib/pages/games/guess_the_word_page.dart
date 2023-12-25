part of '../pages.dart';

class GuessTheWordPage extends HookWidget {
  const GuessTheWordPage({super.key});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final randomCommonWord =
        useState<GuessTheWord>(getRandomWordFromStringList(commonWords));
    final currentWord = useState("");
    final isCorrect = useState(false);
    final onEditing = useState(true);
    final restartKey = useState(UniqueKey());

    useEffect(() {
      if (isCorrect.value) {
        randomCommonWord.value = getRandomWordFromStringList(commonWords);
        currentWord.value = "";
        restartKey.value = UniqueKey();
      }
      isCorrect.value = false;
    }, [isCorrect.value]);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: BackIcon(
                    margin: const EdgeInsets.all(15),
                  ),
                ),
                /* Text(
                  randomCommonWord.value,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ), */
                Container(
                  width: mediaQuery.width * 0.8,
                  height: mediaQuery.height * 0.60,
                  child: PageViewSignSlider(
                    key: UniqueKey(),
                    singList: randomCommonWord.value.correctWord,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.refresh),
                      label: Text('Reiniciar ${randomCommonWord.value.word}'),
                    ),
                  ),
                ),
                VerificationCode(
                  key: restartKey.value,
                  fullBorder: true,
                  itemSize: 55,
                  underlineWidth: 1.5,
                  /* textStyle: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Theme.of(context).primaryColor), */
                  textStyle: textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                  keyboardType: TextInputType.text,
                  underlineColor: Colors
                      .amber, // If this is null it will use primaryColor: Colors.red from Theme
                  length: randomCommonWord.value.word.length,
                  cursorColor: Colors
                      .blue, // If this is null it will default to the ambient

                  margin: const EdgeInsets.all(5),
                  onCompleted: (String value) {
                    currentWord.value = value;
                    if (currentWord.value == randomCommonWord.value.word) {
                      isCorrect.value = true;
                    }
                  },

                  onEditing: (bool value) {
                    onEditing.value = value;
                    if (!onEditing.value) FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
