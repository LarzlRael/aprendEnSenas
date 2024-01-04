import 'package:asl/customs_icons/my_flutter_app_icons.dart';
import 'package:asl/models/models.dart';
import 'package:flutter/material.dart';

final signLowerLetters = <Sign>[
  Sign("a", MyFlutterApp.a_sign),
  Sign("b", MyFlutterApp.b_sign),
  Sign("c", MyFlutterApp.c_sign),
  Sign("d", MyFlutterApp.d_sign),
  Sign("e", MyFlutterApp.e_sign),
  Sign("f", MyFlutterApp.f_sign),
  Sign("g", MyFlutterApp.g_sign),
  Sign("h", MyFlutterApp.h_sign),
  Sign("i", MyFlutterApp.i_sign),
  Sign("j", MyFlutterApp.j_sign),
  Sign("k", MyFlutterApp.k_sign),
  Sign("l", MyFlutterApp.l_sign),
  Sign("m", MyFlutterApp.m_sign),
  Sign("n", MyFlutterApp.n_sign),
  Sign("ñ", MyFlutterApp.n_sign),
  Sign("o", MyFlutterApp.o_sign),
  Sign("p", MyFlutterApp.p_sign),
  Sign("q", MyFlutterApp.q_sign),
  Sign("r", MyFlutterApp.r_sign),
  Sign("s", MyFlutterApp.s_sign),
  Sign("t", MyFlutterApp.t_sign),
  Sign("u", MyFlutterApp.u_sign),
  Sign("v", MyFlutterApp.v_sign),
  Sign("w", MyFlutterApp.w_sign),
  Sign("x", MyFlutterApp.x_sign),
  Sign("y", MyFlutterApp.y_sign),
  Sign("z", MyFlutterApp.z_sign),
];

final listOnlyNumers = <Sign>[
  Sign("0", MyFlutterApp.number_0, type: SignType.number),
  Sign("1", MyFlutterApp.number_0, type: SignType.number),
  Sign("2", MyFlutterApp.number_2, type: SignType.number),
  Sign("3", MyFlutterApp.number_3, type: SignType.number),
  Sign("4", MyFlutterApp.number_4, type: SignType.number),
  Sign("5", MyFlutterApp.number_5, type: SignType.number),
  Sign("6", MyFlutterApp.number_6, type: SignType.number),
  Sign("7", MyFlutterApp.number_7, type: SignType.number),
  Sign("8", MyFlutterApp.number_8, type: SignType.number),
  Sign("9", MyFlutterApp.number_9, type: SignType.number),
  Sign("10", MyFlutterApp.number_10, type: SignType.number),
];
final listOnlySingAndNumbers = <Sign>[
  Sign("a", MyFlutterApp.a_sign),
  Sign("b", MyFlutterApp.b_sign),
  Sign("c", MyFlutterApp.c_sign),
  Sign("d", MyFlutterApp.d_sign),
  Sign("e", MyFlutterApp.e_sign),
  Sign("f", MyFlutterApp.f_sign),
  Sign("g", MyFlutterApp.g_sign),
  Sign("h", MyFlutterApp.h_sign),
  Sign("i", MyFlutterApp.i_sign),
  Sign("j", MyFlutterApp.j_sign),
  Sign("k", MyFlutterApp.k_sign),
  Sign("l", MyFlutterApp.l_sign),
  Sign("m", MyFlutterApp.m_sign),
  Sign("n", MyFlutterApp.n_sign),
  Sign("ñ", MyFlutterApp.nn_sign),
  Sign("o", MyFlutterApp.o_sign),
  Sign("p", MyFlutterApp.p_sign),
  Sign("q", MyFlutterApp.q_sign),
  Sign("r", MyFlutterApp.r_sign),
  Sign("s", MyFlutterApp.s_sign),
  Sign("t", MyFlutterApp.t_sign),
  Sign("u", MyFlutterApp.u_sign),
  Sign("v", MyFlutterApp.v_sign),
  Sign("w", MyFlutterApp.w_sign),
  Sign("x", MyFlutterApp.x_sign),
  Sign("y", MyFlutterApp.y_sign),
  Sign("z", MyFlutterApp.z_sign),
  ...listOnlyNumers,
];

final listAllSign = <Sign>[
  ...listOnlyNumers,
  ...signLowerLetters,
];

Sign getIconSign(String letter) {
  final sign = listAllSign.firstWhere((element) => element.letter == letter);
  return sign;
}
