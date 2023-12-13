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
            SwitchListTile(
              value: isSwitched.value,
              onChanged: (value) {
                isSwitched.value = value;
              },
              title: const Text('Cambiar vista'),
            ),
            Expanded(
              child: isSwitched.value
                  ? SendMessageSlider()
                  : SendMessageWithStaticImages(),
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
          /* controller: controller, */
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
    final listOnlyLettersNumbers = ref.watch(signProviderProvider);
    final currentMessage = ref.watch(currentMessageProvider);
    final currentState = useState<String>("");
    final pageController = usePageController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SimpleText(
              text: "A",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: 5),
            SimpleText(
              text: "a",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        Container(
          width: 300,
          height: 400,
          color: Colors.blue,
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
              ? "Aqui aparecer tu texto"
              : currentMessage,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Escribe tu texto',
          ),
          onChanged: (value) {
            currentState.value = value;
          },
        ),
        FilledButton.icon(
            onPressed: () {
              print(currentState.value);
              ref
                  .read(signProviderProvider.notifier)
                  .generateListToMessage(currentState.value);
              ref
                  .read(currentMessageProvider.notifier)
                  .setCurrentMessage(currentState.value);
            },
            icon: Icon(Icons.send),
            label: Text(
              "Enviar mensajes",
            ))
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
