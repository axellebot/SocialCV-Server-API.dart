import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_api/src/middlewares/authorization_middleware.dart';
import 'package:social_cv_api/src/models/models.dart';

@Expose('/me')
class IdentityController extends Controller {
  // Auto-injected by Angel
  final QueryExecutor executor;
  final AuthorizationMiddleware authMiddleware;

  IdentityController({
    @required this.executor,
    @required this.authMiddleware,
  })  : assert(executor != null, 'No $QueryExecutor given'),
        assert(authMiddleware != null, 'No $AuthorizationMiddleware given');

  @Expose('', method: 'GET')
  Future<User> getIdentity(User authenticatedUser) async {
    final q = UserQuery()..where.id.equals(authenticatedUser.id);

    final user = await q.getOne(executor);
    return user;
  }

  @Expose('/profiles', method: 'GET')
  Future<List<User>> getProfiles(User authenticatedUser) async {
    final q = UserQuery()..where.id.equals(authenticatedUser.id);

    final profiles = await q.get(executor);
    return profiles;
  }

  @Expose('/parts', method: 'GET')
  Future<List<Part>> getParts(User authenticatedUser) async {
    final q = PartQuery()..where.id.equals(authenticatedUser.id);

    final parts = await q.get(executor);
    return parts;
  }

  @Expose('/groups', method: 'GET')
  Future<List<Group>> getGroups(User authenticatedUser) async {
    final q = GroupQuery()..where.id.equals(authenticatedUser.id);

    final groups = await q.get(executor);
    return groups;
  }

  @Expose('/entries', method: 'GET')
  Future<void> getEntries(User authenticatedUser) async {
    final q = EntryQuery()..where.id.equals(authenticatedUser.id);

    final entries = await q.get(executor);
    return entries;
  }
}
