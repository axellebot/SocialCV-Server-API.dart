import 'package:social_cv_api/social_cv_api.dart';

class ProfileController extends ResourceController {
  ProfileController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<Profile>(context)
      // Restrict to public and authenticated user's profiles
      ..predicate = QueryPredicate(
          "presentation = @presentation OR owner_id = @ownerId:int8", {
        "presentation": ElementPresentation.public,
        "ownerId": request.authorization.ownerID,
      });

    final profiles = await query.fetch();
    return Response.ok(profiles);
  }

  @Operation.get("profileId")
  Future<Response> getProfile(@Bind.path("profileId") int profileId) async {
    final query = Query<Profile>(context)
      ..where((pr) => pr.id).equalTo(profileId)
      // Restrict to public and authenticated user's profile
      ..predicate = QueryPredicate(
          "presentation = @presentation OR owner_id = @ownerId:int8", {
        "presentation": ElementPresentation.public,
        "ownerId": request.authorization.ownerID,
      });

    final profile = await query.fetchOne();
    if (profile == null) {
      return Response.notFound();
    }

    return Response.ok(profile);
  }

  @Operation.put("profileId")
  Future<Response> updateProfile(@Bind.path("profileId") int profileId,
      @Bind.body() Profile profile) async {
    final query = Query<Profile>(context)
      ..values = profile
      ..where((pr) => pr.id).equalTo(profileId)
      // Restrict to authenticated user's profile
      ..where((pr) => pr.owner.id).equalTo(request.authorization.ownerID);

    final updatedProfile = await query.updateOne();
    if (updatedProfile == null) {
      return Response.notFound();
    }
    return Response.ok(updatedProfile);
  }

  @Operation.delete("profileId")
  Future<Response> deleteProfile(@Bind.path("profileId") int profileId) async {
    final query = Query<Profile>(context)
      ..where((pr) => pr.id).equalTo(profileId)
      // Restrict to authenticated user's profile
      ..where((pr) => pr.owner.id).equalTo(request.authorization.ownerID);

    final count = await query.delete();
    if (count == 0) {
      return Response.notFound();
    }
    return Response.ok(null);
  }
}

class ProfilePartsController extends ResourceController {
  ProfilePartsController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("profileId")
  Future<Response> getParts(@Bind.path("profileId") int profileId) async {
    final query = Query<Part>(context)
      ..join(set: (pa) => pa.profilesParts)
          .join(object: (profilePart) => profilePart.profile)
          .where((pr) => pr.id)
          .equalTo(profileId)
      ..predicate = QueryPredicate(
          // Restrict to public and authenticated user's parts
          "(t0.presentation = @presentation OR t0.owner_id = @ownerId:int8)"
          // Restrict to public and authenticated user's profile
          "AND (t2.presentation = @presentation OR t2.owner_id = @ownerId:int8)",
          {
            "presentation": ElementPresentation.public,
            "ownerId": request.authorization.ownerID,
          });

    final parts = await query.fetch();
    return Response.ok(parts);
  }
}
