import 'package:asl/customs_icons/sign_icons.dart';
import 'package:asl/models/models.dart';
import 'package:asl/utils/utils.dart';
import 'package:flutter/material.dart';

final spaceBarIcon = Icons.space_bar;
final signStyle1 = <Sign>[
  Sign("a", SignIcons.a_sign),
  Sign("b", SignIcons.b_sign),
  Sign("c", SignIcons.c_sign),
  Sign("d", SignIcons.d_sign),
  Sign("e", SignIcons.e_sign),
  Sign("f", SignIcons.f_sign),
  Sign("g", SignIcons.g_sign),
  Sign("h", SignIcons.h_sign),
  Sign("i", SignIcons.i_sign),
  Sign("j", SignIcons.j_sign),
  Sign("k", SignIcons.k_sign),
  Sign("l", SignIcons.l_sign),
  Sign("m", SignIcons.m_sign),
  Sign("n", SignIcons.n_sign),
  Sign("ñ", SignIcons.nn_sign),
  Sign("o", SignIcons.o_sign),
  Sign("p", SignIcons.p_sign),
  Sign("q", SignIcons.q_sign),
  Sign("r", SignIcons.r_sign),
  Sign("s", SignIcons.s_sign),
  Sign("t", SignIcons.t_sign),
  Sign("u", SignIcons.u_sign),
  Sign("v", SignIcons.v_sign),
  Sign("w", SignIcons.w_sign),
  Sign("x", SignIcons.x_sign),
  Sign("y", SignIcons.y_sign),
  Sign("z", SignIcons.z_sign),
  Sign(" ", spaceBarIcon, type: SignType.space),
  ...listOnlyNumers,
];

final signStyle2 = <Sign>[
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
  Sign("ñ", SignIcons.nn_sign),
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
];

final signStyle3 = <Sign>[
  Sign("a", SignIcons.a_sign_3),
  Sign("b", SignIcons.b_sign_3),
  Sign("c", SignIcons.c_sign_3),
  Sign("d", SignIcons.d_sign_3),
  Sign("e", SignIcons.e_sign_3),
  Sign("f", SignIcons.f_sign_3),
  Sign("g", SignIcons.g_sign_3),
  Sign("h", SignIcons.h_sign_3),
  Sign("i", SignIcons.i_sign_3),
  Sign("j", SignIcons.j_sign_3),
  Sign("k", SignIcons.k_sign_3),
  Sign("l", SignIcons.l_sign_3),
  Sign("m", SignIcons.m_sign_3),
  Sign("n", SignIcons.n_sign_3),
  Sign("ñ", SignIcons.nn_sign),
  Sign("o", SignIcons.o_sign_3),
  Sign("p", SignIcons.p_sign_3),
  Sign("q", SignIcons.q_sign_3),
  Sign("r", SignIcons.r_sign_3),
  Sign("s", SignIcons.s_sign_3),
  Sign("t", SignIcons.t_sign_3),
  Sign("u", SignIcons.u_sign_3),
  Sign("v", SignIcons.v_sign_3),
  Sign("w", SignIcons.w_sign_3),
  Sign("x", SignIcons.x_sign_3),
  Sign("y", SignIcons.y_sign_3),
  Sign("z", SignIcons.z_sign_3),
  Sign(" ", Icons.space_bar, type: SignType.space),
  ...listOnlyNumers
];
final signStyle4 = <Sign>[
  Sign("a", SignIcons.a_sign_4),
  Sign("b", SignIcons.b_sign_4),
  Sign("c", SignIcons.c_sign_4),
  Sign("d", SignIcons.d_sign_4),
  Sign("e", SignIcons.e_sign_4),
  Sign("f", SignIcons.f_sign_4),
  Sign("g", SignIcons.g_sign_4),
  Sign("h", SignIcons.h_sign_4),
  Sign("i", SignIcons.i_sign_4),
  Sign("j", SignIcons.j_sign_4),
  Sign("k", SignIcons.k_sign_4),
  Sign("l", SignIcons.l_sign_4),
  Sign("m", SignIcons.m_sign_4),
  Sign("n", SignIcons.n_sign_4),
  Sign("ñ", SignIcons.nn_sign),
  Sign("o", SignIcons.o_sign_4),
  Sign("p", SignIcons.p_sign_4),
  Sign("q", SignIcons.q_sign_4),
  Sign("r", SignIcons.r_sign_4),
  Sign("s", SignIcons.s_sign_4),
  Sign("t", SignIcons.t_sign_4),
  Sign("u", SignIcons.u_sign_4),
  Sign("v", SignIcons.v_sign_4),
  Sign("w", SignIcons.w_sign_4),
  Sign("x", SignIcons.x_sign_4),
  Sign("y", SignIcons.y_sign_4),
  Sign("z", SignIcons.z_sign_4),
  Sign(" ", Icons.space_bar, type: SignType.space),
  ...listOnlyNumers
];

final listOnlyNumers = <Sign>[
  Sign("0", SignIcons.number_0, type: SignType.number),
  Sign("1", SignIcons.number_1, type: SignType.number),
  Sign("2", SignIcons.number_2, type: SignType.number),
  Sign("3", SignIcons.number_3, type: SignType.number),
  Sign("4", SignIcons.number_4, type: SignType.number),
  Sign("5", SignIcons.number_5, type: SignType.number),
  Sign("6", SignIcons.number_6, type: SignType.number),
  Sign("7", SignIcons.number_7, type: SignType.number),
  Sign("8", SignIcons.number_8, type: SignType.number),
  Sign("9", SignIcons.number_9, type: SignType.number),
  Sign("10", SignIcons.number_10, type: SignType.number),
];

List<Sign>? getIconSign(String letter, List<Sign> listAllSign) {
  if (letter.length == 0) {
    return [listAllSign.firstWhere((element) => element.letter == letter)];
  }

  return generateListToMessageUtil(listAllSign, letter);
}
