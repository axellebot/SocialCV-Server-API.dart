import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:social_cv_api/src/middlewares/authorization_middleware.dart';

Future configureServer(Angel app) async {
  // Create the middlewares with injected dependencies
  app.container.make<AuthorizationMiddleware>();
}
