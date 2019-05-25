import 'package:social_cv_api/social_cv_api.dart';

class ProfileController extends ResourceController {
  ProfileController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<Profile>(context);
    final profiles = await query.fetch();
    return Response.ok(profiles);
  }

  @Operation.get("profileId")
  Future<Response> getProfile(@Bind.path("profileId") int id) async {
    final query = Query<Profile>(context)..where((o) => o.id).equalTo(id);
    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }

    if (request.authorization.ownerID != id) {
      // Filter out stuff for non-owner of profile
    }

    return Response.ok(u);
  }

  @Operation.put("profileId")
  Future<Response> updateProfile(
      @Bind.path("profileId") int id, @Bind.body() Profile profile) async {
    if (request.authorization.ownerID != id) {
      return Response.unauthorized();
    }

    final query = Query<Profile>(context)
      ..values = profile
      ..where((o) => o.id).equalTo(id);

    final u = await query.updateOne();
    if (u == null) {
      return Response.notFound();
    }

    return Response.ok(u);
  }

  @Operation.delete("profileId")
  Future<Response> deleteProfile(@Bind.path("profileId") int id) async {
    if (request.authorization.ownerID != id) {
      return Response.unauthorized();
    }

    final query = Query<Profile>(context)..where((o) => o.id).equalTo(id);
    await authServer.revokeAllGrantsForResourceOwner(id);
    await query.delete();

    return Response.ok(null);
  }
}
