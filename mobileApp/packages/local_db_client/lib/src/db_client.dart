import 'package:local_db_client/src/database.dart' show AppDatabase;
import 'package:local_db_client/src/utils.dart' show fromDb, SleepyMoodyModelExtension;
import 'package:sleepymoody_models/models.dart' show SleepyMoodyModel, LocalDB;

class LocalDbClient extends LocalDB {
  final AppDatabase appDatabase;
  LocalDbClient({int versionDB = 1}) : appDatabase = AppDatabase(version: versionDB);

  @override
  Future<List<SleepyMoodyModel>> getListSleepyMoodyData() async {
    final list = await appDatabase.select(appDatabase.sleepyMoodyData).get();
    return list.map((dataDB) => fromDb(dataDB.toCompanion(true))).toList();
  }

  @override
  Stream<List<SleepyMoodyModel>> watchListSleepyMoodyData() =>
      appDatabase.select(appDatabase.sleepyMoodyData).watch().map((list) {
        return list.map((dataDB) => fromDb(dataDB.toCompanion(true))).toList();
      });

  @override
  Future<SleepyMoodyModel?> getSleepyMoodyData(String uuid) async {
    final sleepyMoody = await (appDatabase.select(
      appDatabase.sleepyMoodyData,
    )..where((tbl) => tbl.uuid.equals(uuid))).getSingleOrNull();
    return sleepyMoody != null ? fromDb(sleepyMoody.toCompanion(true)) : null;
  }

  @override
  Future<void> insertSleepyMoodyData(SleepyMoodyModel sleepyMoodyModel) async {
    await appDatabase.into(appDatabase.sleepyMoodyData).insert(sleepyMoodyModel.toDb());
  }

  @override
  Future<void> deleteSleepyMoodyData(String uuid) async {
    appDatabase.delete(appDatabase.sleepyMoodyData).where((tbl) => tbl.uuid.equals(uuid));
  }

  @override
  Future<void> clearSleepyMoody() async {
    appDatabase.delete(appDatabase.sleepyMoodyData);
  }
}
