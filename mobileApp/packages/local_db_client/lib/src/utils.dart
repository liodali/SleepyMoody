import 'package:drift/drift.dart' show Value;
import 'package:local_db_client/src/database.dart';
import 'package:local_db_client/src/models/sleepy_moody_db_model.dart' show SleepyMoodyData;
import 'package:sleepymoody_models/models.dart' show SleepyMoodyModel;

extension SleepyMoodyModelExtension on SleepyMoodyModel {
  SleepyMoodyDataCompanion toDb() {
    return SleepyMoodyDataCompanion(
      uuid: Value(id),
      sleepHours: Value(sleepHours),
      moodToday: Value(moodToday),
      makeExercice: Value(makeExercice),
      breakfast: Value(breakfast),
      date: Value(date),
    );
  }
}

SleepyMoodyModel fromDb(SleepyMoodyDataCompanion db) {
  return SleepyMoodyModel(
    id: db.uuid.value,
    sleepHours: db.sleepHours.value,
    moodToday: db.moodToday.value,
    makeExercice: db.makeExercice.value,
    breakfast: db.breakfast.value,
    date: db.date.value,
  );
}
