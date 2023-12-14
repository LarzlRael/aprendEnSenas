part of 'models.dart';

enum Difficulty { easy, medium, hard, very_hard }

enum GameType {
  test_your_memory,
  adivina_la_palabra,
  volteo_de_cartas,
  palabra_a_la_vista,
}

final colorByDifficulty = {
  Difficulty.easy: Colors.green,
  Difficulty.medium: Colors.yellow,
  Difficulty.hard: Colors.orange,
  Difficulty.very_hard: Colors.red,
};
