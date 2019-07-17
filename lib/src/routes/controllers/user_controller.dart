import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:social_cv_api/src/models/models.dart';

@Expose('/users')
class UserController extends Controller {
  // Auto-injected by Angel
  final QueryExecutor executor;

  UserController(this.executor);

  @Expose('', method: 'GET')
  FutureOr<List<User>> getAll(User authenticatedUser) async {
    final q = UserQuery();
//      // Only owner can access user
//      ..where((u) => u.id).equalTo(request.authorization.ownerID);

    final users = await q.get(executor);
    return users;
  }

  @Expose('/:userId', method: 'GET')
  FutureOr<User> getUser(String userId, User authenticatedUser) async {
    final q = UserQuery()..where.id.equals(userId);
//      // Only owner can access user
//      ..where((u) => u.id).equalTo(request.authorization.ownerID);

    final user = await q.getOne(executor);
    if (user == null) {
      throw AngelHttpException.notFound();
    }

    return user;
  }

  @Expose('/:userId', method: 'PUT')
  FutureOr<User> updateUser(
      String userId, User user, User authenticatedUser) async {
//    if (request.authorization.ownerID != userId) {
//      return Response.unauthorized();
//    }

    final query = UserQuery()..where.id.equals(userId);
//      ..values = user
//      ..where((u) => u.id).equalTo(userId);

    final updatedUser = await query.updateOne(executor);
    if (updatedUser == null) {
      throw AngelHttpException.notFound();
    }

    return updatedUser;
  }

  @Expose('/:userId', method: 'DELETE')
  FutureOr<User> deleteUser(String userId, User authenticatedUser) async {
//    if (request.authorization.ownerID != userId) {
//      return Response.unauthorized();
//    }

    final q = UserQuery()..where.id.equals(userId);
//    await authServer.revokeAllGrantsForResourceOwner(userId);

    final deletedUser = await q.deleteOne(executor);
    if (deletedUser == null) {
      throw AngelHttpException.notFound();
    }

    return deletedUser;
  }

  @Expose('/:userId/profiles', method: 'GET')
  FutureOr<List<Profile>> getProfiles(
      String userId, User authenticatedUser) async {
    final q = ProfileQuery();
//      ..where((pr) => pr.owner.id).equalTo(userId)
//      // Restrict to public and authenticated user's profiles
//      ..predicate = QueryPredicate(
//          "presentation = @presentation OR owner_id = @ownerId:int8", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final profiles = await q.get(executor);
    return profiles;
  }

  @Expose('/:userId/parts', method: 'GET')
  FutureOr<List<Part>> getParts(String userId, User authenticatedUser) async {
    final q = PartQuery()..where.id.equals(userId);
//      // Restrict to public and authenticated user's parts
//      ..predicate = QueryPredicate(
//          "presentation = @presentation OR owner_id = @ownerId:int8", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final parts = await q.get(executor);
    return parts;
  }

  @Expose('/:userId/groups', method: 'GET')
  FutureOr<List<Group>> getGroups(String userId, User authenticatedUser) async {
    final q = GroupQuery()..where.id.equals(userId);
//
//    // Restrict to public and authenticated user's groups
//      ..predicate = QueryPredicate(
//          "presentation = @presentation OR owner_id = @ownerId:int8", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final groups = await q.get(executor);
    return groups;
  }

  @Expose('/:userId/entries', method: 'GET')
  Future<List<Entry>> getEntries(String userId, User authenticatedUser) async {
    final q = EntryQuery()..where.id.equals(userId);
//      // Restrict to public and authenticated user's groups
//      ..predicate = QueryPredicate(
//          "presentation = @presentation OR owner_id = @ownerId:int8", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final entries = await q.get(executor);
    return entries;
  }
}
