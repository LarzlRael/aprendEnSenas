import 'package:asl/models/models.dart';
import 'package:asl/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final items = <SelectGameCard>[
  SelectGameCard(
    icon: Icons.ac_unit,
    title: GameType.test_your_memory.name,
    subtitle: "Adivina la palabra o numero correcto",
    onSelected: (context) {
      context.push('/select_difficulty_page/',
          extra: GameType.test_your_memory);
    },
  ),
  SelectGameCard(
    icon: Icons.ac_unit,
    title: GameType.adivina_la_palabra.name,
    subtitle: "Prueba con conocimiento con las palabras",
    onSelected: (context) {
      context.push('/select_difficulty_page/',
          extra: GameType.adivina_la_palabra);
    },
  ),
  SelectGameCard(
    icon: Icons.ac_unit,
    title: GameType.volteo_de_cartas.name,
    subtitle: "Voltea las cartas y encuentra la pareja",
    onSelected: (context) {
      context.push('/select_difficulty_page/',
          extra: GameType.volteo_de_cartas);
    },
  ),
  SelectGameCard(
    icon: Icons.ac_unit,
    subtitle: "Desafiate a ti mismo y a tus amigos",
    title: GameType.palabra_a_la_vista.name,
    onSelected: (context) {
      context.push('/select_difficulty_page/',
          extra: GameType.palabra_a_la_vista);
    },
  ),
];
