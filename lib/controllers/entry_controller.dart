import 'package:social_cv_api/social_cv_api.dart';

class EntryController extends ResourceController {
  EntryController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<Entry>(context)
      // Restrict to public and authenticated user's entries
      ..where((e) =>
          e.presentation == ElementPresentation.public ||
          e.owner.id == request.authorization.ownerID);

    final entries = await query.fetch();
    return Response.ok(entries);
  }

  @Operation.get("entryId")
  Future<Response> getEntry(@Bind.path("entryId") int entryId) async {
    final query = Query<Entry>(context)
      ..where((e) => e.id == entryId)
      // Restrict to public or authenticated user's entry
      ..where((e) =>
          e.presentation == ElementPresentation.public ||
          e.owner.id == request.authorization.ownerID);

    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }
    return Response.ok(u);
  }

  @Operation.put("entryId")
  Future<Response> updateEntry(
      @Bind.path("entryId") int entryId, @Bind.body() Entry entry) async {
    final query = Query<Entry>(context)
      ..values = entry
      ..where((e) => e.id == entryId)
      // Restrict to authenticated user's entry
      ..where((e) => e.owner.id == request.authorization.ownerID);

    final updatedEntry = await query.updateOne();
    if (updatedEntry == null) {
      return Response.notFound();
    }
    return Response.ok(updatedEntry);
  }

  @Operation.delete("entryId")
  Future<Response> deleteEntry(@Bind.path("entryId") int entryId) async {
    final query = Query<Entry>(context)
      ..where((e) => e.id == entryId)
      // Restrict to authenticated user's entry
      ..where((e) => e.owner.id == request.authorization.ownerID);

    final count = await query.delete();
    if (count == 0) {
      return Response.notFound();
    }
    return Response.ok(null);
  }
}
