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
    final createTestYourGameState = useState<TestYourGame>(
      createTestYourGame(listOnlySingAndNumbers, generate.numberOptions),
    );

    final totalLifes = generate.lifes;
    final lifesRemaing = useState<int>(generate.lifes);

    final correctAnswer = createTestYourGameState.value.correctAnswer;
    final settings = ref.watch(settingsProvider);
    final reff = ref.read(settingsProvider.notifier);
    final isCorrect = useState<bool>(false);

    useEffect(() {
      if (isCorrect.value) {
        createTestYourGameState.value =
            createTestYourGame(listOnlySingAndNumbers, 3);
        isCorrect.value = false;
      }
    }, [isCorrect.value]);

    return Scaffold(
      appBar: AppBar(
        leading: BackIcon(),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleText(
                text: 'Hits',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              SimpleText(
                text: 'Nivel: ${level.name}',
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ],
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
              text: 'Cual es la seña de la ${correctAnswer.type!.name}',
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
                      onTap: () {
                        if (letterWithSignArray.letter ==
                            createTestYourGameState
                                .value.correctAnswer.letter) {
                          /* createTestYourGameState.value =
                              createTestYourGame(listOnlySingAndNumbers, 3); */
                          isCorrect.value = true;
                          reff.playSound('assets/sounds/correct_sound_2.mp3');
                        } else {
                          isCorrect.value = false;
                          reff.playSoundAndVibration(
                              'assets/sounds/wrong_sound_1.mp3');
                          lifesRemaing.value--;
                          if (lifesRemaing.value == 0) {
                            context.pop();
                          }
                        }
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 100,
                          height: 100,
                          child: ColoredIcon(
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
