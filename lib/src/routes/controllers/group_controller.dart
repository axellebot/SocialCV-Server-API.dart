import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:social_cv_api/src/models/models.dart';

@Expose('/groups')
class GroupController extends Controller {
  // Auto-injected by Angel
  final QueryExecutor executor;

  GroupController(this.executor);

  @Expose('', method: 'GET')
  Future<List<Group>> getAll(User authenticatedUser) async {
    final q = GroupQuery();
    // Restrict to public and authenticated user's groups
//      ..predicate = QueryPredicate(
//          "presentation = '@presentation' OR owner_id = '@ownerId'", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final groups = await q.get(executor);
    return groups;
  }

  @Expose('', method: 'POST')
  Future<Group> createGroup(Group group, User authenticatedUser) async {
    final query = GroupQuery();
//      ..values = group
//      ..valueMap['owner_id'] = request.authorization.ownerID;

    final newGroup = await query.insert(executor);
    return newGroup;
  }

  @Expose('/:groupId', method: 'GET')
  Future<Group> getGroup(String groupId, User authenticatedUser) async {
    final q = GroupQuery()..where.id.equals(groupId);
    // Restrict to public or authenticated user's group
//      ..predicate = QueryPredicate(
//          "presentation = '@presentation' OR owner_id = '@ownerId'", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final group = await q.getOne(executor);
    if (group == null) {
      throw AngelHttpException.notFound();
    }

    return group;
  }

  @Expose('/:groupId', method: 'PUT')
  Future<Group> updateGroup(String groupId, User authenticatedUser) async {
    final q = GroupQuery()..where.id.equals(groupId);
//      ..values = group
//      ..where((g) => g.id).equalTo(groupId)
//      // Restrict to authenticated user's group
//      ..where((g) => g.owner.id).equalTo(request.authorization.ownerID);

    final updatedGroup = await q.updateOne(executor);
    if (updatedGroup == null) {
      throw AngelHttpException.notFound();
    }

    return updatedGroup;
  }

  @Expose('/:groupId', method: 'DELETE')
  Future<Entry> deleteGroup(String groupId, User authenticatedUser) async {
    final q = EntryQuery()..where.id.equals(groupId);
    // Restrict to authenticated user's group
//      ..where((g) => g.owner.id).equalTo(request.authorization.ownerID);

    final deletedEntry = await q.deleteOne(executor);
    if (deletedEntry == null) {
      throw AngelHttpException.notFound();
    }

    return deletedEntry;
  }

  @Expose('/:groupId/entries', method: 'GET')
  Future<List<Entry>> getEntries(String groupId, User authenticatedUser) async {
    final query = EntryQuery();
//      ..join(set: (e) => e.groupsEntries)
//          .join(object: (groupEntry) => groupEntry.group)
//          .where((g) => g.id)
//          .equalTo(groupId)
//      ..predicate = QueryPredicate(
//          // Restrict to public and authenticated user's entries
//          "(t0.presentation = @presentation OR t0.owner_id = @ownerId:int8) "
//          // Restrict to public and authenticated user's group
//          "AND (t2.presentation = @presentation OR t2.owner_id = @ownerId:int8)",
//          {
//            "presentation": ElementPresentation.public,
//            "ownerId": request.authorization.ownerID,
//          });

    final entries = await query.get(executor);
    return entries;
  }
}
