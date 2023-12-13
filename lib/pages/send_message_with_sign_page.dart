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
      body: SafeArea(
        child: Container(
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
      ),
    );
  }
}

class SendMessageWithStaticImages extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = useState(5);
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
              itemCount: listOnlySingAndNumbers.length,
              itemBuilder: (context, int index) {
                return SquareCard(sign: listOnlySingAndNumbers[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SendMessageSlider extends StatelessWidget {
  const SendMessageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SimpleText(
              text: "Letra",
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
        ),
        SimpleText(
          text: "Aqui aparecer tu texto",
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Escribe tu texto',
          ),
        ),
        FilledButton.icon(
            onPressed: () {},
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
