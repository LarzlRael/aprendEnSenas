part of '../pages.dart';

class SelectDifficultyPage extends StatelessWidget {
  const SelectDifficultyPage({
    super.key,
    /* required this.gameType, */
  });
  /* final GameType gameType; */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecciona una dificultad"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Text("difcultad"),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, int index) => SizedBox(height: 5),
                shrinkWrap: true,
                itemCount: Difficulty.values.length,
                itemBuilder: (context, int index) {
                  final difficulty = Difficulty.values[index];
                  return FilledButton(
                    onPressed: () {},
                    child: Text(difficulty.name.convertSnakeCaseToNormal()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
