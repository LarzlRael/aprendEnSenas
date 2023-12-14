part of '../pages.dart';

class SelectDifficultyPage extends StatelessWidget {
  final GameType gameType;
  final String? gameRoutePage;
  const SelectDifficultyPage({
    super.key,
    required this.gameType,
    this.gameRoutePage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecciona una dificultad"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Center(
          child: Column(
            children: [
              SimpleText(
                text: gameType.name.snakeCaseToWords().toCapitalize(),
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
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, int index) =>
                      SizedBox(height: 15),
                  shrinkWrap: true,
                  itemCount: Difficulty.values.length,
                  itemBuilder: (context, int index) {
                    final difficulty = Difficulty.values[index];
                    return SizedBox(
                      height: 55,
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            colorByDifficulty[difficulty],
                          ),
                        ),
                        onPressed: () {
                          context.push(
                            "/$gameRoutePage",
                            extra: difficulty,
                          );
                        },
                        child: Text(
                            difficulty.name.snakeCaseToWords().toCapitalize()),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
