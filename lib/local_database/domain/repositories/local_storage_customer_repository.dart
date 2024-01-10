import 'package:asl/local_database/game_score.dart';

abstract class GameScoreCustomerRepository {
  GameScore getNameScore(String nameScore);
  Future<void> updateGameScore(GameScore gameScore);
}
