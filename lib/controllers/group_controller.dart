import 'package:social_cv_api/social_cv_api.dart';

class GroupController extends ResourceController {
  GroupController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<Group>(context);
    final groups = await query.fetch();
    return Response.ok(groups);
  }

  @Operation.get("groupId")
  Future<Response> getGroup(@Bind.path("groupId") int id) async {
    final query = Query<Group>(context)..where((o) => o.id).equalTo(id);
    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }

    if (request.authorization.ownerID != id) {
      // Filter out stuff for non-owner of group
    }

    return Response.ok(u);
  }

  @Operation.put("groupId")
  Future<Response> updateGroup(
      @Bind.path("groupId") int id, @Bind.body() Group group) async {
    if (request.authorization.ownerID != id) {
      return Response.unauthorized();
    }

    final query = Query<Group>(context)
      ..values = group
      ..where((o) => o.id).equalTo(id);

    final u = await query.updateOne();
    if (u == null) {
      return Response.notFound();
    }

    return Response.ok(u);
  }

  @Operation.delete("groupId")
  Future<Response> deleteGroup(@Bind.path("groupId") int id) async {
    if (request.authorization.ownerID != id) {
      return Response.unauthorized();
    }

    final query = Query<Group>(context)..where((o) => o.id).equalTo(id);
    await authServer.revokeAllGrantsForResourceOwner(id);
    await query.delete();

    return Response.ok(null);
  }
}

class GroupEntriesController extends ResourceController {
  GroupEntriesController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("groupId")
  Future<Response> getEntries(@Bind.path("groupId") int groupId) async {
    // TODO: filter public
    final query = Query<Group>(context)
      ..where((group) => group.id == groupId)
      ..join(set: (group) => group.groupsEntries)
          .join(object: (groupEntry) => groupEntry.entry);

    final entries = await query.fetch();
    return Response.ok(entries);
  }
}
