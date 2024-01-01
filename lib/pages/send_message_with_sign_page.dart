part of 'pages.dart';

const timeMiliseconds = 1500;

class SendMessageWithSignPage extends HookWidget {
  const SendMessageWithSignPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isSwitched = useState(false);

    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/letter-and-numbers'),
        child: Icon(Icons.mic),
      ), */
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
        /* margin: EdgeInsets.symmetric(horizontal: 15), */
        /* width: double.infinity,
        height: double.infinity, */
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
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Expanded(child: TextFieldSendMessage()),
              const SizedBox(width: 2),
              FloatingActionButton(
                shape: CircleBorder(),
                onPressed: () {},
                child: Icon(Icons.mic, color: Colors.black),
              ),
            ],
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
    final signProviderRef = ref.watch(signProviderProvider);
    final isPlaying = useState(false);

    final pageController = usePageController();
    final _currentIndex = useState<int>(0);

    pageController.addListener(() {
      if (pageController.page!.toInt() < signProviderRef.listSigns.length) {
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
      child: Container(
        /* width: double.infinity,
        height: double.infinity, */
        color: Colors.grey[200],
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
                                        .listSigns[_currentIndex.value]
                                        .pathImage,
                                    key: ValueKey<int>(_currentIndex.value),
                                    /*   width: 200,
                                                  height: 200, */
                                  ),
                                )),
                          ),
                  ),
            signProviderRef.listSigns.isEmpty
                ? const SimpleText(text: "No hay mensaje")
                : RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: signProviderRef.listSigns.map((e) {
                        if (_currentIndex.value ==
                            signProviderRef.listSigns[_currentIndex.value]) {
                          return TextSpan(
                              text: e.letter,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ));
                        } else {
                          return WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0.0, 0.0),
                              child: Text(
                                e.letter,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      }).toList(),
                    ),
                  ),
            Row(
              children: [
                Expanded(child: TextFieldSendMessage()),
                const SizedBox(width: 2),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: signProviderRef.listSigns.isEmpty
                      ? const FloatingActionButton(
                          shape: CircleBorder(),
                          /* TODO mic state */
                          onPressed: null,
                          child: Icon(
                            Icons.mic,
                            color: Colors.black,
                          ),
                        )
                      : AnimatedPlayButton(
                          isPlaying: isPlaying.value,
                          onTap: (controller) {
                            if (isPlaying.value) {
                              controller.reverse();
                              isPlaying.value = false;
                            } else {
                              controller.forward();
                              isPlaying.value = true;
                            }
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
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
  TextFieldSendMessage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController()
      ..value = TextEditingValue(
          text: ref.watch(signProviderProvider).currentMessage);

    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          /* filled: true,
                        fillColor: Colors.black, */
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          hintText: "Escribe tu mensaje",
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
        ),
        onChanged: (val) {
          ref
              .read(
                signProviderProvider.notifier,
              )
              .setCurrentMessage(val);
        },
      ),
    );
  }
}
