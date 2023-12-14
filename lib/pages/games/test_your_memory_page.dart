part of '../pages.dart';

class TestYourMemoryPage extends HookWidget {
  const TestYourMemoryPage({
    super.key,
    this.difficulty = Difficulty.easy,
  });
  final Difficulty difficulty;

  @override
  Widget build(BuildContext context) {
    final createTestYourGameState = useState<TestYourGame>(
      createTestYourGame(listOnlySingAndNumbers, 3),
    );
    final lifes = useState<int>(5);
    final correctAnswer = createTestYourGameState.value.correctAnswer;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                LifesCounter(
                  lifes: lifes.value,
                ),
                SimpleText(
                  text: 'Cual es seña de la ${correctAnswer.type!.name}',
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                SimpleText(
                  text: '${correctAnswer.letter}',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: AlignedGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    itemCount: createTestYourGameState.value.options.length,
                    itemBuilder: (context, int index) {
                      final letterWithSignArray =
                          createTestYourGameState.value.options[index];
                      return InkWell(
                        onTap: () {
                          if (letterWithSignArray.letter ==
                              createTestYourGameState
                                  .value.correctAnswer.letter) {
                            createTestYourGameState.value =
                                createTestYourGame(listOnlySingAndNumbers, 3);
                          } else {
                            if (lifes.value == 0) {
                              context.pop();
                            }
                            lifes.value--;
                          }
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 100,
                            height: 100,
                            child: SvgPicture.asset(
                              letterWithSignArray
                                  .pathImage, // Reemplaza con la ruta de tu archivo SVG
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LifesCounter extends StatelessWidget {
  const LifesCounter({
    super.key,
    required this.lifes,
  });
  final int lifes;
  @override
  Widget build(BuildContext context) {
    final totalLifes = lifes;
    return Container(
      child: Row(
        children: [
          for (int i = 0; i < lifes; i++)
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          for (int i = lifes; i < 5; i++)
            Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
        ],
      ),
    );
  }
}
