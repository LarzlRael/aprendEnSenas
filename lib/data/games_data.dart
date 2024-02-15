import 'package:asl/customs_icons/custom_icons_icons.dart';
import 'package:asl/models/models.dart';
import 'package:asl/utils/utils.dart';
import 'package:asl/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const iconSize = 30.0;
List<SelectGameCard> selecteGameItems(BuildContext context) {
  return [
    SelectGameCard(
      icon: CustomIcons.ic_test_your_memory,
      title: AppLocalizations.of(context)!.test_your_memory,
      subtitle: AppLocalizations.of(context)!.guess_the_correct_word_or_number,
      onSelected: (context) {
        context.push(
          '/select_level_page/${AppLocalizations.of(context)!.test_your_memory}/test_your_memory_page',
          extra: CustomIcons.ic_test_your_memory,
        );
      },
    ),
    /*  SelectGameCard(
    icon: CustomIcons.ic_guess_the_word,
    title: GameType.adivina_la_palabra.name,
    subtitle: "Teclado",
    onSelected: (context) {
      context.push(
        '/games/keyboard_page',
        extra: CustomIcons.ic_guess_the_word,
      );
    },
  ), */
    SelectGameCard(
      icon: CustomIcons.ic_flip_card,
      title: AppLocalizations.of(context)!.card_flip,
      subtitle: AppLocalizations.of(context)!.flip_the_cards_and_find_the_pairs,
      onSelected: (context) {
        context.push(
          '/select_level_page/${AppLocalizations.of(context)!.card_flip}/flipping_cards_page',
          extra: CustomIcons.ic_flip_card,
        );
      },
    ),
    SelectGameCard(
      icon: CustomIcons.ic_word_in_sight,
      title: AppLocalizations.of(context)!.word_in_sight,
      subtitle:
          AppLocalizations.of(context)!.challenge_yourself_and_your_friends,
      onSelected: (context) {
        context.push(
          '/games/word_in_sight_page',
          extra: CustomIcons.ic_flip_card,
        );
      },
    ),
    SelectGameCard(
      icon: CustomIcons.ic_drag_matching,
      subtitle: AppLocalizations.of(context)!
          .drag_and_drop_the_letters_to_form_the_correct_word,
      title: AppLocalizations.of(context)!.drag_and_drop,
      onSelected: (context) {
        context.push(
          '/games/drag_and_drop_game',
          extra: CustomIcons.ic_flip_card,
        );
      },
    ),
  ];
}

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
