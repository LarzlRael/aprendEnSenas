import 'package:asl/customs_icons/custom_icons.dart';
import 'package:asl/customs_icons/sign_icons_icons.dart';
import 'package:asl/models/models.dart';
import 'package:asl/utils/utils.dart';
import 'package:flutter/material.dart';

final spaceBarIcon = Icons.space_bar;
final signLowerLetters = <Sign>[
  Sign("a", CustomIcons.a_sign),
  Sign("b", CustomIcons.b_sign),
  Sign("c", CustomIcons.c_sign),
  Sign("d", CustomIcons.d_sign),
  Sign("e", CustomIcons.e_sign),
  Sign("f", CustomIcons.f_sign),
  Sign("g", CustomIcons.g_sign),
  Sign("h", CustomIcons.h_sign),
  Sign("i", CustomIcons.i_sign),
  Sign("j", CustomIcons.j_sign),
  Sign("k", CustomIcons.k_sign),
  Sign("l", CustomIcons.l_sign),
  Sign("m", CustomIcons.m_sign),
  Sign("n", CustomIcons.n_sign),
  Sign("ñ", CustomIcons.n_sign),
  Sign("o", CustomIcons.o_sign),
  Sign("p", CustomIcons.p_sign),
  Sign("q", CustomIcons.q_sign),
  Sign("r", CustomIcons.r_sign),
  Sign("s", CustomIcons.s_sign),
  Sign("t", CustomIcons.t_sign),
  Sign("u", CustomIcons.u_sign),
  Sign("v", CustomIcons.v_sign),
  Sign("w", CustomIcons.w_sign),
  Sign("x", CustomIcons.x_sign),
  Sign("y", CustomIcons.y_sign),
  Sign("z", CustomIcons.z_sign),
  Sign(" ", spaceBarIcon, type: SignType.space),
];

/* final signStyle2 = <Sign>[
  Sign("a", SignIcons.a_sign_2),
  Sign("b", SignIcons.b_sign_2),
  Sign("c", SignIcons.c_sign_2),
  Sign("d", SignIcons.d_sign_2),
  Sign("e", SignIcons.e_sign_2),
  Sign("f", SignIcons.f_sign_2),
  Sign("g", SignIcons.g_sign_2),
  Sign("h", SignIcons.h_sign_2),
  Sign("i", SignIcons.i_sign_2),
  Sign("j", SignIcons.j_sign_2),
  Sign("k", SignIcons.k_sign_2),
  Sign("l", SignIcons.l_sign_2),
  Sign("m", SignIcons.m_sign_2),
  Sign("n", SignIcons.n_sign_2),
  Sign("ñ", SignIcons.n_sign_2),
  Sign("o", SignIcons.o_sign_2),
  Sign("p", SignIcons.p_sign_2),
  Sign("q", SignIcons.q_sign_2),
  Sign("r", SignIcons.r_sign_2),
  Sign("s", SignIcons.s_sign_2),
  Sign("t", SignIcons.t_sign_2),
  Sign("u", SignIcons.u_sign_2),
  Sign("v", SignIcons.v_sign_2),
  Sign("w", SignIcons.w_sign_2),
  Sign("x", SignIcons.x_sign_2),
  Sign("y", SignIcons.y_sign_2),
  Sign("z", SignIcons.z_sign_2),
  Sign(" ", Icons.space_bar, type: SignType.space),
  ...listOnlyNumers
]; */

final listOnlyNumers = <Sign>[
  Sign("0", CustomIcons.number_0, type: SignType.number),
  Sign("1", CustomIcons.number_1, type: SignType.number),
  Sign("2", CustomIcons.number_2, type: SignType.number),
  Sign("3", CustomIcons.number_3, type: SignType.number),
  Sign("4", CustomIcons.number_4, type: SignType.number),
  Sign("5", CustomIcons.number_5, type: SignType.number),
  Sign("6", CustomIcons.number_6, type: SignType.number),
  Sign("7", CustomIcons.number_7, type: SignType.number),
  Sign("8", CustomIcons.number_8, type: SignType.number),
  Sign("9", CustomIcons.number_9, type: SignType.number),
  Sign("10", CustomIcons.number_10, type: SignType.number),
];
final listOnlySingAndNumbers = <Sign>[
  Sign("a", CustomIcons.a_sign),
  Sign("b", CustomIcons.b_sign),
  Sign("c", CustomIcons.c_sign),
  Sign("d", CustomIcons.d_sign),
  Sign("e", CustomIcons.e_sign),
  Sign("f", CustomIcons.f_sign),
  Sign("g", CustomIcons.g_sign),
  Sign("h", CustomIcons.h_sign),
  Sign("i", CustomIcons.i_sign),
  Sign("j", CustomIcons.j_sign),
  Sign("k", CustomIcons.k_sign),
  Sign("l", CustomIcons.l_sign),
  Sign("m", CustomIcons.m_sign),
  Sign("n", CustomIcons.n_sign),
  Sign("ñ", CustomIcons.nn_sign),
  Sign("o", CustomIcons.o_sign),
  Sign("p", CustomIcons.p_sign),
  Sign("q", CustomIcons.q_sign),
  Sign("r", CustomIcons.r_sign),
  Sign("s", CustomIcons.s_sign),
  Sign("t", CustomIcons.t_sign),
  Sign("u", CustomIcons.u_sign),
  Sign("v", CustomIcons.v_sign),
  Sign("w", CustomIcons.w_sign),
  Sign("x", CustomIcons.x_sign),
  Sign("y", CustomIcons.y_sign),
  Sign("z", CustomIcons.z_sign),
  Sign(" ", spaceBarIcon, type: SignType.space),
  ...listOnlyNumers,
];

final listAllSign = <Sign>[
  ...listOnlyNumers,
  ...signLowerLetters,
];

List<Sign>? getIconSign(String letter) {
  if (letter.length == 0) {
    return [listAllSign.firstWhere((element) => element.letter == letter)];
  }

  return generateListToMessageUtil(listAllSign, letter);
}
