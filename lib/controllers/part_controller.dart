import 'package:social_cv_api/social_cv_api.dart';

class PartController extends ResourceController {
  PartController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<Part>(context);
    final parts = await query.fetch();
    return Response.ok(parts);
  }

  @Operation.get("partId")
  Future<Response> getPart(@Bind.path("partId") int id) async {
    final query = Query<Part>(context)..where((o) => o.id).equalTo(id);
    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }

    if (request.authorization.ownerID != id) {
      // Filter out stuff for non-owner of part
    }

    return Response.ok(u);
  }

  @Operation.put("partId")
  Future<Response> updatePart(
      @Bind.path("partId") int id, @Bind.body() Part part) async {
    if (request.authorization.ownerID != id) {
      return Response.unauthorized();
    }

    final query = Query<Part>(context)
      ..values = part
      ..where((o) => o.id).equalTo(id);

    final u = await query.updateOne();
    if (u == null) {
      return Response.notFound();
    }

    return Response.ok(u);
  }

  @Operation.delete("partId")
  Future<Response> deletePart(@Bind.path("partId") int id) async {
    if (request.authorization.ownerID != id) {
      return Response.unauthorized();
    }

    final query = Query<Part>(context)..where((o) => o.id).equalTo(id);
    await authServer.revokeAllGrantsForResourceOwner(id);
    await query.delete();

    return Response.ok(null);
  }
}

class PartGroupsController extends ResourceController {
  PartGroupsController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("partId")
  Future<Response> getGroups(@Bind.path("partId") int partId) async {
    // TODO: filter public
    final query = Query<Part>(context)
      ..where((part) => part.id == partId)
      ..join(set: (part) => part.partsGroups)
          .join(object: (partGroup) => partGroup.group);

    final groups = await query.fetch();
    return Response.ok(groups);
  }
}
