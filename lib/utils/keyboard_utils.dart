part of 'utils.dart';

enum KeyboardButtonType {
  backSpace,
  clearAll,
  enter,
  space,
  shift,
  normal,
  changeView
}

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

List<List<KeyboardBtn>> keyboardListGenerate(
  List<Sign> list, {
  bool changeView = false,
  bool showNumbers = true,
  bool showSpace = true,
}) {
  return [
    if (showNumbers)
      [
        KeyboardBtn(value: list[29]), // number_1
        KeyboardBtn(value: list[30]), // number_2
        KeyboardBtn(value: list[31]), // number_3
        KeyboardBtn(value: list[32]), // number_4
        KeyboardBtn(value: list[33]), // number_5
        KeyboardBtn(value: list[34]), // number_6
        KeyboardBtn(value: list[35]), // number_7
        KeyboardBtn(value: list[36]), // number_8
        KeyboardBtn(value: list[37]), // number_9
        KeyboardBtn(value: list[28]), // number_0
      ],
    [
      KeyboardBtn(value: list[17]), // q_sign_4
      KeyboardBtn(value: list[23]), // w_sign_4
      KeyboardBtn(value: list[4]), // e_sign_4
      KeyboardBtn(value: list[18]), // r_sign_4
      KeyboardBtn(value: list[20]), // t_sign_4
      KeyboardBtn(value: list[25]), // y_sign_4
      KeyboardBtn(value: list[21]), // u_sign_4
      KeyboardBtn(value: list[8]), // i_sign_4
      KeyboardBtn(value: list[15]), // o_sign_4
      KeyboardBtn(value: list[16]), // p_sign_4
    ],
    [
      KeyboardBtn(value: list[0]), // a_sign_4
      KeyboardBtn(value: list[19]), // s_sign_4
      KeyboardBtn(value: list[3]), // d_sign_4
      KeyboardBtn(value: list[5]), // f_sign_4
      KeyboardBtn(value: list[6]), // g_sign_4
      KeyboardBtn(value: list[7]), // h_sign_4
      KeyboardBtn(value: list[9]), // j_sign_4
      KeyboardBtn(value: list[10]), // k_sign_4
      KeyboardBtn(value: list[11]), // l_sign_4
      KeyboardBtn(value: list[14]), // nn_sign
    ],
    [
      if (changeView)
        KeyboardBtn(
          value: list[29],
          widgetIcon: Icon(
            Icons.forward,
            color: Colors.white,
            size: 20,
          ),
          type: KeyboardButtonType.enter,
        ), //
      KeyboardBtn(
        value: list[22],
        type: KeyboardButtonType.changeView,
        widgetIcon: Icon(
          Icons.refresh,
          color: Colors.white,
          size: 20,
        ),
      ), // z_sign_4

      KeyboardBtn(value: list[26]), // z_sign_4
      KeyboardBtn(value: list[24]), // x_sign_4
      KeyboardBtn(value: list[2]), // c_sign_4
      KeyboardBtn(value: list[22]), // v_sign_4
      KeyboardBtn(value: list[1]), // b_sign_4
      KeyboardBtn(value: list[13]), // n_sign_4
      KeyboardBtn(value: list[12]), // m_sign_4
      KeyboardBtn(
        value: list[29],
        widgetIcon: Icon(
          Icons.backspace,
          color: Colors.white,
          size: 20,
        ),
        type: KeyboardButtonType.backSpace,
      ), // m_sign_4
    ],
    if (showSpace)
      [
        KeyboardBtn(
            value: list[10],
            widgetIcon: Icon(Icons.space_bar, color: Colors.transparent),
            type: KeyboardButtonType.space),
      ],
  ];
}
