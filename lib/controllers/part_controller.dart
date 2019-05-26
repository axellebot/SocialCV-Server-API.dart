import 'package:social_cv_api/social_cv_api.dart';

class PartController extends ResourceController {
  PartController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<Part>(context)
      // Restrict to public and authenticated user's groups
      ..where((pa) =>
          pa.presentation == ElementPresentation.public ||
          pa.owner.id == request.authorization.ownerID);

    final parts = await query.fetch();
    return Response.ok(parts);
  }

  @Operation.get("partId")
  Future<Response> getPart(@Bind.path("partId") int partId) async {
    final query = Query<Part>(context)..where((pa) => pa.id == partId);

    final part = await query.fetchOne();
    if (part == null) {
      return Response.notFound();
    }
    return Response.ok(part);
  }

  @Operation.put("partId")
  Future<Response> updatePart(
      @Bind.path("partId") int partId, @Bind.body() Part part) async {
    final query = Query<Part>(context)
      ..values = part
      ..where((pa) => pa.id == partId)
      // Restrict to authenticated user's part
      ..where((pa) => pa.owner.id == request.authorization.ownerID);

    final updatedPart = await query.updateOne();
    if (updatedPart == null) {
      return Response.notFound();
    }
    return Response.ok(updatedPart);
  }

  @Operation.delete("partId")
  Future<Response> deletePart(@Bind.path("partId") int partId) async {
    final query = Query<Part>(context)
      ..where((pa) => pa.id == partId)
      // Restrict to authenticated user's part
      ..where((pa) => pa.owner.id == request.authorization.ownerID);

    final count = await query.delete();
    if (count == 0) {
      return Response.notFound();
    }
    return Response.ok(null);
  }
}

class PartGroupsController extends ResourceController {
  PartGroupsController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("partId")
  Future<Response> getGroups(@Bind.path("partId") int partId) async {
    final query = Query<Part>(context)
      ..where((pa) => pa.id == partId)
      // Restrict to public and authenticated user's part
      ..where((pa) =>
          pa.presentation == ElementPresentation.public ||
          pa.owner.id == request.authorization.ownerID)
      ..join(set: (pa) => pa.partsGroups)
          .join(object: (partGroup) => partGroup.group)
      // Restrict to public and authenticated user's groups
      ..where((g) =>
          g.presentation == ElementPresentation.public ||
          g.owner.id == request.authorization.ownerID);

    final groups = await query.fetch();
    return Response.ok(groups);
  }
}
