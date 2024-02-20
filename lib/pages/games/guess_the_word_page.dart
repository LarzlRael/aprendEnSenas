part of '../pages.dart';

const fontSize = 45.0;

class GuessTheWordPage extends HookConsumerWidget {
  const GuessTheWordPage({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final mediaQuery = MediaQuery.of(context).size;
    final settingNotifier = ref.read(settingsProvider.notifier);
    final settingS = ref.watch(settingsProvider);
    final signProviderN = ref.watch(signProvider);

    final randomCommonWord = useState<GuessTheWord>(getRandomWordFromStringList(
        getWords(settingS.language), signProviderN.currentListSing));
    final currentWord = useState("");
    final isCorrect = useState(false);

    final restartKey = useState(UniqueKey());
    final textEditingController = useTextEditingController();

    useEffect(() {
      if (isCorrect.value) {
        randomCommonWord.value = getRandomWordFromStringList(
            getWords(settingS.language), signProviderN.currentListSing);
        currentWord.value = "";
        restartKey.value = UniqueKey();
        textEditingController.clear();
      }
      isCorrect.value = false;
      return null;
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
                    key: restartKey.value,
                    singList: randomCommonWord.value.correctWordSignList,
                  ),
                ),
                /* VerificationCode(
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

                  margin: const EdgeInsets.all(2),
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
                ), */
                TextField(
                  controller: textEditingController,
                  maxLength: randomCommonWord.value.correctWordString.length,
                  decoration: InputDecoration(
                    label: SimpleText(
                      text: randomCommonWord.value.correctWordString,

                      /* text: replaceMiddleWithUnderscores(
                        randomCommonWord.value.word
                            .removeDiacriticsFromString(),
                      ), */
                      fontSize: fontSize,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                  ),
                  onChanged: (value) {
                    final correctWordString =
                        randomCommonWord.value.correctWordString;
                    if (value == correctWordString) {
                      // La cadena ingresada es correcta
                      settingNotifier.playSound(correctsSounds[2]);
                      isCorrect.value = true;
                    } else if (value.length == correctWordString.length) {
                      // La longitud de la cadena ingresada es correcta pero no coincide con la palabra correcta
                      settingNotifier.startVibrate(millisec: 250);
                      isCorrect.value = false;
                    } else {
                      // La longitud de la cadena ingresada es diferente de la palabra correcta
                      isCorrect.value = false;
                    }
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
