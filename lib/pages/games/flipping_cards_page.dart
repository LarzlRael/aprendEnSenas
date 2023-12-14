part of '../pages.dart';

class FlippingCardsPage extends HookWidget {
  const FlippingCardsPage({
    super.key,
    this.difficulty = Difficulty.easy,
  });
  final Difficulty difficulty;

  void verifyIsEqual(List<Sign> list, int index, int index2) {
    if (list[index].letter == list[index2].letter) {
      print('son iguales');
    } else {
      print('no son iguales');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state =
        useState<List<Sign>>(generateSignToPair(listOnlySingAndNumbers, 4));

    final flipsControllersState = useState<List<FlipCardController>>(
        List.generate(state.value.length, (index) => FlipCardController()));

    final flippedElements = useState<List<String>>([]);
    final blockedElements = useState<List<String>>([]);

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
                durationMiliseconds: 10000,
                onTimerFinish: () {
                  print('timer finish');
                },
              ),
              BackIcon(
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              Expanded(
                child: AlignedGridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  itemCount: state.value.length,
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        /* if (onTap != null) {
              onTap!(letterWithSignArray[index]);
            } */
                      },
                      child: FlipCard(
                        flipOnTouch: true,
                        controller: flipsControllersState.value[index],
                        /* controller: FlipController(), */
                        front: Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.help_outline_rounded,
                              size: 50,
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
