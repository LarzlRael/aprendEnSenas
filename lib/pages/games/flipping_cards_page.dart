part of '../pages.dart';

const speed = 500;

class SignIndex {
  final int index;
  final String letter;
  SignIndex(this.index, this.letter);
}

class Pair {
  final dynamic left;
  final dynamic right;
  Pair(this.left, this.right);

  @override
  String toString() => 'Pair[$left, $right]';
}

class FlippingCardsPage extends HookWidget {
  const FlippingCardsPage({
    super.key,
    required this.difficulty,
  });
  final Difficulty difficulty;

  @override
  Widget build(BuildContext context) {
    final getFlipCardGameDifficultyState =
        getFlipCardGameDifficulty(difficulty);
    final state = useState<List<Sign>>(generateSignToPair(
      listOnlySingAndNumbers,
      getFlipCardGameDifficultyState.options,
    ));

    final flipsControllersState = useState<List<FlipCardController>>(
        List.generate(state.value.length, (index) => FlipCardController()));

    final flippedElements = useState<List<String>>([]);
    final completedElementsIndex = useState<List<int>>([]);
    final isButtonsDisabled = useState<bool>(false);
    final stateFlipsVerify = useState<List<int>>([]);

    void verifyIsEqual(
      SignIndex signIndex,
      SignIndex signIndex2,
    ) {
      if (signIndex.letter == signIndex2.letter) {
        completedElementsIndex.value.add(signIndex.index);
        completedElementsIndex.value.add(signIndex2.index);
      } else {
        flipsControllersState.value[signIndex.index].toggleCard();
      }
      stateFlipsVerify.value.clear();
    }

    void onButtonPressed() {
      isButtonsDisabled.value = true;

      // Después de 500 ms, habilita nuevamente el botón
      Future.delayed(Duration(milliseconds: speed), () {
        isButtonsDisabled.value = false;
      });
    }

    /* void verifyFlipMatch() {
      if (flippedElements.value.length == 2) {
        if (flippedElements.value[0] == flippedElements.value[1]) {
          // Utils.playCorrectSound(context, correctSound);
          // ...

          flippedElements.value.clear();
          blockedElements.value.clear();
          /* Verify if all flips are disabled */
          if (flipsControllersState.value
              .every((flipState) => !flipState.isEnabled)) {

            // showDialogGameDC(context);
            // AdUtils.checkAdCounter(context);
            // Navigator.of(context).pop();
          }
        } else {
          // Utils.playCorrectSound(context, wrongSound);
          // vibratePhone(context);
          flipsControllersState.value[blockedElements.value[0]].toggleCard();
          flipsControllersState.value[blockedElements.value[1]].toggleCard();
          blockedElements.value.clear();
          flippedElements.value.clear();
        }
      }
    } */

    return Scaffold(
      /* appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              /* Flip index 2 */
              flipsControllersState.value[2].toggleCard();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ), */
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgresLinearTimer(
                durationMiliseconds:
                    getFlipCardGameDifficultyState.duration.inMilliseconds,
                onTimerFinish: () {
                  context.pop();
                },
              ),
              BackIcon(
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              Expanded(
                child: AlignedGridView.count(
                  crossAxisCount: getFlipCardGameDifficultyState.rows,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  itemCount: state.value.length,
                  itemBuilder: (context, int index) {
                    return FlipCard(
                      onFlipDone: (isDone) {
                        print(isDone);
                        if (isDone) {
                          print('isDone');
                          if (stateFlipsVerify.value.contains(index)) {
                            stateFlipsVerify.value.remove(index);
                          } else {
                            stateFlipsVerify.value.add(index);
                          }
                          if (stateFlipsVerify.value.length == 2) {
                            print(stateFlipsVerify.value);
                            print('verificando');
                            /* onButtonPressed(isButtonsDisableds); */
                            /* onButtonPressed(); */
                            verifyIsEqual(
                              SignIndex(
                                stateFlipsVerify.value[0],
                                state.value[stateFlipsVerify.value[0]].letter,
                              ),
                              SignIndex(
                                stateFlipsVerify.value[1],
                                state.value[stateFlipsVerify.value[1]].letter,
                              ),
                            );
                          }
                        }
                      },
                      onFlip: onButtonPressed,
                      flipOnTouch: !isButtonsDisabled.value,
                      controller: flipsControllersState.value[index],
                      speed: speed,
                      front: Card(
                        child: Container(
                          /* color: Colors.blue, */
                          /* padding: EdgeInsets.all(10), */
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Icon(
                              Icons.help_outline_rounded,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      back: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: 100,
                          height: 100,
                          child: SvgPicture.asset(
                            state.value[index]
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
    );
  }
}
