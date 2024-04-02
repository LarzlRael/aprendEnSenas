part of '../pages.dart';

const okColor = Color(0xFF25c461);
const wrongColor = Color(0xFF757575);
const swapColor = Color(0xFFe3a81c);

class GameLetter {
  final String letter;
  final Color? color;
  GameLetter({required this.letter, this.color});

  GameLetter copyWith({
    String? letter,
    Color? color,
  }) {
    return GameLetter(
      letter: letter ?? this.letter,
      color: color ?? this.color,
    );
  }
}

List<GameLetter> generateList(String text) {
  return text.split('').map((e) {
    return GameLetter(letter: e);
  }).toList();
}

const totalTry = 5;

class KeyboardSignPage extends HookConsumerWidget {
  const KeyboardSignPage({super.key});
  static const routeName = 'keyboard_sign_page';
  @override
  Widget build(BuildContext context, ref) {
    final correct = useState(getRandomWordsKeyboardList());
    final correctLength = correct.value.length;
    final text = useState<String>('');
    final gridLetters = useState<List<GameLetter>>(List.generate(
        totalTry * correctLength, (index) => GameLetter(letter: '')));
    final usedLetters = useState<List<KeyColor>>([]);
    final currentTry = useState(0);
    final uniqueKey = useState<UniqueKey>(UniqueKey());
    final isBlock = useState(false);
    final isFinished = useState(false);
    final currentIndex = useState(0);
    final signList = useState<List<Sign>>(generateListToMessageUtil(
        ref.read(signProvider).currentListSing, correct.value));

    /* void resetWidget() {
      text.value = ''; // Reiniciar el texto
      textSign.value = []; // Limpiar la lista de signos
      isLetter.value = true; // Restaurar el estado de letra
      fumar.value = []; // Limpiar la lista de GameLetter
      usedLetters.value = []; // Limpiar la lista de letras usadas
      try_.value = 0; // Reiniciar el contador de intentos
      uniqueKey.value = UniqueKey(); // Generar una nueva clave única
    }
 */
    void verifyTry() {
      if (gridLetters.value[correctLength * currentTry.value].letter.isEmpty ||
          currentIndex.value % correctLength != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.insufficient),
          ),
        );
        return;
      }

      isBlock.value = true;
      final getlastNletter =
          text.value.substring(text.value.length - correctLength);
      final getLista = generateList(getlastNletter);
      final correctAnswer = correct.value.split('');

      if (getlastNletter == correct.value) {
        isFinished.value = true;
        return;
      }
      for (int i = 0; i < getLista.length; i++) {
        final index = i + (correctLength * currentTry.value);
        if (getLista[i].letter == correctAnswer[i]) {
          gridLetters.value[index] =
              gridLetters.value[index].copyWith(color: okColor);
          usedLetters.value
              .add(KeyColor(key: getLista[i].letter, color: okColor));
          continue;
        }
        if (correctAnswer.contains(gridLetters.value[index].letter)) {
          gridLetters.value[index] =
              gridLetters.value[index].copyWith(color: swapColor);
          usedLetters.value
              .add(KeyColor(key: getLista[i].letter, color: swapColor));
          continue;
        }
        /* wrong color */
        gridLetters.value[index] =
            gridLetters.value[index].copyWith(color: wrongColor);
        usedLetters.value
            .add(KeyColor(key: getLista[i].letter, color: wrongColor));
      }

      currentTry.value++;
      if (currentTry.value == totalTry) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!
                .you_have_exceeded_the_number_of_attempts),
          ),
        );
        return context.pop();
      }
      isBlock.value = false;
      return;
    }

    useEffect(() {
      /* final list = generateListToMessageUtil(
        ref.read(signProvider).currentListSing,
        text.value,
      ); */
      if (currentIndex.value > 0 && currentIndex.value % correctLength == 0) {
        isBlock.value = true;
      }

      return () {};
      /* verify */
    }, [text.value]);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.word_challenge),
      ),
      key: uniqueKey.value,
      body: isFinished.value
          ? GameOverScreen(
              title: SimpleText(
                text: AppLocalizations.of(context)!.congratulations,
                fontSize: 30,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              subtitle: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: signList.value
                            .map((e) => Column(
                                  children: [
                                    Card(
                                      child: Container(
                                        width: correctLength == 6 ? 45 : 55,
                                        height: correctLength == 6 ? 45 : 55,
                                        child: Icon(e.iconSign,
                                            size: correctLength == 6 ? 30 : 40),
                                      ),
                                    ),
                                    SimpleText(
                                      text: e.letter.toUpperCase(),
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                  SimpleText(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    text: 'Adivinaste la palabra correctamente',
                    fontSize: 20,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              resultType: ResultGameType.win,
              pathImage: getValueSoundFromList(correctImages),
            )
          : SizedBox.expand(
              child: Column(
                children: [
                  Wrap(
                    children: signList.value
                        .map((e) => Card(
                              child: Container(
                                width: 60,
                                height: 60,
                                child: Icon(
                                  e.iconSign,
                                  size: 45,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 25),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: AlignedGridView.count(
                        crossAxisCount: correctLength,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        itemCount: gridLetters.value.length,
                        itemBuilder: (_, index) {
                          final e = gridLetters.value[index];
                          return AnimatedContainer(
                            duration: Duration(
                                milliseconds: ((index -
                                            (correctLength *
                                                currentTry.value)) *
                                        150) +
                                    1000),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: e.color,
                              border: e.color == null &&
                                      currentIndex.value == index &&
                                      !isBlock.value
                                  ? Border.all(color: Colors.white, width: 1.5)
                                  : Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1,
                                    ),
                            ),
                            width: 60,
                            height: 60,
                            child: Center(
                              child: SimpleText(
                                text: e.letter.toUpperCase(),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  KeyboardSignWidget(
                    showNumbers: false,
                    showSpace: false,
                    showSwitcherLetter: false,
                    isShowIcons: false,
                    onChanged: (_) {},
                    onLetterChanged: (String newText) {
                      if (isBlock.value) return;
                      // Asegúrate de que text.value.length esté dentro del rango de
                      // Actualiza el texto
                      text.value = text.value + newText;
                      if (currentIndex.value < gridLetters.value.length) {
                        gridLetters.value[currentIndex.value] = gridLetters
                            .value[currentIndex.value]
                            .copyWith(letter: newText);
                        // Incrementa el índice para la próxima letra
                        currentIndex.value++;
                        return;
                      }
                    },
                    onEnter: () {
                      print(text.value);
                      verifyTry();
                    },
                    onBackSpace: (_) {
                      if (currentIndex.value == 0 ||
                          currentIndex.value % correctLength == 0) {
                        return;
                      }
                      currentIndex.value--;
                      gridLetters.value[currentIndex.value] = gridLetters
                          .value[currentIndex.value]
                          .copyWith(letter: '');
                    },
                    /* isShowIcons: !isLetter.value, */
                    coloredKeys: usedLetters.value,
                    lettersUppercase: false,
                  ),
                ],
              ),
            ),
    );
  }
}
