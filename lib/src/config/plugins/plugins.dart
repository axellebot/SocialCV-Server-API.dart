library social_cv_api.src.config.plugins;

import 'dart:async';

import 'package:angel_framework/angel_framework.dart';

import 'oauth.dart' as oauth;
import 'orm.dart' as orm;

Future configureServer(Angel app) async {
  // Include any plugins you have made here.
  await app.configure(orm.configureServer);
  // config OAuth after ORM
  await app.configure(oauth.configureServer);
}
