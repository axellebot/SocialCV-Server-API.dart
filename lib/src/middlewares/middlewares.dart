import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:social_cv_api/src/middlewares/authorization_middleware.dart';

Future configureServer(Angel app) async {
  // Create the middlewares with injected dependencies
  final queryExecutor = app.container.make<QueryExecutor>();
  final AuthorizationMiddleware authMiddleware = AuthorizationMiddleware(executor: queryExecutor);
  app.container.registerSingleton<AuthorizationMiddleware>(authMiddleware);
}
