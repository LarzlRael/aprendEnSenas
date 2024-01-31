part of 'utils.dart';

List<Sign> shuffleList(List<Sign> list) => List<Sign>.from(list)..shuffle();

TestYourGame createTestYourGame(List<Sign> options, int indexValues) {
  final correctAnswer = options.first;
  final randomOptions = shuffleList(options);
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
  final correctAnswerString =
      selectedOptions[correct].removeDiacriticsFromString();
  return WordInSightGame(
    options:
        selectedOptions.map((e) => e.removeDiacriticsFromString()).toList(),
    correctAnswerList: generateListToMessageUtil(
      listOnlySingAndNumbers,
      correctAnswerString,
    ),
    correctAnswerString: correctAnswerString,
  );
}

GuessTheWord getRandomWordFromStringList(List<String> list) {
  /* Get one string word list */
  final randomWord =
      list[Random().nextInt(list.length)].removeDiacriticsFromString();

  return GuessTheWord(
    correctWordSignList:
        generateListToMessageUtil(listOnlySingAndNumbers, randomWord),
    correctWordString: randomWord,
  );
}

List<Sign> generateSignToPair(List<Sign> list, int itemsCount) {
  final listItems = shuffleList(list);
  final listItemsToReturn = listItems.take(itemsCount).toList();

  return [
    ...listItemsToReturn,
    ...listItemsToReturn,
  ]..shuffle();
}

/* 
test your memory
ease  7 lifes and 4 options
medium 5 lifes and 6 options
hard 3 lifes and 9 options
very hard 2 lifes and 12 options 3 rows
 */

TestYourMemoryGameLevel getTestYourMemoryGameLevel(Level gameLevel) {
  switch (gameLevel) {
    case Level.easy:
      return TestYourMemoryGameLevel(7, 4, 2);
    case Level.medium:
      return TestYourMemoryGameLevel(5, 6, 2);
    case Level.hard:
      return TestYourMemoryGameLevel(3, 9, 3);
    case Level.very_hard:
      return TestYourMemoryGameLevel(2, 12, 3);
    default:
      return TestYourMemoryGameLevel(7, 4, 2);
  }
}

/* Flipping cards 
time 90 seconds 2x3 rows
time 60 seconds 4x3 rows
time 45 seconds 4x4 rows
time 60 seconds 5x5 rows
 
*/

FlipCardGame getFlipCardGameLevel(Level gameLevel) {
  switch (gameLevel) {
    case Level.easy:
      return FlipCardGame(3, 3, Duration(seconds: 90));
    case Level.medium:
      return FlipCardGame(6, 4, Duration(seconds: 60));
    case Level.hard:
      return FlipCardGame(8, 4, Duration(seconds: 45));
    case Level.very_hard:
      return FlipCardGame(10, 4, Duration(seconds: 60));
    default:
      return FlipCardGame(6, 2, Duration(seconds: 90));
  }
}

Future<void> saveGameScore(
  GameType gameType,
  int score,
  Level level,
) async {
  await KeyValueStorageServiceImpl().setKeyValue<int>(
    "${gameType.name}-${level.name}",
    score,
  );
}

Future<int?> getGameScore(GameType gameType, Level level) async {
  return await KeyValueStorageServiceImpl().getValue<int>(
    "${gameType.name}-${level.name}",
  );
}
