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
    final message = useState(currentMessage);

    final controller = useTextEditingController()
      ..value = TextEditingValue(text: message.value);
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
        TextFieldSendMessage((value) {
          message.value = value;
          ref.read(signProviderProvider.notifier).generateListToMessage(value);
          ref.read(currentMessageProvider.notifier).setCurrentMessage(value);
        }),
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
    final listOnlyLettersNumbers = useState<List<Sign>>(listOnlySingAndNumbers);
    final currentMessage = ref.watch(currentMessageProvider);

    final currentMessagex = useState(currentMessage);
    final currenSign = useState<Sign?>(null);
    final controller = useTextEditingController()
      ..value = TextEditingValue(text: currentMessagex.value);

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
        currentMessagex.value,
      );
      return null;
    }, [currentMessagex.value]);

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
            text: currentMessagex.value.isEmpty
                ? "Aqui aparecera tu texto"
                : currentMessagex.value,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          TextFieldSendMessage((value) {
            currentMessagex.value = value;
          }),
          FilledButton.icon(
              onPressed: () {
                /*  ref
                    .read(signProviderProvider.notifier)
                    .generateListToMessage(currentMessagex.value);
                ref
                    .read(currentMessageProvider.notifier)
                    .setCurrentMessage(currentMessagex.value); */
/*                 print("currentMessagex.value: ${currentMessagex.value}");
                listOnlyLettersNumbers.value = generateListToMessage(
                  listOnlySingAndNumbers,
                  currentMessagex.value,
                ); */
                ref
                    .read(signProviderProvider.notifier)
                    .generateListToMessage(currentMessagex.value);
                print(
                    "listOnlyLettersNumbers: ${listOnlyLettersNumbers.value}");
                pageController.jumpToPage(0);

                Timer.periodic(Duration(milliseconds: timeMiliseconds),
                    (Timer timer) {
                  if (pageController.page!.toInt() <
                      listOnlyLettersNumbers.value.length - 1) {
                    pageController.nextPage(
                      duration: Duration(milliseconds: timeMiliseconds),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    // Si estás en la última página, vuelve al principio
                    timer.cancel();
                    pageController.jumpToPage(0);
                  }
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

class TextFieldSendMessage extends HookConsumerWidget {
  final Function(String value) onChanged;

  TextFieldSendMessage(this.onChanged);
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
      onChanged: onChanged,
    );
  }
}
