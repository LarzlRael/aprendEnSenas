part of '../pages.dart';

const borderRadious = 10.0;

class WordInSightPage extends HookConsumerWidget {
  const WordInSightPage({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final state =
        useState<WordInSightGame>(createWordInSightGame(commonWords, 4));
    final isCorrect = useState(false);
    final settings = ref.watch(settingsProvider);

    final selectedCardIndex = useState(-1);

    final lifesCounter = useState(5);
    final status = useState<double>(0.0);
    useEffect(() {
      if (isCorrect.value) {
        state.value = createWordInSightGame(commonWords, 4);
        selectedCardIndex.value = -1;
      }
      isCorrect.value = false;
    }, [isCorrect.value]);
    /* useEffect(() {
      if (lifesCounter.value == 0) {
        context.pop();
      }
      return null;
    }, [lifesCounter.value]); */
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
                    child: Icon(
                      sign.iconSign,
                      size: 45,
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
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadious),
                    ),
                    onTap: () {
                      selectedCardIndex.value = index;
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadious),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadious),
                          border: Border.all(
                            color: selectedCardIndex.value == index
                                ? Colors.green
                                : Colors.transparent,
                            width: 4,
                          ),
                        ),
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
                onPressed: selectedCardIndex.value == -1
                    ? null
                    : () {
                        if (settings.isVibrationActive) {
                          VibrateServiceImp().vibrate(millisec: 250);
                        }

                        final value = state.value;
                        if (value.options[selectedCardIndex.value] ==
                            value.correctAnswerString) {
                          isCorrect.value = true;
                          status.value = status.value + 0.1;
                        } else {
                          selectedCardIndex.value = -1;
                          lifesCounter.value--;
                          if (lifesCounter.value == 0) {
                            context.pop();
                          }
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

const millisecondsAnimation = 250;

class LifesAndCounter extends HookWidget {
  final int lifes;

  const LifesAndCounter({super.key, required this.lifes});
  @override
  Widget build(BuildContext context) {
    final key = useState<ValueKey<String>>(ValueKey<String>(lifes.toString()));
    useEffect(() {
      key.value = ValueKey<String>(lifes.toString());
      return null;
    }, [lifes]);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScaleAnimation(
          duration: const Duration(milliseconds: millisecondsAnimation),
          key: key.value,
          children: Icon(
            Icons.favorite,
            color: Colors.red,
            size: 25,
          ),
        ),
        /* SimpleText(
          text: lifes.toString(),
          color: Colors.red,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          padding: EdgeInsets.symmetric(horizontal: 5),
        ), */
        AnimatedSwitcher(
          duration: Duration(milliseconds: millisecondsAnimation),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              child: child,
              position:
                  Tween<Offset>(begin: Offset(0.0, -0.5), end: Offset(0.0, 0.0))
                      .animate(animation),
            );
          },
          child: SimpleText(
            text: lifes.toString(),
            key: key.value,
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            padding: EdgeInsets.symmetric(horizontal: 5),
          ),
        )
      ],
    );
  }
}
