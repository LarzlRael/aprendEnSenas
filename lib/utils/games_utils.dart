part of 'utils.dart';

class TestYourGame {
  final List<Sign> options;
  final Sign correctAnswer;

  TestYourGame(this.options, this.correctAnswer);
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
