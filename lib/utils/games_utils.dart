part of 'utils.dart';

class TestYourGame {
  final List<Sign> options;
  final Sign correctAnswer;

  TestYourGame(this.options, this.correctAnswer);
}

class WordInSightGame {
  final List<String> options;
  final List<Sign> correctAnswerList;
  final String correctAnswerString;

  WordInSightGame(
      this.options, this.correctAnswerList, this.correctAnswerString);
}

TestYourGame createTestYourGame(List<Sign> options, int indexValues) {
  final correctAnswer = options.first;
  final randomOptions = List<Sign>.from(options)..shuffle();
  final selectedOptions = randomOptions.take(indexValues).toList()
    ..add(correctAnswer);
  return TestYourGame(
    selectedOptions,
    selectedOptions[Random().nextInt(4)],
  );
}

final palabrasComunes = <String>[
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

WordInSightGame createWordInSightGame(List<String> options, int amountOptions) {
  final correctAnswer = options.first;
  final randomOptions = List<String>.from(options)..shuffle();
  final selectedOptions = randomOptions.take(amountOptions).toList()
    ..add(correctAnswer);
  final correct = Random().nextInt(amountOptions);
  return WordInSightGame(
    selectedOptions,
    generateListToMessage(
      listOnlySingAndNumbers,
      selectedOptions[correct],
    ),
    selectedOptions[correct],
  );
}
