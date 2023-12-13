import 'package:asl/widgets/widgets.dart';
import 'package:flutter/material.dart';

final items = <SelectGameCard>[
  SelectGameCard(
    icon: Icons.ac_unit,
    title: "Test your Memory",
    subtitle: "Adivina la palabra o numero correcto",
    path: '/select_game_menu_page/test_your_memory_game',
  ),
  SelectGameCard(
    icon: Icons.ac_unit,
    title: "Adivina la palabra",
    subtitle: "Prueba con conocimiento con las palabras",
    path: '/select_game_menu_page/guess_the_word_game',
  ),
  SelectGameCard(
    icon: Icons.ac_unit,
    title: "Volteo de cartas",
    subtitle: "Voltea las cartas y encuentra la pareja",
    path: '/select_game_menu_page/flip_cards_game_game',
  ),
  SelectGameCard(
    icon: Icons.ac_unit,
    title: "Palabra a la vista",
    subtitle: "Desafiate a ti mismo y a tus amigos",
    path: '/select_game_menu_page/word_in_sight_game',
  ),
];
