part of '../pages.dart';

class WordInSightPage extends HookWidget {
  const WordInSightPage({super.key});
  @override
  Widget build(BuildContext context) {
    final state =
        useState<WordInSightGame>(createWordInSightGame(palabrasComunes, 4));
    ;
    final indexState = useState(-1);
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            SimpleText(
              text: 'Selecciona la palabra que corresponde a la imagen',
            ),
            Wrap(
              children: state.value.correctAnswerList.map((sign) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 75,
                    height: 75,
                    child: SvgPicture.asset(
                      sign.pathImage,
                      width: 50,
                      height: 50,
                    ),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: AlignedGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                itemCount: state.value.options.length,
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: () {
                      indexState.value = index;
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 5,
                          color: indexState.value == index
                              ? Colors.green
                              : Colors.transparent,
                        ),
                      ),
                      child: Container(
                        /* decoration: BoxDecoration(
                          color: indexState.value == index
                              ? Colors.blue
                              : Colors.white,
                        ), */
                        padding: EdgeInsets.all(10),
                        width: 100,
                        height: 100,
                        child: Center(
                          child: SimpleText(
                            text: state.value.options[index],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                child: Text('Siguiente'),
                onPressed: indexState.value == -1
                    ? null
                    : () {
                        final value = state.value;
                        if (value.options[indexState.value] ==
                            value.correctAnswerString) {
                          state.value =
                              createWordInSightGame(palabrasComunes, 4);
                          indexState.value = -1;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Incorrecto'),
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
            SizedBox(height: 10),
          ],
        )),
      ),
    );
  }
}
