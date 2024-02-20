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

final Map<String, String> _spanishToEnglish = {
  'algo': 'something',
  'alguien': 'someone',
  'algún': 'some',
  'alguna': 'some',
  'algunas': 'some',
  'alguno': 'some',
  'algunos': 'some',
  'allá': 'there',
  'allí': 'there',
  'ambos': 'both',
  'ampleamos': 'we use',
  'ante': 'before',
  'antes': 'before',
  'aquel': 'that',
  'aquellas': 'those',
  'aquellos': 'those',
  'aqui': 'here',
  'arriba': 'above',
  'asi': 'like this',
  'atras': 'behind',
  'aun': 'still',
  'aunque': 'although',
  'bajo': 'under',
  'bastante': 'enough',
  'bien': 'well',
  'cabe': 'it fits',
  'cada': 'each',
  'casi': 'almost',
  'cierta': 'certain',
  'ciertas': 'certain',
  'cierto': 'certain',
  'ciertos': 'certain',
  'como': 'like',
  'con': 'with',
  'conmigo': 'with me',
  'conseguimos': 'we get',
  'conseguir': 'to get',
  'consigo': 'with him/her',
  'consigue': 'he/she gets',
  'consiguen': 'they get',
  'consigues': 'you get',
  'contigo': 'with you',
  'contra': 'against',
  'cual': 'which',
  'cuales': 'which',
  'cualquier': 'any',
  'cualquiera': 'anyone',
  'cualquieras': 'anyone',
  'cuan': 'how',
  'cuando': 'when',
  'cuanta': 'how much',
  'cuantas': 'how many',
  'cuanto': 'how much',
  'cuantos': 'how many',
  'de': 'of',
  'dejar': 'to leave',
  'del': 'of the',
  'demás': 'others',
  'demas': 'others',
  'demasiada': 'too much',
  'demasiadas': 'too many',
  'demasiado': 'too much',
  'demasiados': 'too many',
  'dentro': 'inside',
  'desde': 'since',
  'donde': 'where',
  'dos': 'two',
  'el': 'the',
  'él': 'he',
  'ella': 'she',
  'ellas': 'they (feminine)',
  'ello': 'it',
  'ellos': 'they (masculine)',
  'empleais': 'you use',
  'emplean': 'they use',
  'emplear': 'to use',
  'empleas': 'you use',
  'empleo': 'job',
  'en': 'in',
  'encima': 'above',
  'entonces': 'then',
  'entre': 'between',
  'era': 'it was',
  'eramos': 'we were',
  'eran': 'they were',
  'eras': 'you were',
  'eres': 'you are',
  'es': 'is',
  'esa': 'that',
  'esas': 'those',
  'ese': 'that',
  'eso': 'that',
  'esos': 'those',
  'esta': 'this',
  'estaba': 'it was',
  'estado': 'been',
  'estais': 'you are',
  'estamos': 'we are',
  'estan': 'they are',
};

List<String> getWords(String language) {
  switch (language) {
    case "es":
      return _spanishToEnglish.keys.toList();
    case "en":
      return _spanishToEnglish.values.toList();
    default:
      return [];
  }
}
