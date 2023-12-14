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

getRandomWordFromStringList(List<String> list) {
  return list[Random().nextInt(list.length)];
}
