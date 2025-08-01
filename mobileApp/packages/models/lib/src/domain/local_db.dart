import 'package:sleepymoody_models/src/models/sleepy_moody_model.dart' show SleepyMoodyModel;

abstract class LocalDB {
  Future<List<SleepyMoodyModel>> getListSleepyMoodyData();
  Stream<List<SleepyMoodyModel>> watchListSleepyMoodyData();
  Future<SleepyMoodyModel?> getSleepyMoodyData(String uuid);
  Future<void> insertSleepyMoodyData(SleepyMoodyModel sleepyMoodyModel);
  Future<void> deleteSleepyMoodyData(String uuid);
  Future<void> clearSleepyMoody();
}
