part of 'utils.dart';

TestYourGame createTestYourGame(List<Sign> options, int indexValues) {
  final correctAnswer = options.first;
  final randomOptions = List<Sign>.from(options)..shuffle();
  final getIndexes = indexValues - 1;
  final selectedOptions = randomOptions.take(getIndexes).toList()
    ..add(correctAnswer);
  return TestYourGame(
    selectedOptions,
    selectedOptions[Random().nextInt(getIndexes)],
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

GuessTheWord getRandomWordFromStringList(List<String> list) {
  final randomWord = list[Random().nextInt(list.length)];
  return GuessTheWord(
    generateListToMessage(listOnlySingAndNumbers, randomWord),
    randomWord,
  );
}

List<Sign> generateSignToPair(List<Sign> list, int itemsCount) {
  final listItems = list.take(itemsCount).toList();
  return [
    ...listItems,
    ...listItems,
  ]..shuffle();
}

/* 
test your memory
ease  7 lifes and 4 options
medium 5 lifes and 6 options
hard 3 lifes and 9 options
very hard 2 lifes and 12 options 3 rows
 */

TestYourMemoryGameDifficulty getTestYourMemoryGameDifficulty(
    Difficulty gameDifficulty) {
  switch (gameDifficulty) {
    case Difficulty.easy:
      return TestYourMemoryGameDifficulty(7, 4, 2);
    case Difficulty.medium:
      return TestYourMemoryGameDifficulty(5, 6, 2);
    case Difficulty.hard:
      return TestYourMemoryGameDifficulty(3, 9, 3);
    case Difficulty.very_hard:
      return TestYourMemoryGameDifficulty(2, 12, 3);
    default:
      return TestYourMemoryGameDifficulty(7, 4, 2);
  }
}

/* Flipping cards 
time 90 seconds 2x3 rows
time 60 seconds 4x3 rows
time 45 seconds 4x4 rows
time 60 seconds 5x5 rows
 
*/

FlipCardGame getFlipCardGameDifficulty(Difficulty gameDifficulty) {
  switch (gameDifficulty) {
    case Difficulty.easy:
      return FlipCardGame(6, 2, Duration(seconds: 90));
    case Difficulty.medium:
      return FlipCardGame(12, 3, Duration(seconds: 60));
    case Difficulty.hard:
      return FlipCardGame(16, 4, Duration(seconds: 45));
    case Difficulty.very_hard:
      return FlipCardGame(25, 5, Duration(seconds: 60));
    default:
      return FlipCardGame(6, 2, Duration(seconds: 90));
  }
}
