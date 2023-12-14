part of '../pages.dart';

class WordInSightPage extends HookWidget {
  const WordInSightPage({super.key});
  @override
  Widget build(BuildContext context) {
    final state =
        useState<WordInSightGame>(createWordInSightGame(commonWords, 4));
    final isCorrect = useState(false);

    final indexState = useState(-1);

    final lifesCounter = useState(5);
    final status = useState<double>(0.0);
    useEffect(() {
      if (isCorrect.value) {
        state.value = createWordInSightGame(commonWords, 4);
        indexState.value = -1;
      }
      isCorrect.value = false;
    }, [isCorrect.value]);
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackIcon(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        status.value = status.value + 0.1;
                        print(status.value);
                      },
                      child: /* LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 20,
                        value: status.value,
                      ), */
                          TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(
                          begin: 0,
                          end: status.value,
                        ),
                        builder: (context, value, _) => LinearProgressIndicator(
                          value: value,
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                LifesAndCounter(lifes: lifesCounter.value),
              ],
            ),
            SimpleText(
              text: '¿Cual es la palabra?',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              padding: EdgeInsets.symmetric(vertical: 10),
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
                child: Text('Verificar'),
                onPressed: indexState.value == -1
                    ? null
                    : () {
                        final value = state.value;
                        if (value.options[indexState.value] ==
                            value.correctAnswerString) {
                          isCorrect.value = true;
                          status.value = status.value + 0.1;
                        } else {
                          lifesCounter.value--;
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

class LifesAndCounter extends StatelessWidget {
  final int lifes;

  const LifesAndCounter({super.key, required this.lifes});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite,
          color: Colors.red,
          size: 25,
        ),
        SimpleText(
          text: lifes.toString(),
          color: Colors.red,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
      ],
    );
  }
}
