import 'package:social_cv_api/social_cv_api.dart';

class GroupController extends ResourceController {
  GroupController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<Group>(context)
      // Restrict to public and authenticated user's groups
      ..where((g) =>
          g.presentation == ElementPresentation.public ||
          g.owner.id == request.authorization.ownerID);

    final groups = await query.fetch();
    return Response.ok(groups);
  }

  @Operation.get("groupId")
  Future<Response> getGroup(@Bind.path("groupId") int groupId) async {
    final query = Query<Group>(context)
      ..where((g) => g.id == groupId)
      // Restrict to public or authenticated user's group
      ..where((g) =>
          g.presentation == ElementPresentation.public ||
          g.id == request.authorization.ownerID);

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
      ..where((g) => g.id == groupId)
      // Restrict to authenticated user's group
      ..where((g) => g.owner.id == request.authorization.ownerID);

    final updatedGroup = await query.updateOne();
    if (updatedGroup == null) {
      return Response.notFound();
    }
    return Response.ok(updatedGroup);
  }

  @Operation.delete("groupId")
  Future<Response> deleteGroup(@Bind.path("groupId") int groupId) async {
    final query = Query<Group>(context)
      ..where((g) => g.id == groupId)
      // Restrict to authenticated user's group
      ..where((g) => g.owner.id == request.authorization.ownerID);

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
    final query = Query<Group>(context)
      ..where((g) => g.id == groupId)
      // Restrict to public or authenticated user's group
      ..where((g) =>
          g.presentation == ElementPresentation.public ||
          g.owner.id == request.authorization.ownerID)
      ..join(set: (g) => g.groupsEntries)
          .join(object: (groupEntry) => groupEntry.entry)
      // Restrict to public or authenticated user's entries
      ..where((e) =>
          e.presentation == ElementPresentation.public ||
          e.owner.id == request.authorization.ownerID);

    final entries = await query.fetch();
    return Response.ok(entries);
  }
}
