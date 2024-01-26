import 'package:asl/customs_icons/custom_icons.dart';
import 'package:asl/models/models.dart';
import 'package:asl/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const iconSize = 30.0;
final items = <SelectGameCard>[
  SelectGameCard(
    icon: CustomIcons.ic_test_your_memory,
    title: GameType.prueba_tu_memoria.name,
    subtitle: "Adivina la palabra o número correcto",
    onSelected: (context) {
      context.push(
        '/select_level_page/${GameType.prueba_tu_memoria.name}/test_your_memory_page',
        extra: CustomIcons.ic_test_your_memory,
      );
    },
  ),
  /* SelectGameCard(
    icon: CustomIcons.ic_guess_the_word,
    title: GameType.adivina_la_palabra.name,
    subtitle: "Prueba con conocimiento con las palabras",
    onSelected: (context) {
      context.push(
        '/games/guess_the_word_page',
        extra: CustomIcons.ic_guess_the_word,
      );
    },
  ), */
  SelectGameCard(
    icon: CustomIcons.ic_flip_card,
    title: GameType.volteo_de_cartas.name,
    subtitle: "Voltea las cartas y encuentra la pareja",
    onSelected: (context) {
      context.push(
        '/select_level_page/${GameType.volteo_de_cartas.name}/flipping_cards_page',
        extra: CustomIcons.ic_flip_card,
      );
    },
  ),
  SelectGameCard(
    icon: CustomIcons.ic_word_in_sight,
    subtitle: "Desafiate a ti mismo y a tus amigos",
    title: GameType.palabra_a_la_vista.name,
    onSelected: (context) {
      context.push(
        '/games/word_in_sight_page',
        extra: CustomIcons.ic_flip_card,
      );
    },
  ),
  SelectGameCard(
    icon: CustomIcons.ic_drag_matching,
    subtitle: "Arraga y suelta las letras para formar la palabra correcta",
    title: GameType.arrastra_y_suelta.name,
    onSelected: (context) {
      context.push(
        '/games/drag_and_drop_game',
        extra: CustomIcons.ic_flip_card,
      );
    },
  ),
];

final commonWords = <String>[
  'a',
  'al',
  'algo',
  'alguien',
  'algún',
  'alguna',
  'algunas',
  'alguno',
  'algunos',
  'allá',
  'allí',
  'ambos',
  'ampleamos',
  'ante',
  'antes',
  'aquel',
  'aquellas',
  'aquellos',
  'aqui',
  'arriba',
  'asi',
  'atras',
  'aun',
  'aunque',
  'bajo',
  'bastante',
  'bien',
  'cabe',
  'cada',
  'casi',
  'cierta',
  'ciertas',
  'cierto',
  'ciertos',
  'como',
  'con',
  'conmigo',
  'conseguimos',
  'conseguir',
  'consigo',
  'consigue',
  'consiguen',
  'consigues',
  'contigo',
  'contra',
  'cual',
  'cuales',
  'cualquier',
  'cualquiera',
  'cualquieras',
  'cuan',
  'cuando',
  'cuanta',
  'cuantas',
  'cuanto',
  'cuantos',
  'de',
  'dejar',
  'del',
  'demás',
  'demas',
  'demasiada',
  'demasiadas',
  'demasiado',
  'demasiados',
  'dentro',
  'desde',
  'donde',
  'dos',
  'el',
  'él',
  'ella',
  'ellas',
  'ello',
  'ellos',
  'empleais',
  'emplean',
  'emplear',
  'empleas',
  'empleo',
  'en',
  'encima',
  'entonces',
  'entre',
  'era',
  'eramos',
  'eran',
  'eras',
  'eres',
  'es',
  'esa',
  'esas',
  'ese',
  'eso',
  'esos',
  'esta',
  'estaba',
  'estado',
  'estais',
  'estamos',
  'estan',
];
