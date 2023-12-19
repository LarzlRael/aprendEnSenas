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

  WordInSightGame(
    this.options,
    this.correctAnswerList,
    this.correctAnswerString,
  );
}

class TestYourMemoryGameDifficulty {
  final int lifes;
  final int numberOptions;
  final int rows;

  TestYourMemoryGameDifficulty(this.lifes, this.numberOptions, this.rows);
}
