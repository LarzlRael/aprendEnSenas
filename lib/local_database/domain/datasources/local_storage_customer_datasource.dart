import '../../game_score.dart';

abstract class GameScoreDatasource {
  GameScore getNameScore(String nameScore);
  Future<void> updateGameScore(GameScore gameScore);
}
