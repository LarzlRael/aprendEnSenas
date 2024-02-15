part of 'models.dart';

enum Level { easy, medium, hard, very_hard }

extension LevelExtension on Level {
  String get name {
    switch (this) {
      case Level.easy:
        return 'Fácil';
      case Level.medium:
        return 'Medio';
      case Level.hard:
        return 'Difícil';
      case Level.very_hard:
        return 'Muy difícil';
      default:
        return '';
    }
  }
}

String levelName(BuildContext context, Level level) {
  final Map<Level, String> levelNames = {
    Level.easy: AppLocalizations.of(context)!.easy,
    Level.medium: AppLocalizations.of(context)!.medium,
    Level.hard: AppLocalizations.of(context)!.hard,
    Level.very_hard: AppLocalizations.of(context)!.very_hard,
  };

  return levelNames[level] ?? '';
}

Level getNextLevel(Level currenLevel) {
  final values = Level.values;
  final currentIndex = values.indexOf(currenLevel);

  return values[(currentIndex + 1) % values.length];
}

enum GameType {
  prueba_tu_memoria,
  adivina_la_palabra,
  volteo_de_cartas,
  palabra_a_la_vista,
  arrastra_y_suelta,
}

final colorByLevel = {
  Level.easy: Colors.green,
  Level.medium: Colors.yellow,
  Level.hard: Colors.orange,
  Level.very_hard: Colors.red,
};

final iconByGameType = {
  GameType.prueba_tu_memoria: Icons.memory,
  GameType.adivina_la_palabra: Icons.text_fields,
  GameType.volteo_de_cartas: Icons.flip_camera_android,
  GameType.palabra_a_la_vista: Icons.visibility,
};
final iconByLevel = {
  Level.easy: CustomIcons.ic_easy,
  Level.medium: CustomIcons.ic_normal,
  Level.hard: CustomIcons.ic_hard,
  Level.very_hard: CustomIcons.ic_very_hard,
};
