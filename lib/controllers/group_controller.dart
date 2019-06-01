import 'package:social_cv_api/social_cv_api.dart';

class GroupController extends ResourceController {
  GroupController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<Group>(context)
      // Restrict to public and authenticated user's groups
      ..predicate = QueryPredicate(
          "presentation = '@presentation' OR owner_id = '@ownerId'", {
        "presentation": ElementPresentation.public,
        "ownerId": request.authorization.ownerID,
      });

    final groups = await query.fetch();
    return Response.ok(groups);
  }

  @Operation.get("groupId")
  Future<Response> getGroup(@Bind.path("groupId") int groupId) async {
    final query = Query<Group>(context)
      ..where((g) => g.id).equalTo(groupId)
      // Restrict to public or authenticated user's group
      ..predicate = QueryPredicate(
          "presentation = '@presentation' OR owner_id = '@ownerId'", {
        "presentation": ElementPresentation.public,
        "ownerId": request.authorization.ownerID,
      });

    final group = await query.fetchOne();
    if (group == null) {
      return Response.notFound();
    }
    return Response.ok(group);
  }

  @Operation.put("groupId")
  Future<Response> updateGroup(
      @Bind.path("groupId") int groupId, @Bind.body() Group group) async {
    final query = Query<Group>(context)
      ..values = group
      ..where((g) => g.id).equalTo(groupId)
      // Restrict to authenticated user's group
      ..where((g) => g.owner.id).equalTo(request.authorization.ownerID);

    final updatedGroup = await query.updateOne();
    if (updatedGroup == null) {
      return Response.notFound();
    }
    return Response.ok(updatedGroup);
  }

  @Operation.delete("groupId")
  Future<Response> deleteGroup(@Bind.path("groupId") int groupId) async {
    final query = Query<Group>(context)
      ..where((g) => g.id).equalTo(groupId)
      // Restrict to authenticated user's group
      ..where((g) => g.owner.id).equalTo(request.authorization.ownerID);

    final count = await query.delete();
    if (count == 0) {
      return Response.notFound();
    }
    return Response.ok(null);
  }
}

class GroupEntriesController extends ResourceController {
  GroupEntriesController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("groupId")
  Future<Response> getEntries(@Bind.path("groupId") int groupId) async {
    final query = Query<Entry>(context)
      ..join(set: (e) => e.groupsEntries)
          .join(object: (groupEntry) => groupEntry.group)
          .where((g) => g.id)
          .equalTo(groupId)
      ..predicate = QueryPredicate(
          // Restrict to public and authenticated user's entries
          "(t0.presentation = @presentation OR t0.owner_id = @ownerId:int8) "
          // Restrict to public and authenticated user's group
          "AND (t2.presentation = @presentation OR t2.owner_id = @ownerId:int8)",
          {
            "presentation": ElementPresentation.public,
            "ownerId": request.authorization.ownerID,
          });

    final entries = await query.fetch();
    return Response.ok(entries);
  }
}
