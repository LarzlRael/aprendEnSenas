part of '../pages.dart';

class MatchImageGame extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final items = useState<List<ItemModel>>([]);
    final items2 = useState<List<ItemModel>>([]);
    final score = useState<int>(0);
    final gameOver = useState<bool>(false);
    final settingsNotifier = ref.watch(settingsProvider.notifier);
    final interstiatAdProviderN = ref.watch(interstiatAdProvider.notifier);
    initGame() {
      gameOver.value = false;
      score.value = 0;
      items.value = getNelemets(5);
      items2.value = [...items.value];
      items.value.shuffle();
      items2.value.shuffle();
    }

    useEffect(() {
      initGame();
    }, []);
    /* Future<void> saveRecord() async {
      await saveGameScore(GameType.arrastra_y_suelta, score.value, Level.easy);
    }

    */

    useEffect(() {
      if (gameOver.value) {
        addCounterIntersitialAd(() => interstiatAdProviderN.showAd());
      }
    }, [gameOver.value]);
    if (items.value.length == 0) gameOver.value = true;
    return Scaffold(
      appBar: AppBar(
        leading: BackIcon(),
        centerTitle: true,
        title: Text('Arrastra y suelta'),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                SimpleText(text: "Puntaje"),
                SimpleText(
                  text: "${score.value}",
                  style: TextStyle(
                    color: score.value > 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            gameOver.value
                ? Container(
                    width: double.infinity,
                    height: 600,
                    child: ResultScreen(
                      resultType: score.value > 0
                          ? ResultGameType.win
                          : ResultGameType.lose,
                      loseSubtitle:
                          'El puntaje es menor a 0, vuelve a intentarlo',
                      loseTitle: 'Perdiste',
                      winSubtitle:
                          '¡Felicidades! tu puntaje es de ${score.value}',
                      winTitle: '¡Ganaste!',
                      callBackOnLose: initGame,
                      callBackOnWin: initGame,
                    ),
                  )
                : Row(
                    children: [
                      Column(
                          children: items.value.map((item) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Draggable<ItemModel>(
                              data: item,
                              childWhenDragging: ClipRRect(
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      'assets/icons/app_logo.png'),
                                  image: AssetImage(item.pathAssetImage),
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              feedback: Image.asset(
                                opacity: const AlwaysStoppedAnimation(.9),
                                item.pathAssetImage,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                              child: Image.asset(
                                item.pathAssetImage,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              )),
                        );
                      }).toList()),
                      Spacer(),
                      Column(
                          children: items2.value.map((item) {
                        return DragTarget<ItemModel>(
                          onAccept: (receivedItem) {
                            if (item.value == receivedItem.value) {
                              items.value.remove(receivedItem);
                              items2.value.remove(item);
                              score.value += 10;
                              item.accepting = false;
                              settingsNotifier.playSound(correctsSounds[2]);
                            } else {
                              settingsNotifier.startVibrate();
                              score.value -= 5;
                              item.accepting = false;
                            }
                          },
                          onLeave: (receivedItem) {
                            item.accepting = false;
                          },
                          onWillAccept: (receivedItem) {
                            item.accepting = true;
                            return true;
                          },
                          builder: (context, acceptedItems, rejectedItem) =>
                              Container(
                            decoration: BoxDecoration(
                              color: item.accepting != null
                                  ? Colors.grey.withOpacity(0.2)
                                  : Colors.teal,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            /* height: 50,
                        width: 150, */
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: generateListToMessageUtil(listAllSign,
                                      item.name.removeDiacriticsFromString())
                                  .map((e) {
                                return Icon(
                                  e.iconSign,
                                  /* color: Colors.grey, */
                                  size: 30,
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }).toList()),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
