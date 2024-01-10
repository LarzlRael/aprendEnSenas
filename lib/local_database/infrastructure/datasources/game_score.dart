/* import 'package:asl/local_database/domain/datasources/local_storage_customer_datasource.dart';
import 'package:asl/local_database/game_score.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarGameScore implements GameScoreDatasource {
  late Future<Isar> db;

  IsarGameScore() {
    db = openIsarDB();
  }

  Future<Isar> openIsarDB() async {
    var dbPath = (await getApplicationDocumentsDirectory()).path;
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [GameScoreSchema],
        inspector: true,
        directory: dbPath,
      );
    }
    return Future.value(Isar.getInstance());
  }

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
 */
