part of '../pages.dart';

class MatchImageGame extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final items = useState<List<ItemModel>>([]);
    final items2 = useState<List<ItemModel>>([]);
    final score = useState<int>(0);
    final gameOver = useState<bool>(false);

    /*   @override
    void initState() {
      super.initState();
      initGame();
    } */

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

    if (items.value.length == 0) gameOver.value = true;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Matching Game'),
        actions: [
          Column(
            children: [
              SimpleText(text: "Puntaje: "),
              SimpleText(
                text: "${score.value}",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            gameOver.value
                ? GameOverThisGame()
                : Row(
                    children: <Widget>[
                      Column(
                          children: items.value.map((item) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Draggable<ItemModel>(
                            data: item,
                            childWhenDragging: Icon(
                              item.icon,
                              color: Colors.grey,
                              size: 50.0,
                            ),
                            feedback: Icon(
                              item.icon,
                              color: Colors.teal,
                              size: 50,
                            ),
                            child: ColoredIcon(
                              icon: item.icon,
                              /* color: Colors.teal, */
                              size: 50,
                            ),
                          ),
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
                            } else {
                              VibrateServiceImp().vibrate(millisec: 250);
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
                                  ? Colors.grey.withOpacity(0.5)
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
                                  color: Colors.grey,
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

class GameOverThisGame extends StatelessWidget {
  const GameOverThisGame({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "GameOver",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        Center(
          child: TextButton(
            /* textColor: Colors.white,
        color: Colors.pink, */
            child: Text("New Game"),
            onPressed: () {
              /* initGame(); */
            },
          ),
        )
      ],
    );
  }
}
