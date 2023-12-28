part of 'models.dart';

enum Difficulty { easy, medium, hard, very_hard }

extension DifficultyExtension on Difficulty {
  String get name {
    switch (this) {
      case Difficulty.easy:
        return 'Fácil';
      case Difficulty.medium:
        return 'Medio';
      case Difficulty.hard:
        return 'Difícil';
      case Difficulty.very_hard:
        return 'Muy difícil';
      default:
        return '';
    }
  }
}

Difficulty getNextDifficulty(Difficulty currentDifficulty) {
  final values = Difficulty.values;
  final currentIndex = values.indexOf(currentDifficulty);

  return values[(currentIndex + 1) % values.length];
}

enum GameType {
  prueba_tu_memoria,
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
