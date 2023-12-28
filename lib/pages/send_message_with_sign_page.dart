part of 'pages.dart';

const timeMiliseconds = 1500;

class SendMessageWithSignPage extends HookWidget {
  const SendMessageWithSignPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isSwitched = useState(false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/letter-and-numbers'),
        child: Icon(Icons.mic),
      ),
      appBar: AppBar(
        title: Text("Enviar mensaje"),
        actions: [
          IconButton(
            onPressed: () => context.push('/select_game_menu_page'),
            icon: Icon(Icons.mic),
          ),
          IconButton(
            onPressed: () => context.push('/settings_page'),
            icon: Icon(Icons.settings),
          ),
        ],
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
    final listOnlyLettersNumbers = useState<List<Sign>>([]);
    final currentMessage = ref.watch(currentMessageProvider);
    final currentSliderState = useState(5);
    useEffect(() {
      listOnlyLettersNumbers.value = generateListToMessage(
        listOnlySingAndNumbers,
        currentMessage,
      );
    }, [currentMessage]);

    return Column(
      children: [
        Slider(
          value: currentSliderState.value.toDouble(),
          onChanged: (value) {
            currentSliderState.value = value.toInt();
          },
          min: 1,
          max: 10,
          divisions: 10,
          label: "Velocidad",
        ),
        TextFieldSendMessage(),
        /* TextFieldSendMessage((value) {
          message.value = value;
          /* Fix this */
          /* ref.read(signProviderProvider.notifier).generateListToMessage(value);
          ref.read(currentMessageProvider.notifier).setCurrentMessage(value); */
        }), */
        Expanded(
          child: Card(
            child: AlignedGridView.count(
              crossAxisCount: currentSliderState.value,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              itemCount: listOnlyLettersNumbers.value.length,
              itemBuilder: (context, int index) {
                return SquareCard(sign: listOnlyLettersNumbers.value[index]);
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
    final settings = ref.watch(settingsProviderProvider);
    final listOnlyLettersNumbers = useState<List<Sign>>(listOnlySingAndNumbers);
    final currentMessage = ref.watch(currentMessageProvider);
    final isPlaying = useState(false);

    final currenSign = useState<Sign?>(null);

    final pageController = usePageController();
    pageController.addListener(() {
      if (pageController.page!.toInt() < listOnlyLettersNumbers.value.length) {
        currenSign.value =
            listOnlyLettersNumbers.value[pageController.page!.toInt()];
      }
    });

    useEffect(() {
      /* ref
          .read(signProviderProvider.notifier)
          .generateListToMessage(currentMessagex.value);
      ref
          .read(currentMessageProvider.notifier)
          .setCurrentMessage(currentMessagex.value); */
      listOnlyLettersNumbers.value = generateListToMessage(
        listOnlySingAndNumbers,
        currentMessage,
      );
      /* return pageController.dispose; */
    }, [currentMessage]);

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
              scrollDirection: settings.sliderDirection,
              itemCount: listOnlyLettersNumbers.value.length,
              itemBuilder: (context, int index) {
                final sign = listOnlyLettersNumbers.value[index];
                return InkWell(
                  onTap: () =>
                      context.push('/letter-and-numbers/detail', extra: sign),
                  child: SvgPicture.asset(
                    sign.pathImage,
                    width: 200,
                    height: 200,
                  ),
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
          TextFieldSendMessage(),
          isPlaying.value
              ? FilledButton.icon(
                  onPressed: () {
                    pageController.jumpToPage(0);
                    isPlaying.value = false;
                  },
                  icon: Icon(Icons.pause),
                  label: Text(
                    "Cancelar",
                  ))
              : FilledButton.icon(
                  onPressed: () {
                    ref
                        .read(currentMessageProvider.notifier)
                        .setCurrentMessage(currentMessage);

                    print(
                        "listOnlyLettersNumbers: ${listOnlyLettersNumbers.value}");
                    pageController.jumpToPage(0);

                    Timer.periodic(Duration(milliseconds: timeMiliseconds),
                        (Timer timer) {
                      if (pageController.page!.toInt() <
                          listOnlyLettersNumbers.value.length - 1) {
                        isPlaying.value = true;
                        pageController.nextPage(
                          duration: Duration(milliseconds: timeMiliseconds),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Si estás en la última página, vuelve al principio
                        timer.cancel();
                        pageController.jumpToPage(0);
                        isPlaying.value = false;
                      }
                    });
                  },
                  icon: Icon(Icons.send),
                  label: Text(
                    "Enviar mensaje",
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

class TextFieldSendMessage extends HookConsumerWidget {
  /* final Function(String value) onChanged; */

  TextFieldSendMessage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController()
      ..value = TextEditingValue(text: ref.watch(currentMessageProvider));

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Escribe tu texto',
      ),
      onChanged: (val) {
        ref.read(currentMessageProvider.notifier).setCurrentMessage(val);
      },
    );
  }
}
