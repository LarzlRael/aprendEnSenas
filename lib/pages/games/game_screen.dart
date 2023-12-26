/* import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/model/data.dart';
import 'package:flutter_memory_game/views/game_over_screen.dart'; */

part of '../pages.dart';

class MyFlipCardGame extends StatefulWidget {
  const MyFlipCardGame({super.key, required this.difficulty});
  final Difficulty difficulty;

  @override
  State<MyFlipCardGame> createState() => _MyFlipCardGameState();
}

class _MyFlipCardGameState extends State<MyFlipCardGame> {
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
  }

  Widget getItem(int index) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: SvgPicture.asset(
          _data[index].pathImage,
          fit: BoxFit.cover,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return _isFinished
        ? GameOverScreen(
            duration: gameDuration,
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
                            'Remaining: $_left',
                            style: theme.bodyMedium,
                          ),
                          Text(
                            'Duration: ${gameDuration}s',
                            style: theme.bodyMedium,
                          ),
                          Text(
                            'Countdown: $_time',
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
                      itemBuilder: (context, index) => _start
                          ? FlipCard(
                              key: _cardStateKeys[index],
                              onFlip: () {
                                if (!_flip) {
                                  _flip = true;
                                  _previousIndex = index;
                                } else {
                                  _flip = false;
                                  if (_previousIndex != index) {
                                    if (_data[_previousIndex] != _data[index]) {
                                      _wait = true;

                                      Future.delayed(
                                          const Duration(milliseconds: 1500),
                                          () {
                                        _cardStateKeys[_previousIndex]
                                            .currentState!
                                            .toggleCard();
                                        _previousIndex = index;
                                        _cardStateKeys[_previousIndex]
                                            .currentState!
                                            .toggleCard();

                                        Future.delayed(
                                            const Duration(milliseconds: 160),
                                            () {
                                          setState(() {
                                            _wait = false;
                                          });
                                        });
                                      });
                                    } else {
                                      _cardFlips[_previousIndex] = false;
                                      _cardFlips[index] = false;
                                      debugPrint("$_cardFlips");
                                      setState(() {
                                        _left -= 1;
                                      });
                                      if (_cardFlips.every((t) => t == false)) {
                                        debugPrint("Won");
                                        Future.delayed(
                                            const Duration(milliseconds: 160),
                                            () {
                                          setState(() {
                                            _isFinished = true;
                                            _start = false;
                                          });
                                          _durationTimer.cancel();
                                        });
                                      }
                                    }
                                  }
                                }
                                setState(() {});
                              },
                              flipOnTouch: _wait ? false : _cardFlips[index],
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
                      itemCount: _data.length,
                      crossAxisCount: diff.rows,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
