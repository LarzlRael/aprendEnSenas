/* import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/model/data.dart';
import 'package:flutter_memory_game/views/game_over_screen.dart'; */

part of '../pages.dart';

/* class MyFlipCardGame extends StatefulWidget {
  const MyFlipCardGame({super.key, required this.difficulty});
  final Difficulty difficulty;

  @override
  State<MyFlipCardGame> createState() => _MyFlipCardGameState();
} */

class MyFlipCardGame extends HookWidget {
  final Difficulty difficulty;

  MyFlipCardGame({required this.difficulty});
  /* 
  int _previousIndex = -1;
  int _time = 3;
  int gameDuration = -3;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;
  late bool _isFinished;
  late Timer _timer;
  late Timer _durationTimer;
  late int _left;
  late List<Sign> _data;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;
  late FlipCardGame diff;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _time = (_time - 1);
      });
    });
  }

  void startDuration() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        gameDuration = (gameDuration + 1);
      });
    });
  }

  void startGameAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  final amountOfImages = 3;
  void initializeGameData() {
    diff = getFlipCardGameDifficulty(widget.difficulty);
    _data = createShuffledListFromImageSource(diff.options);
    _cardFlips = getInitialItemStateList((diff.options * 2));
    _cardStateKeys = createFlipCardStateKeysList((diff.options * 2));
    _time = 3;
    _left = (_data.length ~/ 2);
    _isFinished = false;
  }

  @override
  void initState() {
    startTimer();
    startDuration();
    startGameAfterDelay();
    initializeGameData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _durationTimer.cancel();
  } */

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

    final _cardStateKeys = useState<List<GlobalKey<FlipCardState>>>([]);
    final diff = useState<FlipCardGame?>(null);
    Widget getItem(int index) {
      return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: SvgPicture.asset(
            _data.value[index].pathImage,
            fit: BoxFit.cover,
          ));
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
      diff.value = getFlipCardGameDifficulty(difficulty);
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
            duration: gameDuration.value,
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Remaining: ${_left.value}',
                            style: theme.bodyMedium,
                          ),
                          Text(
                            'Duration: ${gameDuration.value}s',
                            style: theme.bodyMedium,
                          ),
                          Text(
                            'Countdown: ${_time.value}',
                            style: theme.bodyMedium,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AlignedGridView.count(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => _start.value
                          ? FlipCard(
                              key: _cardStateKeys.value[index],
                              onFlip: () {
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
                                          const Duration(milliseconds: 1500),
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
                                      }
                                    }
                                  }
                                }
                              },
                              flipOnTouch:
                                  _wait.value ? false : _cardFlips.value[index],
                              direction: FlipDirection.HORIZONTAL,
                              front: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  /* color: Colors.blue, */
                                  /* image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/image_cover.jpg",
                                    ),
                                  ), */
                                ),
                                margin: const EdgeInsets.all(4.0),
                                child:
                                    Center(child: Icon(Icons.help, size: 75)),
                              ),
                              back: getItem(index))
                          : getItem(index),
                      itemCount: _data.value.length,
                      crossAxisCount: diff.value!.rows,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
