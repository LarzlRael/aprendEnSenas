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
    final currentMessage = ref.watch(signProviderProvider);
    final currentSliderState = useState(5);
    useEffect(() {
      listOnlyLettersNumbers.value = generateListToMessageUtil(
        listOnlySingAndNumbers,
        currentMessage.currentMessage,
      );
      return null;
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
    /* final listOnlyLettersNumbers = useState<List<Sign>>(listOnlySingAndNumbers); */
    final signProviderRef = ref.watch(signProviderProvider);
    final isPlaying = useState(false);

    final pageController = usePageController();

    final _currentIndex = useState<int>(0);

    pageController.addListener(() {
      if (pageController.page!.toInt() < signProviderRef.listSigns.length) {
        /* currenSign.value =
            signProviderRef.listSigns[pageController.page!.toInt()]; */
        ref.read(signProviderProvider.notifier).setCurrentSign(
            signProviderRef.listSigns[pageController.page!.toInt()]);
      }
    });

    useEffect(() {
      signProviderRef.listSigns = generateListToMessageUtil(
        listOnlySingAndNumbers,
        signProviderRef.currentMessage,
      );
      /* return pageController.dispose; */
    }, [signProviderRef]);

    startMessage() async {
      ref
          .read(signProviderProvider.notifier)
          .setCurrentMessage(signProviderRef.currentMessage);

      /* print("listOnlyLettersNumbers: ${listOnlyLettersNumbers.value}"); */
      pageController.jumpToPage(0);

      signProviderRef.timer = Timer.periodic(
          Duration(milliseconds: timeMiliseconds), (Timer timer) {
        if (pageController.page!.toInt() <
            signProviderRef.listSigns.length - 1) {
          isPlaying.value = true;
          pageController.nextPage(
            duration: Duration(milliseconds: timeMiliseconds),
            curve: Curves.easeInOut,
          );
        } else {
          // Si estás en la última página, vuelve al principio
          timer.cancel();
          signProviderRef.timer?.cancel();

          pageController.jumpToPage(0);
          isPlaying.value = false;
        }
      });
    }

    void stopTimerAnimatedImages() {
      isPlaying.value = false;
      signProviderRef.timer?.cancel();
      _currentIndex.value = 0;
      ref
          .read(signProviderProvider.notifier)
          .setCurrentSign(signProviderRef.listSigns[_currentIndex.value]);
    }

    void startTimerAnimatedImages() {
      signProviderRef.timer =
          Timer.periodic(const Duration(seconds: 1), (timer) async {
        isPlaying.value = true;
        ref
            .read(signProviderProvider.notifier)
            .setCurrentSign(signProviderRef.listSigns[_currentIndex.value]);
        _currentIndex.value = _currentIndex.value + 1;

        if (_currentIndex.value == signProviderRef.listSigns.length) {
          stopTimerAnimatedImages();
        }
      });
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CurrentSign(currenSign: signProviderRef.currentSign),
          settings.typeDisplay == TypeDisplay.pageView
              ? Column(
                  children: [
                    Container(
                      width: 300,
                      height: 400,
                      child: PageView.builder(
                        controller: pageController,
                        scrollDirection: settings.sliderDirection,
                        itemCount: signProviderRef.listSigns.length,
                        itemBuilder: (context, int index) {
                          final sign = signProviderRef.listSigns[index];
                          return InkWell(
                            onTap: () => context.push(
                                '/letter-and-numbers/detail',
                                extra: sign),
                            child: SvgPicture.asset(
                              sign.pathImage,
                              width: 200,
                              height: 200,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Container(
                  width: 300,
                  height: 400,
                  child: signProviderRef.listSigns.isEmpty
                      ? const SizedBox()
                      : Expanded(
                          child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: Card(
                                child: SvgPicture.asset(
                                  signProviderRef
                                      .listSigns[_currentIndex.value].pathImage,
                                  key: ValueKey<int>(_currentIndex.value),
                                  /*   width: 200,
                                                height: 200, */
                                ),
                              )),
                        ),
                ),
          SimpleText(
            text: signProviderRef.currentMessage,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                child: TextFieldSendMessage(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: "Escribe tu mensaje",
                  ),
                ),
              )),
              const SizedBox(width: 3),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: IconButton(
                  onPressed: isPlaying.value
                      ? () {
                          pageController.jumpToPage(0);
                          isPlaying.value = false;
                        }
                      : settings.typeDisplay == TypeDisplay.pageView
                          ? startMessage
                          : startTimerAnimatedImages,
                  icon: Icon(
                    isPlaying.value ? Icons.pause : Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CurrentSign extends StatelessWidget {
  const CurrentSign({
    super.key,
    required this.currenSign,
  });

  final Sign? currenSign;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SimpleText(
          text: currenSign?.type!.name ?? "",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(width: 5),
        SimpleText(
          text: currenSign?.letter ?? "",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ],
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
  final InputDecoration? decoration;
  TextFieldSendMessage({super.key, this.decoration});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController()
      ..value = TextEditingValue(
          text: ref.watch(signProviderProvider).currentMessage);

    return TextField(
      controller: controller,
      decoration: decoration ??
          InputDecoration(
            hintText: "Escribe tu mensaje",
            border: OutlineInputBorder(),
          ),
      onChanged: (val) {
        ref
            .read(
              signProviderProvider.notifier,
            )
            .setCurrentMessage(val);
      },
    );
  }
}
