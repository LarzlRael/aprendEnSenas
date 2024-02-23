part of '../pages.dart';

enum KeyboardButtonType { backSpace, clearAll, enter, space, shift, normal }

class KeyboardBtn {
  Sign value;

  Widget? widgetIcon;
  KeyboardButtonType? type;
  KeyboardBtn({
    required this.value,
    this.widgetIcon,
    this.type = KeyboardButtonType.normal,
  });
}

List<List<KeyboardBtn>> keyboardListGenerate(List<Sign> list) {
  return [
    [
      KeyboardBtn(value: list[29]), // SignIcons.number_0
      KeyboardBtn(value: list[30]), // SignIcons.number_1
      KeyboardBtn(value: list[31]), // SignIcons.number_2
      KeyboardBtn(value: list[32]), // SignIcons.number_3
      KeyboardBtn(value: list[33]), // SignIcons.number_4
      KeyboardBtn(value: list[34]), // SignIcons.number_5
      KeyboardBtn(value: list[35]), // SignIcons.number_6
      KeyboardBtn(value: list[36]), // SignIcons.number_7
      KeyboardBtn(value: list[37]), // SignIcons.number_8
      KeyboardBtn(value: list[38]), // SignIcons.number_9
    ],
    [
      KeyboardBtn(value: list[17]), // SignIcons.q_sign_4
      KeyboardBtn(value: list[23]), // SignIcons.w_sign_4
      KeyboardBtn(value: list[4]), // SignIcons.e_sign_4
      KeyboardBtn(value: list[18]), // SignIcons.r_sign_4
      KeyboardBtn(value: list[20]), // SignIcons.t_sign_4
      KeyboardBtn(value: list[25]), // SignIcons.y_sign_4
      KeyboardBtn(value: list[21]), // SignIcons.u_sign_4
      KeyboardBtn(value: list[8]), // SignIcons.i_sign_4
      KeyboardBtn(value: list[15]), // SignIcons.o_sign_4
      KeyboardBtn(value: list[16]), // SignIcons.p_sign_4
    ],
    [
      KeyboardBtn(value: list[0]), // SignIcons.a_sign_4
      KeyboardBtn(value: list[19]), // SignIcons.s_sign_4
      KeyboardBtn(value: list[3]), // SignIcons.d_sign_4
      KeyboardBtn(value: list[5]), // SignIcons.f_sign_4
      KeyboardBtn(value: list[6]), // SignIcons.g_sign_4
      KeyboardBtn(value: list[7]), // SignIcons.h_sign_4
      KeyboardBtn(value: list[9]), // SignIcons.j_sign_4
      KeyboardBtn(value: list[10]), // SignIcons.k_sign_4
      KeyboardBtn(value: list[11]), // SignIcons.l_sign_4
      KeyboardBtn(value: list[14]), // SignIcons.nn_sign
    ],
    [
      KeyboardBtn(value: list[26]), // SignIcons.z_sign_4
      KeyboardBtn(value: list[24]), // SignIcons.x_sign_4
      KeyboardBtn(value: list[2]), // SignIcons.c_sign_4
      KeyboardBtn(value: list[22]), // SignIcons.v_sign_4
      KeyboardBtn(value: list[1]), // SignIcons.b_sign_4
      KeyboardBtn(value: list[13]), // SignIcons.n_sign_4
      KeyboardBtn(value: list[12]), // SignIcons.m_sign_4
      /* change this  */
      KeyboardBtn(
        value: list[12],
        widgetIcon: Icon(Icons.backspace),
        type: KeyboardButtonType.backSpace,
      ), // SignIcons.m_sign_4
    ],
    [
      KeyboardBtn(
          value: list[10],
          widgetIcon: Icon(Icons.space_bar),
          type: KeyboardButtonType.space),
    ],
  ];
}

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
            Text(text.value),
            /* Wrap(
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
            ), */
            for (var row
                in keyboardListGenerate(ref.read(signProvider).currentListSing))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Create a button for each key in the row
                  for (var key in row)
                    KeyboardButton(
                      text: key.value.iconSign,
                      icon: key.widgetIcon,
                      type: key.type!,
                      onLongPress: () {
                        switch (key.type) {
                          case KeyboardButtonType.backSpace:
                            text.value = '';
                            break;
                          default:
                        }
                      },
                      onPressed: () {
                        switch (key.type) {
                          case KeyboardButtonType.backSpace:
                            if (text.value.isNotEmpty) {
                              text.value = text.value
                                  .substring(0, text.value.length - 1);
                            }
                            break;
                          case KeyboardButtonType.normal:
/*                             text.value = text.value + key.value; */
                            text.value = text.value + key.value.letter;
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
