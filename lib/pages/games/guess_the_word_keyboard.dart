part of '../pages.dart';

class GuessTheWordKeyboard extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* State key */
    final uniqueKey = useState<UniqueKey>(UniqueKey());
    final text = useState<String>('');
    final answer = useState<List<String>>([]);
    final textGame = useState<List<Sign>>([]);
    void initGame() {
      text.value = getOneRandomWords(ref.read(settingsProvider).language);
      textGame.value = generateListToMessageUtil(
          ref.read(signProvider).currentListSing, text.value);
      uniqueKey.value = UniqueKey();
      answer.value = [];
    }

    useEffect(() {
      initGame();
    }, []);

    return Scaffold(
        appBar: AppBar(
          title: Text('Adivina la palabra'),
          actions: [
            IconButton(
              onPressed: () {
                /* uniqueKey.value = UniqueKey(); */
                initGame();
              },
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        body: Container(
          key: uniqueKey.value,
          child: Column(
            /* mainAxisAlignment: MainAxisAlignment.end, */
            children: [
              /* ResultGroup(), */
              /* Text(text.value,
                  style: TextStyle(fontSize: 45, letterSpacing: 15)), */
              Wrap(
                children: textGame.value
                    .map(
                      (e) => Card(
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: Center(
                            child: Text(
                              e.letter.toUpperCase(),
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Wrap(
                children: textGame.value
                    .map(
                      (e) => Card(
                        color: answer.value.contains(e.letter)
                            ? Colors.green
                            : Colors.transparent,
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: Center(
                            child: Text(
                              e.letter.toUpperCase(),
                              style: TextStyle(
                                fontSize: 25,
                                color: answer.value.contains(e.letter)
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Spacer(),
              for (var row in keyboardListGenerate(
                  ref.read(signProvider).currentListSing))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Create a button for each key in the row
                    for (var key in row)
                      KeyboardButton(
                        isSelected: textGame.value
                            .map((e) => e.letter)
                            .join()
                            .contains(key.value.letter),
                        keyView: key.type == KeyboardButtonType.normal
                            ? (Icon(
                                key.value.iconSign,
                                size: 30,
                                color: Colors.white,
                              ))
                            : key.widgetIcon,
                        icon: key.widgetIcon,
                        type: key.type!,
                        onLongPress: () {
                          switch (key.type) {
                            case KeyboardButtonType.backSpace:
                              text.value = '';
                              break;
                            default:
                          }
                        },
                        onPressed: () {
                          switch (key.type) {
                            case KeyboardButtonType.backSpace:
                              if (answer.value.isNotEmpty) {
                                text.value = text.value
                                    .substring(0, text.value.length - 1);
                                answer.value.removeLast();
                              }
                              break;
                            case KeyboardButtonType.normal:
                              /* if (text.value.length >= textGame.value.length)
                                return; */
                              text.value = text.value + key.value.letter;
                              answer.value.add(key.value.letter);
                              break;

                            case KeyboardButtonType.space:
                              text.value = text.value + ' ';
                              break;
                            default:
                          }
                        },
                      ),
                  ],
                ),
            ],
          ),
        ));
  }
}
