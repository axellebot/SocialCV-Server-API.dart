import 'dart:async';

import 'package:angel_configuration/angel_configuration.dart';
import 'package:angel_migration_runner/angel_migration_runner.dart';
import 'package:angel_migration_runner/postgres.dart';
import 'package:file/local.dart';
import 'package:social_cv_api/src/config/plugins/orm.dart';
import 'package:social_cv_api/src/models/models.dart';

Future main(List<String> args) async {
  const fs = LocalFileSystem();
  final configuration = await loadStandaloneConfiguration(fs);
  final connection = await connectToPostgres(configuration);
  final migrationRunner = PostgresMigrationRunner(connection, migrations: [
    UserMigration(),
    ProfileMigration(),
    PartMigration(),
    GroupMigration(),
    EntryMigration(),
    // OAuth
    ClientMigration(),
    AuthCodeMigration(),
  ]);
  return await runMigrations(migrationRunner, args);
}
