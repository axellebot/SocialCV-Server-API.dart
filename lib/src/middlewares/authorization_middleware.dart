import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:social_cv_api/src/models/models.dart';

final _rgxBearer = RegExp(r'^[Bb]earer ([^\n\s]+)$');

class AuthorizationMiddleware {
  const AuthorizationMiddleware(this.executor)
      : assert(executor != null, 'No $QueryExecutor given');

  final QueryExecutor executor;

  Future<bool> _requireToken(RequestContext req, ResponseContext res) async {
    final String authorizationToken =
        req.headers.value('authorization')?.replaceAll(_rgxBearer, '')?.trim();

    if (authorizationToken == null) {
      throw AngelHttpException.forbidden();
    }

    req.params['authenticationToken'] = authorizationToken;

    return true;
  }

  Future<bool> _authenticate(RequestContext req, ResponseContext res) async {
    final authorizationToken = req.params['authenticationToken'] as String;
    final q = AuthTokenQuery()..where.token.equals(authorizationToken);

    final authToken = await q.getOne(executor);

    if (authToken == null) {
      throw AngelHttpException.badRequest();
    }

    req.params['authenticatedUser'] = authToken.user;
    req.params['authenticatedClient'] = authToken.client;

    return true;
  }

  RequestHandler get requireAuth => chain([_requireToken, _authenticate]);
}
