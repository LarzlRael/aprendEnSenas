/* import 'package:isar/isar.dart'; */

/* part 'game_score.g.dart'; */

/* @Collection() */
class GameScore {
  /* Id? isarId; */

  String gameName;

  int score;

  int? timeScoreMiliseconds;

  GameScore({
    /* this.isarId, */
    required this.gameName,
    required this.score,
    this.timeScoreMiliseconds,
  });
}
