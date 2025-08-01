import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:local_db_client/src/models/sleepy_moody_db_model.dart' show SleepyMoodyData;
import 'package:path_provider/path_provider.dart' show getApplicationSupportDirectory;

part 'database.g.dart';

@DriftDatabase(tables: [SleepyMoodyData])
class AppDatabase extends _$AppDatabase {
  final int version;
  AppDatabase({QueryExecutor? executor, this.version = 1}) : super(executor ?? _openConnection());

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'sleepy_moody_db',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  @override
  int get schemaVersion => version;
}
