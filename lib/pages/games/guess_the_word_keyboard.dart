part of '../pages.dart';

enum KeyboardButtonType { clearOne, clearAll, enter, space, shift, normal }

class KeyboardBtn {
  String value;

  Function(String currentString)? action;
  Widget? actionIcon;
  KeyboardButtonType? type;
  KeyboardBtn({
    required this.value,
    this.action,
    this.actionIcon,
    this.type = KeyboardButtonType.normal,
  });
}

final keyboard = [
  [
    KeyboardBtn(value: '1'),
    KeyboardBtn(value: '2'),
    KeyboardBtn(value: '3'),
    KeyboardBtn(value: '4'),
    KeyboardBtn(value: '5'),
    KeyboardBtn(value: '6'),
    KeyboardBtn(value: '7'),
    KeyboardBtn(value: '8'),
    KeyboardBtn(value: '9'),
    KeyboardBtn(value: '0'),
  ],
  [
    KeyboardBtn(value: 'q'),
    KeyboardBtn(value: 'w'),
    KeyboardBtn(value: 'e'),
    KeyboardBtn(value: 'r'),
    KeyboardBtn(value: 't'),
    KeyboardBtn(value: 'y'),
    KeyboardBtn(value: 'u'),
    KeyboardBtn(value: 'i'),
    KeyboardBtn(value: 'o'),
    KeyboardBtn(value: 'p'),
  ],
  [
    KeyboardBtn(value: 'a'),
    KeyboardBtn(value: 's'),
    KeyboardBtn(value: 'd'),
    KeyboardBtn(value: 'f'),
    KeyboardBtn(value: 'g'),
    KeyboardBtn(value: 'h'),
    KeyboardBtn(value: 'j'),
    KeyboardBtn(value: 'k'),
    KeyboardBtn(value: 'l'),
    KeyboardBtn(value: 'ñ'),
  ],
  [
    KeyboardBtn(value: 'z'),
    KeyboardBtn(value: 'x'),
    KeyboardBtn(value: 'c'),
    KeyboardBtn(value: 'v'),
    KeyboardBtn(value: 'b'),
    KeyboardBtn(value: 'n'),
    KeyboardBtn(value: 'm'),
    KeyboardBtn(
      value: 'back',
      type: KeyboardButtonType.clearOne,
      actionIcon: Icon(Icons.backspace, size: 22, color: Colors.green),
    ),
  ],
  [
    KeyboardBtn(
      value: 'space',
      actionIcon: Icon(Icons.space_bar),
      type: KeyboardButtonType.space,
    ),
  ]
];

class GuessTheWordKeyboard extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String cat = 'perro';
    final text = useState<String>('');
    final textGame = useState<List<Sign>>([]);
    useEffect(() {
      textGame.value = generateListToMessageUtil(
          ref.read(signProvider).currentListSing, cat);
      return () {};
    }, []);

    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /* ResultGroup(), */
            Wrap(
              children: textGame.value
                  .map(
                    (e) => Card(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Icon(
                          e.iconSign,
                          size: 45,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            for (var row in keyboard)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Create a button for each key in the row
                  for (var key in row)
                    KeyboardButton(
                      text: key.value,
                      icon: key.actionIcon,
                      type: key.type!,
                      onPressed: () {
                        switch (key.type) {
                          case KeyboardButtonType.clearOne:
                            if (text.value.isNotEmpty) {
                              text.value = text.value
                                  .substring(0, text.value.length - 1);
                            }
                            break;
                          case KeyboardButtonType.normal:
                            text.value = text.value + key.value;
                            break;

                          case KeyboardButtonType.space:
                            text.value = text.value + ' ';
                            break;
                          default:
                        }
                      },
                    ),
                ],
              ),
          ],
        ),
      ),
    ));
  }
}
