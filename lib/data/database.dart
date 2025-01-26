import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart' show getApplicationSupportDirectory;
import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'connection/connection.dart' as impl;

part 'database.g.dart';

@DataClassName('Measurement')
class Measurements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  Column<double> get value => real()();
  DateTimeColumn get touched => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Measurements])
class Database extends _$Database {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'scissor_db',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'Using ${result.chosenImplementation} due to unsupported '
                  'browser features: ${result.missingFeatures}',
            );
          }
        },
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        // Make sure that foreign keys are enabled
        await customStatement('PRAGMA foreign_keys = ON');

        if (details.wasCreated) {
          // This follows the recommendation to validate that the database schema
          // matches what drift expects (https://drift.simonbinder.eu/docs/advanced-features/migrations/#verifying-a-database-schema-at-runtime).
          // It allows catching bugs in the migration logic early.
          await impl.validateDatabaseSchema(this);
        }
      }
    );
  }

  Stream<List<Measurement>> all() {
    final query = select(measurements)
        ..orderBy([(t) => OrderingTerm(expression: t.touched)]);
    return query.watch();
  }

  Future<int> addMeasurement(MeasurementsCompanion entry) {
    return into(measurements).insert(entry);
  }

  static final StateProvider<Database> provider = StateProvider((ref) {
    final database = Database();
    ref.onDispose(database.close);

    return database;
  });
}

