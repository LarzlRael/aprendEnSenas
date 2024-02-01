part of 'pages.dart';

/* const timeMiliseconds = 1500; */

class SendMessageWithSignPage extends HookConsumerWidget {
  final String? phrase;
  const SendMessageWithSignPage({super.key, this.phrase});
  static const routeName = '/send_message_with_sign_page';
  @override
  Widget build(BuildContext context, ref) {
    final settingsN = ref.read(settingsProvider.notifier);
    final settingsS = ref.watch(settingsProvider);

    final signProviderN = ref.read(signProviderProvider.notifier);
    final signProviderS = ref.watch(signProviderProvider);

    useEffect(() {
      Future.delayed(Duration.zero, () {
        signProviderN.setCurrentMessage(phrase ?? '');
      });
    }, []);
    useEffect(() {
      ref.read(interstiatAdProvider.notifier).loadAd();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text("Enviar mensaje"),
        actions: [
          if (signProviderS.currentMessage.isNotEmpty)
            IconButton(
              onPressed: () => ShareServiceImp().shareOnlyText(
                shareString(HomePage.routeName, signProviderS.currentMessage),
              ),
              icon: Icon(Icons.share),
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
            CheckboxLabel(
              label: 'Cambiar vista',
              value: settingsS.isMainDisplayInPageView,
              onChanged: (value) async {
                await settingsN.toggleMainDisplayInPageView();
              },
            ),
            settingsS.isMainDisplayInPageView
                ? SendMessageWithStaticImages(pharse: phrase)
                : SendMessageSlider(pharse: phrase),
          ],
        ),
      ),
    );
  }
}

class SendMessageWithStaticImages extends HookConsumerWidget {
  final String? pharse;

  SendMessageWithStaticImages({super.key, this.pharse});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOnlyLettersNumbers = useState<List<Sign>>([]);
    final signProviderS = ref.watch(signProviderProvider);
    final signProviderN = ref.read(signProviderProvider.notifier);
    final currentSliderState = useState(5);
    final currentSize = useState(50.0);
    useEffect(() {
      currentSize.value = 250 / currentSliderState.value;
    }, [currentSliderState.value]);
    useEffect(() {
      listOnlyLettersNumbers.value = generateListToMessageUtil(
        listOnlySingAndNumbers,
        signProviderS.currentMessage,
      );
      return null;
    }, [signProviderS]);

