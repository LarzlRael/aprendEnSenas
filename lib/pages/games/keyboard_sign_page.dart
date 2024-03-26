// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../pages.dart';

const okColor = Color(0xFF25c461);
const wrongColor = Color(0xFFFF7043);

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
    final textSign = useState<List<Sign>>([]);
    final isLetter = useState<bool>(true);
    final fumar = useState<List<GameLetter>>([]);
    final usedLetters = useState<List<KeyColor>>([]);
    final try_ = useState(0);
    final uniqueKey = useState<UniqueKey>(UniqueKey());
    final isBlock = useState(false);

    void resetWidget() {
      text.value = ''; // Reiniciar el texto
      textSign.value = []; // Limpiar la lista de signos
      isLetter.value = true; // Restaurar el estado de letra
      fumar.value = []; // Limpiar la lista de GameLetter
      usedLetters.value = []; // Limpiar la lista de letras usadas
      try_.value = 0; // Reiniciar el contador de intentos
      uniqueKey.value = UniqueKey(); // Generar una nueva clave única
    }

    void verifyTry() {
      if (text.value.length < 5) return;
      /* ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cantidad de letras insuficiente'),
        ),
      ); */
      isBlock.value = true;
      final getlast5 = text.value.substring(text.value.length - 5);
      final getLista = generateList(getlast5);

      if (getlast5 == correct) {
        resetWidget();
      } else {
        print('incorrecto');
        List<GameLetter> updatedList = List<GameLetter>.from(fumar.value);
        for (int i = 0; i < getLista.length; i++) {
          final index = i + (5 * try_.value);
          if (getLista[i].letter == correct.split('')[i]) {
            updatedList[index] = fumar.value[index].copyWith(color: okColor);
            usedLetters.value
                .add(KeyColor(key: getLista[i].letter, color: okColor));
          }
          if (correct.split('').contains(fumar.value[index].letter)) {
            updatedList[index] =
                fumar.value[index].copyWith(color: Colors.blue);
            usedLetters.value
                .add(KeyColor(key: getLista[i].letter, color: Colors.blue));
          } else {
            updatedList[index] = fumar.value[index].copyWith(color: wrongColor);
            usedLetters.value
                .add(KeyColor(key: getLista[i].letter, color: wrongColor));
          }
        }
        fumar.value = updatedList;
        try_.value++;
      }
    }

    useEffect(() {
      return () {
        final list = generateListToMessageUtil(
          ref.read(signProvider).currentListSing,
          text.value,
        );
        if (fumar.value.length % 5 == 0) {
          isBlock.value = true;
        }
      };
      /* verify */
    }, [text.value]);
    return Scaffold(
      key: uniqueKey.value,
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: 50),
            TextButton(
              onPressed: () {
                isLetter.value = !isLetter.value;
              },
              child: Text('cambiar vista'),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: AlignedGridView.count(
                  crossAxisCount: 5,
                  mainAxisSpacing: 2.5,
                  crossAxisSpacing: 2.5,
                  itemCount: fumar.value.length,
                  itemBuilder: (_, index) {
                    final e = fumar.value[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        color: e.color,
                        /* border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ), */
                      ),
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
              onChanged: (String newText) {
                /* text.value = newText;
                fumar.value = generateList(newText);
                print(newText); */
              },
              onLetterChanged: (String newText) {
                if (isBlock.value) return;
                text.value = text.value + newText;
                fumar.value = fumar.value..add(GameLetter(letter: newText));
                print(newText);
              },
              onEnter: () {
                print(text.value);
                verifyTry();
                isBlock.value = false;
              },
              onBackSpace: (newText) {
                text.value = newText;
                fumar.value = fumar.value..removeLast();
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
