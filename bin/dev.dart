import 'dart:async';
import 'dart:io';

import 'package:angel_container/mirrors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:logging/logging.dart';
import 'package:social_cv_api/social_cv_api.dart' as cv;
import 'package:social_cv_api/src/pretty_logging.dart';

Future main() async {
  // Watch the config/ and web/ directories for changes, and hot-reload the server.
  hierarchicalLoggingEnabled = true;

  final hot = HotReloader(() async {
    final logger = Logger.detached('{{angel}}')
      ..level = Level.ALL
      ..onRecord.listen(prettyLog);
    final app = Angel(logger: logger, reflector: const MirrorsReflector());
    await app.configure(cv.configureServer);
    return app;
  }, [
    Directory('config'),
    Directory('lib'),
  ]);

  final server = await hot.startServer('127.0.0.1', 3000);
  print(
      'API server listening at http://${server.address.address}:${server.port}');
  print('Use Ctrl-C (SIGINT) to stop running the application.');
}
