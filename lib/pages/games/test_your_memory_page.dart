part of '../pages.dart';

class TestYourMemoryPage extends HookConsumerWidget {
  const TestYourMemoryPage({
    super.key,
    required this.level,
  });
  final Level level;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generate = getTestYourMemoryGameLevel(level);

    final totalLifes = generate.lifes;
    final lifesRemaing = useState<int>(generate.lifes);

    final createTestYourGameState = useState<TestYourGame>(
      createTestYourGame(
        ref.watch(signProvider).currentListSing,
        generate.numberOptions,
      ),
    );
    final correctAnswer = createTestYourGameState.value.correctAnswer;
    final settingN = ref.read(settingsProvider.notifier);
    final isCorrect = useState<bool>(false);

    final currentScore = useState<int>(0);
    final currentRecord =
        useFuture(getGameScore(GameType.prueba_tu_memoria, level));

    final key = useState(UniqueKey());

    useEffect(() {
      if (isCorrect.value) {
        createTestYourGameState.value = createTestYourGame(
          ref.watch(signProvider).currentListSing,
          generate.numberOptions,
        );
        settingN.playSound('assets/sounds/correct_sound_2.mp3');
        currentScore.value = currentScore.value + 10;
        isCorrect.value = false;
        key.value = UniqueKey();
      }
      return;
    }, [isCorrect.value]);

    return Scaffold(
      appBar: AppBar(
        leading: BackIcon(
          margin: EdgeInsets.only(left: 10),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextSpanHit(
                  text: 'Hits: ',
                  score: currentScore.value,
                  key: key.value,
                ),
                TextSpanHit(
                  text: 'Record: ',
                  score: currentRecord.data ?? 0,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackIcon(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleText(
                      text: 'Hits',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    SimpleText(
                      text: 'Dificultad: ${difficulty.name}',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ), */
            LifesCounter(
              totalLifes: totalLifes,
              lifesRemaining: lifesRemaing.value,
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
            SimpleText(
              text: AppLocalizations.of(context)!.what_is_the_signal_for,
              fontSize: 22,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SimpleText(
              text: '${correctAnswer.letter}',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: AlignedGridView.count(
                  crossAxisCount: generate.rows,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  itemCount: createTestYourGameState.value.options.length,
                  itemBuilder: (context, int index) {
                    final letterWithSignArray =
                        createTestYourGameState.value.options[index];
                    return InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onTap: () async {
                        if (letterWithSignArray.letter ==
                            createTestYourGameState
                                .value.correctAnswer.letter) {
                          /* createTestYourGameState.value =
                              createTestYourGame(listOnlySingAndNumbers, 3); */
                          isCorrect.value = true;
                        } else {
                          isCorrect.value = false;
                          settingN.playSoundAndVibration(
                            'assets/sounds/wrong_sound_1.mp3',
                          );
                          lifesRemaing.value--;
                          if (lifesRemaing.value == 0) {
                            await saveGameScore(
                              GameType.prueba_tu_memoria,
                              currentScore.value,
                              level,
                            );
                            context.pop();
                          }
                        }
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 100,
                          height: 100,
                          child: SignIcon(
                            icon: letterWithSignArray.iconSign,
                            size: 55,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LifesCounter extends StatelessWidget {
  final int totalLifes;
  final int lifesRemaining;

  final EdgeInsets? margin;
  const LifesCounter({
    super.key,
    required this.totalLifes,
    required this.lifesRemaining,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    final size = 30.0;
    final filledHeartCount = totalLifes - lifesRemaining;

    return Container(
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = totalLifes - 1; i >= filledHeartCount; i--)
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: size,
            ),
          for (int i = 0; i < filledHeartCount; i++)
            Icon(
              Icons.favorite_border,
              color: Colors.red,
              size: size,
            ),
        ],
      ),
    );
  }
}

class TextSpanHit extends StatelessWidget {
  const TextSpanHit({super.key, required this.text, required this.score});
  final String text;
  final int score;
  @override
  Widget build(BuildContext context) {
    final color = Colors.grey;
    return ScaleAnimation(
      end: 1.5,
      duration: Duration(milliseconds: 250),
      child: RichText(
        key: key,
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            TextSpan(
              text: score.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
