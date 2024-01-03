part of '../pages.dart';

class SelectDifficultyPage extends StatelessWidget {
  final String gameTitle;
  final String? gameRouteDestinyPage;
  final IconData? iconGame;
  const SelectDifficultyPage({
    super.key,
    this.gameRouteDestinyPage,
    this.iconGame,
    required this.gameTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        /* color: Colors.blue, */

        child: Stack(
          children: [
            SafeArea(
              child: Positioned(
                left: 0,
                top: 0,
                child: BackIcon(
                  margin: EdgeInsets.all(10),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Icon(
                iconGame,
                size: 175,
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SimpleText(
                    text: gameTitle.snakeCaseToWords().toCapitalize(),
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    lineHeight: 1,
                  ),
                  SimpleText(
                    text: "Selecciona una dificultad",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, int index) =>
                        SizedBox(height: 15),
                    shrinkWrap: true,
                    itemCount: Difficulty.values.length,
                    itemBuilder: (context, int index) {
                      final difficulty = Difficulty.values[index];
                      final listMessage = generateListToMessageUtil(
                        listOnlySingAndNumbers,
                        difficulty.name.removeDiacriticsFromString(),
                      );
                      return SizedBox(
                        height: 75,
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              colorByDifficulty[difficulty],
                            ),
                          ),
                          onPressed: () {
                            context.push(
                              "/games/$gameRouteDestinyPage",
                              extra: difficulty,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SimpleText(
                                text: difficulty.name
                                    .snakeCaseToWords()
                                    .toCapitalize(),
                                fontSize: 18,
                              ),
                              Wrap(
                                children: listMessage
                                    .map(
                                      (sign) => Icon(
                                        sign.iconSign,
                                        size: 25,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
