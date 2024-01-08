part of 'utils.dart';

class TestYourGame {
  final List<Sign> options;
  final Sign correctAnswer;

  TestYourGame(this.options, this.correctAnswer);
}

class GuessTheWord {
  final List<Sign> correctWord;
  final String word;

  GuessTheWord(this.correctWord, this.word);
}

class WordInSightGame {
  final List<String> options;
  final List<Sign> correctAnswerList;
  final String correctAnswerString;

  WordInSightGame({
    required this.options,
    required this.correctAnswerList,
    required this.correctAnswerString,
  });
}

class TestYourMemoryGameLevel {
  final int lifes;
  final int numberOptions;
  final int rows;

  TestYourMemoryGameLevel(this.lifes, this.numberOptions, this.rows);
}

class FlipCardGame {
  final int options;
  final int rows;
  final Duration duration;

  FlipCardGame(this.options, this.rows, this.duration);
}
