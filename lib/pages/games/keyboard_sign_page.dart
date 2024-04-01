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

class KeyboardSignPage extends HookConsumerWidget {
  const KeyboardSignPage({super.key});
  static const routeName = 'keyboard_sign_page';
  @override
  Widget build(BuildContext context, ref) {
    final correct = 'pulga';
    final text = useState<String>('');
    final gridLetters = useState<List<GameLetter>>(
        List.generate(25, (index) => GameLetter(letter: '')));
    final usedLetters = useState<List<KeyColor>>([]);
    final try_ = useState(0);
    final uniqueKey = useState<UniqueKey>(UniqueKey());
    final isBlock = useState(false);
    final currentIndex = useState(0);
    final signList = useState<List<Sign>>(generateListToMessageUtil(
        ref.read(signProvider).currentListSing, correct));

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
      if (gridLetters.value[5 * try_.value].letter.isEmpty ||
          currentIndex.value % 5 != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cantidad de letras insuficiente'),
          ),
        );
        return;
      }

      isBlock.value = true;
      final getlast5 = text.value.substring(text.value.length - 5);
      final getLista = generateList(getlast5);
      final correctAnswer = correct.split('');

      if (getlast5 == correct) {
        return context.pop();
      }
      for (int i = 0; i < getLista.length; i++) {
        final index = i + (5 * try_.value);
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

      try_.value++;
      if (try_.value == 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Has superado el número de intentos'),
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
      if (currentIndex.value > 0 && currentIndex.value % 5 == 0) {
        isBlock.value = true;
      }

      return () {};
      /* verify */
    }, [text.value]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Keyboard Sign'),
      ),
      key: uniqueKey.value,
      body: SizedBox.expand(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                margin: EdgeInsets.symmetric(horizontal: 45),
                child: AlignedGridView.count(
                  crossAxisCount: 5,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  itemCount: gridLetters.value.length,
                  itemBuilder: (_, index) {
                    final e = gridLetters.value[index];
                    return AnimatedContainer(
                      duration: Duration(
                          milliseconds:
                              ((index - (5 * try_.value)) * 150) + 1000),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: e.color,
                          border: e.color != null
                              ? currentIndex.value == index
                                  ? Border.all(color: Colors.white, width: 1)
                                  : null
                              : Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1)),
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
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
              onChanged: (String newText) {
                /* text.value = newText;
                fumar.value = generateList(newText);
                print(newText); */
              },
              onLetterChanged: (String newText) {
                if (isBlock.value) return;

                // Asegúrate de que text.value.length esté dentro del rango de
                // Actualiza el texto
                text.value = text.value + newText;

                if (currentIndex.value < gridLetters.value.length) {
                  gridLetters.value[currentIndex.value] = gridLetters
                      .value[currentIndex.value]
                      .copyWith(letter: newText);
                  currentIndex
                      .value++; // Incrementa el índice para la próxima letra
                  return;
                }
                isBlock.value = false;
              },
              onEnter: () {
                print(text.value);
                verifyTry();
              },
              onBackSpace: (_) {
                if (currentIndex.value == 0 || currentIndex.value % 5 == 0) {
                  return;
                }
                currentIndex.value--;
                gridLetters.value[currentIndex.value] =
                    gridLetters.value[currentIndex.value].copyWith(letter: '');
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
