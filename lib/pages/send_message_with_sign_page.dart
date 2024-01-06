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
            icon: Icon(
              Icons.games,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () => context.push('/settings_page'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        /* margin: EdgeInsets.symmetric(horizontal: 15), */
        width: double.infinity,
        height: double.infinity,
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
            isSwitched.value
                ? SendMessageWithStaticImages()
                : SendMessageSlider(),
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

    return Expanded(
      child: Column(
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
                itemBuilder: (_, index) => SquareCard(
                  sign: listOnlyLettersNumbers.value[index],
                  onTap: (sign) => context.push(
                    '/letter_and_numbers/detail/${sign.letter}',
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(child: TextFieldSendMessage()),
                const SizedBox(width: 2),
                SpeechButton(
                  onSpeechResult: (res) {
                    print("res: $res");
                    ref
                        .read(signProviderProvider.notifier)
                        .setCurrentMessage(res);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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

    startPageViewMessage() {
      ref
          .read(signProviderProvider.notifier)
          .setCurrentMessage(signProviderRef.currentMessage);

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

    final size = MediaQuery.of(context).size;

    return Expanded(
      child: SingleChildScrollView(
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
                          height: size.height * 0.63,
                          child: PageView.builder(
                            controller: pageController,
                            scrollDirection: settings.sliderDirection,
                            itemCount: signProviderRef.listSigns.length,
                            itemBuilder: (context, int index) {
                              final sign = signProviderRef.listSigns[index];
                              return InkWell(
                                onTap: () => context.push(
                                    '/letter_and_numbers/detail/${sign.letter}'),
                                child: Card(
                                  child: Icon(
                                    sign.iconSign,
                                    size: 100,
                                  ),
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
                                    child: Icon(
                                      signProviderRef
                                          .listSigns[_currentIndex.value]
                                          .iconSign,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: TextFieldSendMessage()),
                  const SizedBox(width: 2),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: signProviderRef.listSigns.isEmpty
                        ? SpeechButton(
                            onSpeechResult: (res) {
                              print("res: $res");
                              ref
                                  .read(signProviderProvider.notifier)
                                  .setCurrentMessage(res);
                            },
                          )
                        : InkWell(
                            onTap: settings.typeDisplay ==
                                    TypeDisplay.imageSwitcher
                                ? () {
                                    if (isPlaying.value) {
                                      stopTimerAnimatedImages();
                                    } else {
                                      startTimerAnimatedImages();
                                    }
                                  }
                                : () {
                                    if (isPlaying.value) {
                                      signProviderRef.timer?.cancel();
                                      isPlaying.value = false;
                                    } else {
                                      startPageViewMessage();
                                    }
                                  },
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Icon(
                                  isPlaying.value ? Icons.pause : Icons.send,
                                  size: 25.0,
                                  color: Colors.white,
                                  semanticLabel: 'Show menu',
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
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
  final Function(Sign sign)? onTap;
  const SquareCard({super.key, required this.sign, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(sign);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Column(
          children: [
            Icon(
              sign.iconSign,
              size: 50,
            ),
            Text(sign.letter),
          ],
        ),
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
      /* height: 45, */
      child: TextField(
        minLines: 1,
        maxLines: 2,
        controller: controller,
        decoration: InputDecoration(
          /* isDense: true, // Added this
          contentPadding: EdgeInsets.all(8), */
          suffix: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity:
                ref.watch(signProviderProvider).currentMessage.isEmpty ? 0 : 1,
            child: IconButton(
              color: Colors.grey,
              onPressed: () {
                controller.clear();
                ref.read(signProviderProvider.notifier).setCurrentMessage("");
              },
              icon: Icon(Icons.cancel),
            ),
          ),
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