    return Expanded(
      child: Column(
        children: [
          if (signProviderS.currentMessage.isNotEmpty)
            Slider(
              value: currentSliderState.value.toDouble(),
              onChanged: (value) {
                currentSliderState.value = value.toInt();
              },
              min: 1,
              max: 10,
              divisions: 10,
            ),
          Expanded(
            child: signProviderS.currentMessage.isEmpty
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: NoInformationCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      title: "No hay mensajes todavía...",
                      description: "Puedes escribir o usar el micrófono",
                    ),
                  )
                : Card(
                    child: AlignedGridView.count(
                      crossAxisCount: currentSliderState.value,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      itemCount: listOnlyLettersNumbers.value.length,
                      itemBuilder: (_, index) => SquareCard(
                        iconSize: currentSize.value,
                        sign: listOnlyLettersNumbers.value[index],
                        onTap: (sign) => context.push(
                          '${LetterAndNumbersPage.routeName}/${sign.letter}',
                        ),
                      ),
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(
                    child: TextFieldSendMessage(
                  onTextChange: signProviderN.setCurrentMessage,
                  initialValue: signProviderS.currentMessage,
                  onClear: (controller) {
                    controller.clear();
                    signProviderN.setCurrentMessage('');
                  },
                )),
                const SizedBox(width: 2),
                SpeechButton(
                  onSpeechResult: (res) {
                    signProviderN.setCurrentMessage(res);
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
  final String? pharse;
  const SendMessageSlider({
    super.key,
    this.pharse,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final signProviderS = ref.watch(signProviderProvider);
    final signProviderN = ref.read(signProviderProvider.notifier);
    final isPlaying = useState(false);

    final pageController = usePageController();
    final _currentIndex = useState<int>(0);

    final interstialAdProviderN = ref.read(interstiatAdProvider.notifier);

    pageController.addListener(() {
      if (pageController.page!.toInt() < signProviderS.listSigns.length) {
        _currentIndex.value = pageController.page!.toInt();
        signProviderN.setCurrentSign(
            signProviderS.listSigns[pageController.page!.toInt()]);
      }
    });

    useEffect(() {
      signProviderS.listSigns = generateListToMessageUtil(
        listOnlySingAndNumbers,
        signProviderS.currentMessage,
      );
      /* return pageController.dispose; */
    }, [signProviderS]);

    startPageViewMessage() {
      signProviderN.setCurrentMessage(signProviderS.currentMessage);

      pageController.jumpToPage(0);

      signProviderS.timer = Timer.periodic(
          Duration(milliseconds: settings.transitionTime.toInt()),
          (Timer timer) {
        if (pageController.page!.toInt() < signProviderS.listSigns.length - 1) {
          isPlaying.value = true;
          pageController.nextPage(
            duration: Duration(milliseconds: settings.transitionTime.toInt()),
            curve: Curves.easeInOut,
          );
        } else {
          // Si estás en la última página, vuelve al principio
          timer.cancel();
          signProviderS.timer?.cancel();

          pageController.jumpToPage(0);
          isPlaying.value = false;
        }
      });
    }

    void stopTimerAnimatedImages() {
      isPlaying.value = false;
      signProviderS.timer?.cancel();
      _currentIndex.value = 0;
      signProviderN
          .setCurrentSign(signProviderS.listSigns[_currentIndex.value]);
    }

    void startTimerAnimatedImages() {
      signProviderS.timer = Timer.periodic(
          Duration(milliseconds: settings.transitionTime.toInt()),
          (timer) async {
        isPlaying.value = true;
        signProviderN
            .setCurrentSign(signProviderS.listSigns[_currentIndex.value]);
        _currentIndex.value = _currentIndex.value + 1;

        if (_currentIndex.value == signProviderS.listSigns.length) {
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
                  if (signProviderS.currentMessage.isNotEmpty)
                    CurrentSign(
                      currenSign: signProviderS.currentSign,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: signProviderS.listSigns.isEmpty
                        ? NoInformationCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            title: "No hay mensajes todavía...",
                            description: "Puedes escribir o usar el micrófono",
                          )
                        : settings.typeDisplay == TypeDisplay.pageView
                            ? Container(
                                width: 300,
                                height: size.height * 0.50,
                                child: PageView.builder(
                                  controller: pageController,
                                  scrollDirection: settings.sliderDirection,
                                  itemCount: signProviderS.listSigns.length,
                                  itemBuilder: (context, int index) {
                                    final sign = signProviderS.listSigns[index];
                                    return InkWell(
                                      onTap: () => context.push(
                                          '${LetterAndNumbersPage.routeName}/${sign.letter}'),
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
                                child: signProviderS.listSigns.isEmpty
                                    ? const SizedBox()
                                    : Expanded(
                                        child: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            child: Card(
                                              child: Icon(
                                                signProviderS
                                                    .listSigns[
                                                        _currentIndex.value]
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          /* color: Colors.black, */
                        ),
                        children:
                            signProviderS.listSigns.mapIndexed((index, e) {
                          if (_currentIndex.value == index) {
                            return WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Transform.translate(
                                offset: const Offset(0.0, 0.0),
                                child: Text(
                                  e.letter,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    /* color: Colors.black, */
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return TextSpan(
                                text: e.letter,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ));
                          }
                        }).toList(),
                      ),
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
                Expanded(
                    child: TextFieldSendMessage(
                  onTextChange: signProviderN.setCurrentMessage,
                  initialValue: signProviderS.currentMessage,
                  onClear: (textController) {
                    textController.clear();
                    signProviderN.setCurrentMessage('');
                  },
                )),
                const SizedBox(width: 2),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: signProviderS.listSigns.isEmpty
                      ? SpeechButton(
                          onSpeechResult: signProviderN.setCurrentMessage,
                        )
                      : InkWell(
                          onTap:
                              settings.typeDisplay == TypeDisplay.imageSwitcher
                                  ? () async {
                                      FocusScope.of(context).unfocus();
                                      if (isPlaying.value) {
                                        stopTimerAnimatedImages();
                                      } else {
                                        startTimerAnimatedImages();
                                      }
                                      addCounterIntersitialAd(
                                          () => interstialAdProviderN.showAd());
                                    }
                                  : () async {
                                      FocusScope.of(context).unfocus();
                                      if (isPlaying.value) {
                                        signProviderS.timer?.cancel();
                                        isPlaying.value = false;
                                      } else {
                                        startPageViewMessage();
                                      }
                                      addCounterIntersitialAd(() => ref
                                          .read(interstiatAdProvider.notifier)
                                          .showAd());
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
  final EdgeInsetsGeometry? padding;
  const CurrentSign({
    super.key,
    this.padding,
    required this.currenSign,
  });

  final Sign? currenSign;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: currenSign?.type!.name.toCapitalize() ?? "",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const TextSpan(text: " "),
            TextSpan(
              text: currenSign?.letter ?? "",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SquareCard extends ConsumerWidget {
  final Sign sign;
  final Function(Sign sign)? onTap;
  final double iconSize;

  const SquareCard({
    super.key,
    this.onTap,
    required this.sign,
    required this.iconSize,
  });
  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsProvider);
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
            sign.type == SignType.space
                ? Icon(
                    Icons.space_bar,
                    size: iconSize,
                    color: Colors.transparent,
                  )
                : ColoredIcon(
                    icon: sign.iconSign,
                    size: iconSize,
                  ),
            Text(
              sign.letter,
              style: TextStyle(
                color: settings.color,
                fontSize: iconSize / 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
