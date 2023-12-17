part of 'pages.dart';

class SendMessageWithSignPage extends HookWidget {
  const SendMessageWithSignPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isSwitched = useState(false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/letter-and-numbers');
        },
        child: Icon(Icons.mic),
      ),
      appBar: AppBar(
        title: Text("Enviar mensaje"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Cambiar vista'),
                Switch(
                  value: isSwitched.value,
                  onChanged: (value) {
                    isSwitched.value = value;
                  },
                ),
              ],
            ),
            Expanded(
              child: isSwitched.value
                  ? SendMessageWithStaticImages()
                  : SendMessageSlider(),
            ),
          ],
        ),
      ),
    );
  }
}

class SendMessageWithStaticImages extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOnlyLettersNumbers = ref.watch(signProviderProvider);
    final currentMessage = ref.watch(currentMessageProvider);
    final currentState = useState(5);
    /* final message = useState("");
    final controller = useTextEditingController()
      ..value = TextEditingValue(text: "Hola"); */
    return Column(
      children: [
        Slider(
          value: currentState.value.toDouble(),
          onChanged: (value) {
            currentState.value = value.toInt();
          },
          min: 1,
          max: 10,
          divisions: 10,
          label: "Velocidad",
        ),
        TextField(
          controller: TextEditingController(text: currentMessage),
          onChanged: (value) {
            ref
                .read(signProviderProvider.notifier)
                .generateListToMessage(value);
            ref.read(currentMessageProvider.notifier).setCurrentMessage(value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Escribe tu texto',
          ),
        ),
        Expanded(
          child: Card(
            child: AlignedGridView.count(
              crossAxisCount: currentState.value,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              itemCount: listOnlyLettersNumbers.length,
              itemBuilder: (context, int index) {
                return SquareCard(sign: listOnlyLettersNumbers[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SendMessageSlider extends HookConsumerWidget {
  const SendMessageSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentPage = useState(0);
    final listOnlyLettersNumbers = ref.watch(signProviderProvider);
    final currentMessage = ref.watch(currentMessageProvider);

    final pageController = usePageController();
    final currentMessagex = useState("");
    final currenSign = useState<Sign?>(null);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleText(
                text: currenSign.value?.type!.name ?? "",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 5),
              SimpleText(
                text: currenSign.value?.letter ?? "",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Container(
            width: 300,
            height: 400,
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: listOnlyLettersNumbers.length,
              itemBuilder: (context, int index) {
                final sign = listOnlyLettersNumbers[index];
                return SvgPicture.asset(
                  sign.pathImage,
                  width: 200,
                  height: 200,
                );
              },
            ),
          ),
          SimpleText(
            text: currentMessage.isEmpty
                ? "Aqui aparecera tu texto"
                : currentMessage,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          TextField(
            /* controller: TextEditingController(text: currentMessage), */
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Escribe tu texto',
            ),
            onChanged: (value) {
              currentMessagex.value = value;
              /* ref
                  .read(signProviderProvider.notifier)
                  .generateListToMessage(value); */
              /* ref
                  .read(currentMessageProvider.notifier)
                  .setCurrentMessage(value); */
            },
          ),
          FilledButton.icon(
              onPressed: () {
                ref
                    .read(signProviderProvider.notifier)
                    .generateListToMessage(currentMessagex.value);

                /* pageController.animateToPage(
                  listOnlyLettersNumbers.length - 1,
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.easeIn,
                ); */

                /* Timer.periodic(Duration(seconds: 5), (Timer timer) {
                  if (_currentPage.value < listOnlyLettersNumbers.length - 1) {
                    _currentPage.value++;
                  } else {
                    _currentPage.value = 0;
                  }

                  pageController.animateToPage(
                    _currentPage.value,
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeIn,
                  );
                }); */

                Timer.periodic(Duration(milliseconds: 1000), (Timer timer) {
                  if (_currentPage.value < listOnlyLettersNumbers.length) {
                    print("current page: ${pageController.page!.toInt()}");
                    currenSign.value = listOnlyLettersNumbers[
                        pageController.page!.toInt() + 1];
                    pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    // Si estás en la última página, vuelve al principio
                    pageController.jumpToPage(0);
                  }
                  timer.cancel();
                });
              },
              icon: Icon(Icons.send),
              label: Text(
                "Enviar mensajes",
              ))
        ],
      ),
    );
  }
}

class SquareCard extends StatelessWidget {
  final Sign sign;

  const SquareCard({super.key, required this.sign});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset(
            sign.pathImage,
            width: 70,
            height: 70,
          ),
          Text(sign.letter),
        ],
      ),
    );
  }
}