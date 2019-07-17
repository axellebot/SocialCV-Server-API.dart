library scoail_cv_api.src.routes.controllers;

import 'dart:async';

import 'package:angel_framework/angel_framework.dart';

/// Controllers
import 'package:social_cv_api/src/routes/controllers/entry_controller.dart';
import 'package:social_cv_api/src/routes/controllers/group_controller.dart';
import 'package:social_cv_api/src/routes/controllers/identity_controller.dart';
import 'package:social_cv_api/src/routes/controllers/oauth_controller.dart';
import 'package:social_cv_api/src/routes/controllers/part_controller.dart';
import 'package:social_cv_api/src/routes/controllers/profile_controller.dart';
import 'package:social_cv_api/src/routes/controllers/register_controller.dart';
import 'package:social_cv_api/src/routes/controllers/user_controller.dart';

Future configureServer(Angel app) async {
  /// Controllers will not function unless wired to the application!
  // Create the controller with injected dependencies
  await app.mountController<OAuthController>();
  await app.mountController<UserController>();
  await app.mountController<IdentityController>();
  await app.mountController<RegisterController>();
  await app.mountController<ProfileController>();
  await app.mountController<PartController>();
  await app.mountController<GroupController>();
  await app.mountController<EntryController>();
}
