part of '../pages.dart';

const sizeWidth = 100.0;
const sizeHeight = 125.0;
const border = 5.0;
final decorationBorder = BoxDecoration(
  borderRadius: BorderRadius.circular(border),
  border: Border.all(
    color: Colors.black,
    width: 2.0,
  ),
);
final style = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
);

class FlippingCardGame extends HookWidget {
  final Level level;

  FlippingCardGame({required this.level});

  @override
  Widget build(BuildContext context) {
    final _previousIndex = useState(-1);
    final _time = useState(3);
    final gameDuration = useState(-3);
    final _flip = useState(false);
    final _start = useState(false);
    final _wait = useState(false);
    final _isFinished = useState<bool>(false);
    final _timer = useState<Timer?>(null);
    final _durationTimer = useState<Timer?>(null);

    final _left = useState(0);

    final _data = useState<List<Sign>>([]);

    final _cardFlips = useState<List<bool>>([]);
    final getRecord = useFuture(
      getGameScore(GameType.volteo_de_cartas, level),
    );
    final _cardStateKeys = useState<List<GlobalKey<FlipCardState>>>([]);
    final diff = useState<FlipCardGame?>(null);
    Widget getItem(int index) {
      return Container(
        padding: const EdgeInsets.all(4.0),
        width: sizeWidth,
        height: sizeHeight,
        decoration: decorationBorder,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(border),
                child: ColoredIcon(
                  icon: _data.value[index].iconSign,
                  size: 60,
                  /* width: sizeWidth - 35,
                  height: sizeHeight - 35, */
                ),
              ),
            ),
            SimpleText(
              text: _data.value[index].letter,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    void startTimer() {
      _timer.value = Timer.periodic(const Duration(seconds: 1), (t) {
        _time.value = (_time.value - 1);
      });
    }

    void startDuration() {
      _durationTimer.value = Timer.periodic(const Duration(seconds: 1), (t) {
        gameDuration.value = (gameDuration.value + 1);
      });
    }

    void startGameAfterDelay() {
      Future.delayed(const Duration(seconds: 3), () {
        _start.value = true;
        _timer.value?.cancel();
      });
    }

    void initializeGameData() {
      diff.value = getFlipCardGameLevel(level);
      _data.value = createShuffledListFromImageSource(diff.value!.options);
      _cardFlips.value = getInitialItemStateList((diff.value!.options * 2));
      _cardStateKeys.value =
          createFlipCardStateKeysList((diff.value!.options * 2));
      _time.value = 3;
      _left.value = (_data.value.length ~/ 2);
      _isFinished.value = false;
    }

    useEffect(() {
      startTimer();
      startDuration();
      startGameAfterDelay();
      initializeGameData();
      return () {
        _timer.value?.cancel();
        _durationTimer.value?.cancel();
      };
    }, []);
    final theme = Theme.of(context).textTheme;
    return _isFinished.value
        ? GameOverScreen(
            level: level,
            title: Text("¡Ganaste!"),
            subtitle: Text("¡Has completado el nivel ${level.name}!"),
            titleButton: "Ir al siguiente nivel",
            action: () => context.push(
              '/games/flipping_cards_page',
              extra: getNextLevel(level),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Flipping Cards',
              ),
              /* centerTitle: true, */
              leading: BackIcon(size: 20),
              actions: [
                TextSpanHit(
                  text: 'Record: ',
                  score: getRecord.data ?? 0,
                )
              ],
            ),
            body: SafeArea(
              child: Container(
                /* color: Colors.blue, */
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: double.infinity,
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Text(
                              'Remaining: ${_left.value}',
                              style: style,
                            ),
                            SimpleText(
                              text: 'Duration: ${gameDuration.value}s',
                              style: style,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            _time.value == 0
                                ? const SizedBox()
                                : Text(
                                    'Countdown: ${_time.value}',
                                    style: style,
                                  )
                          ],
                        ),
                      ),
                      AlignedGridView.count(
                        shrinkWrap: true,
                        itemCount: _data.value.length,
                        crossAxisCount: diff.value!.rows,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => _start.value
                            ? FlipCard(
                                key: _cardStateKeys.value[index],
                                onFlip: () async {
                                  if (!_flip.value) {
                                    _flip.value = true;
                                    _previousIndex.value = index;
                                  } else {
                                    _flip.value = false;
                                    if (_previousIndex.value != index) {
                                      if (_data.value[_previousIndex.value] !=
                                          _data.value[index]) {
                                        _wait.value = true;

                                        Future.delayed(
                                            const Duration(milliseconds: 1250),
                                            () {
                                          _cardStateKeys
                                              .value[_previousIndex.value]
                                              .currentState!
                                              .toggleCard();
                                          _previousIndex.value = index;
                                          _cardStateKeys
                                              .value[_previousIndex.value]
                                              .currentState!
                                              .toggleCard();

                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            _wait.value = false;
                                          });
                                        });
                                      } else {
                                        _cardFlips.value[_previousIndex.value] =
                                            false;
                                        _cardFlips.value[index] = false;
                                        debugPrint("$_cardFlips");
                                        _left.value -= 1;

                                        if (_cardFlips.value
                                            .every((t) => t == false)) {
                                          debugPrint("Won");
                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            _isFinished.value = true;
                                            _start.value = false;

                                            _durationTimer.value?.cancel();
                                          });
                                          await saveGameScore(
                                            GameType.volteo_de_cartas,
                                            gameDuration.value,
                                            level,
                                          );
                                        }
                                      }
                                    }
                                  }
                                },
                                flipOnTouch: _wait.value
                                    ? false
                                    : _cardFlips.value[index],
                                direction: FlipDirection.HORIZONTAL,
                                front: Container(
                                  width: sizeWidth,
                                  height: sizeHeight,
                                  decoration: decorationBorder,
                                  /* margin: const EdgeInsets.all(4.0), */
                                  child: Center(
                                    child: Icon(
                                      Icons.help_outline,
                                      size: 60,
                                    ),
                                  ),
                                ),
                                back: getItem(index),
                              )
                            : getItem(index),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
