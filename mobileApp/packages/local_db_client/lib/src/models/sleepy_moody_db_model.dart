import 'package:drift/drift.dart'
    show
        Table,
        BuildIntColumn,
        IntColumn,
        TextColumn,
        DateTimeColumn,
        BuildGeneralColumn,
        RealColumn,
        BoolColumn;

class SleepyMoodyData extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  RealColumn get sleepHours => real()();
  IntColumn get moodToday => integer()();
  BoolColumn get makeExercice => boolean()();
  TextColumn get breakfast => text()();
  DateTimeColumn get date => dateTime()();
}
