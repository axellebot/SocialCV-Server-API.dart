import 'package:social_cv_api/social_cv_api.dart';

class EntryController extends ResourceController {
  EntryController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<Entry>(context);
    final entries = await query.fetch();
    return Response.ok(entries);
  }

  @Operation.get("entryId")
  Future<Response> getEntry(@Bind.path("entryId") int id) async {
    final query = Query<Entry>(context)..where((o) => o.id).equalTo(id);
    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }

    if (request.authorization.ownerID != id) {
      // Filter out stuff for non-owner of entry
    }

    return Response.ok(u);
  }

  @Operation.put("entryId")
  Future<Response> updateEntry(
      @Bind.path("entryId") int id, @Bind.body() Entry entry) async {
    if (request.authorization.ownerID != id) {
      return Response.unauthorized();
    }

    final query = Query<Entry>(context)
      ..values = entry
      ..where((o) => o.id).equalTo(id);

    final u = await query.updateOne();
    if (u == null) {
      return Response.notFound();
    }

    return Response.ok(u);
  }

  @Operation.delete("entryId")
  Future<Response> deleteEntry(@Bind.path("entryId") int id) async {
    if (request.authorization.ownerID != id) {
      return Response.unauthorized();
    }

    final query = Query<Entry>(context)..where((o) => o.id).equalTo(id);
    await authServer.revokeAllGrantsForResourceOwner(id);
    await query.delete();

    return Response.ok(null);
  }
}
