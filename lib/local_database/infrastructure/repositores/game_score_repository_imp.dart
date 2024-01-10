import 'package:asl/local_database/domain/datasources/local_storage_customer_datasource.dart';
import 'package:asl/local_database/domain/repositories/local_storage_customer_repository.dart';
import 'package:asl/local_database/game_score.dart';

class GameScoreRepositoryImp extends GameScoreCustomerRepository {
  final GameScoreDatasource dataSource;
  GameScoreRepositoryImp(this.dataSource);

  @override
  GameScore getNameScore(String nameScore) {
    // TODO: implement getNameScore
    throw UnimplementedError();
  }

  @override
  Future<void> updateGameScore(GameScore gameScore) {
    // TODO: implement updateGameScore
    throw UnimplementedError();
  }
}
