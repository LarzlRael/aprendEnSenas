part of 'pages.dart';

/* const timeMiliseconds = 1500; */

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
    final settings = ref.watch(settingsProvider);
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
          Duration(milliseconds: settings.transitionTime.toInt()),
          (Timer timer) {
        if (pageController.page!.toInt() <
            signProviderRef.listSigns.length - 1) {
          isPlaying.value = true;
          pageController.nextPage(
            duration: Duration(milliseconds: settings.transitionTime.toInt()),
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
      signProviderRef.timer = Timer.periodic(
          Duration(milliseconds: settings.transitionTime.toInt()),
          (timer) async {
        isPlaying.value = true;
        ref
            .read(signProviderProvider.notifier)
            .setCurrentSign(signProviderRef.listSigns[_currentIndex.value]);
        _currentIndex.value = _currentIndex.value + 1;

        if (_currentIndex.value == signProviderRef.listSigns.length) {
          stopTimerAnimatedImages();
          /* TODO change this */
          /* ref.read(signProviderProvider.notifier).setCurrentSign(null); */
        }
      });
    }

    final size = MediaQuery.of(context).size;

    return Expanded(
      child: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  CurrentSign(currenSign: signProviderRef.currentSign),
                  Align(
                    alignment: Alignment.center,
                    child: settings.typeDisplay == TypeDisplay.pageView
                        ? Container(
                            width: 300,
                            height: size.height * 0.60,
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
                                    child: ColoredIcon(
                                      icon: sign.iconSign,
                                      size: 250,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: 300,
                            height: 400,
                            child: signProviderRef.listSigns.isEmpty
                                ? const SizedBox()
                                : Expanded(
                                    child: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: Card(
                                          child: Icon(
                                            signProviderRef
                                                .listSigns[_currentIndex.value]
                                                .iconSign,
                                            key: ValueKey<int>(
                                                _currentIndex.value),
                                            /*   width: 200,
                                                          height: 200, */
                                          ),
                                        )),
                                  ),
                          ),
                  ),
                  signProviderRef.listSigns.isEmpty
                      ? const SimpleText(
                          text: "No hay mensaje",
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )
                      : RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              /* color: Colors.black, */
                            ),
                            children: signProviderRef.listSigns.map((e) {
                              if (_currentIndex.value ==
                                  signProviderRef
                                      .listSigns[_currentIndex.value]) {
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
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        /* color: Colors.black, */
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }).toList(),
                          ),
                        ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: TextFieldSendMessage()),
                const SizedBox(width: 2),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: signProviderRef.listSigns.isEmpty
                      ? SpeechButton(
                          onSpeechResult: (res) {
                            ref
                                .read(signProviderProvider.notifier)
                                .setCurrentMessage(res);
                          },
                        )
                      : InkWell(
                          onTap:
                              settings.typeDisplay == TypeDisplay.imageSwitcher
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      if (isPlaying.value) {
                                        stopTimerAnimatedImages();
                                      } else {
                                        startTimerAnimatedImages();
                                      }
                                    }
                                  : () {
                                      FocusScope.of(context).unfocus();
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
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: currenSign?.type!.name.toCapitalize() ?? "",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              /* color: Colors.black, */
            ),
          ),
          const TextSpan(text: " "),
          TextSpan(
            text: currenSign?.letter ?? "",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              /* color: Colors.green, */
            ),
          ),
        ],
      ),

      /* children: [
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
      ], */
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
            ColoredIcon(
              icon: sign.iconSign,
              size: 50,
            ),
            Text(sign.letter),
          ],
        ),
      ),
    );
  }
}
