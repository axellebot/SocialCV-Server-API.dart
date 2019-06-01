import 'package:social_cv_api/social_cv_api.dart';

class UserController extends ResourceController {
  UserController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<User>(context)
      // Only owner can access user
      ..where((u) => u.id).equalTo(request.authorization.ownerID);

    final users = await query.fetch();
    return Response.ok(users);
  }

  @Operation.get("userId")
  Future<Response> getUser(@Bind.path("userId") int userId) async {
    final query = Query<User>(context)
      ..where((u) => u.id).equalTo(userId)
      // Only owner can access user
      ..where((u) => u.id).equalTo(request.authorization.ownerID);

    final user = await query.fetchOne();
    if (user == null) {
      return Response.notFound();
    }

    return Response.ok(user);
  }

  @Operation.put("userId")
  Future<Response> updateUser(
      @Bind.path("userId") int userId, @Bind.body() User user) async {
    if (request.authorization.ownerID != userId) {
      return Response.unauthorized();
    }

    final query = Query<User>(context)
      ..values = user
      ..where((u) => u.id).equalTo(userId);

    final updatedUser = await query.updateOne();
    if (updatedUser == null) {
      return Response.notFound();
    }

    return Response.ok(updatedUser);
  }

  @Operation.delete("userId")
  Future<Response> deleteUser(@Bind.path("userId") int userId) async {
    if (request.authorization.ownerID != userId) {
      return Response.unauthorized();
    }

    final query = Query<User>(context)..where((u) => u.id).equalTo(userId);
    await authServer.revokeAllGrantsForResourceOwner(userId);

    final count = await query.delete();
    if (count == 0) {
      return Response.notFound();
    }

    return Response.ok(null);
  }
}

class UserProfilesController extends ResourceController {
  UserProfilesController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("userId")
  Future<Response> getProfiles(@Bind.path("userId") int userId) async {
    final query = Query<Profile>(context)
      ..where((pr) => pr.owner.id).equalTo(userId)
      // Restrict to public and authenticated user's profiles
      ..predicate = QueryPredicate(
          "presentation = @presentation OR owner_id = @ownerId:int8", {
        "presentation": ElementPresentation.public,
        "ownerId": request.authorization.ownerID,
      });

    final profiles = await query.fetch();
    return Response.ok(profiles);
  }
}

class UserPartsController extends ResourceController {
  UserPartsController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("userId")
  Future<Response> getParts(@Bind.path("userId") int userId) async {
    final query = Query<Part>(context)
      ..where((pa) => pa.owner.id).equalTo(userId)
      // Restrict to public and authenticated user's parts
      ..predicate = QueryPredicate(
          "presentation = @presentation OR owner_id = @ownerId:int8", {
        "presentation": ElementPresentation.public,
        "ownerId": request.authorization.ownerID,
      });

    final parts = await query.fetch();
    return Response.ok(parts);
  }
}

class UserGroupsController extends ResourceController {
  UserGroupsController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("userId")
  Future<Response> getGroups(@Bind.path("userId") int userId) async {
    final query = Query<Group>(context)
      ..where((g) => g.owner.id).equalTo(userId)
      // Restrict to public and authenticated user's groups
      ..predicate = QueryPredicate(
          "presentation = @presentation OR owner_id = @ownerId:int8", {
        "presentation": ElementPresentation.public,
        "ownerId": request.authorization.ownerID,
      });

    final groups = await query.fetch();
    return Response.ok(groups);
  }
}

class UserEntriesController extends ResourceController {
  UserEntriesController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("userId")
  Future<Response> getEntries(@Bind.path("userId") int userId) async {
    final query = Query<Entry>(context)
      ..where((e) => e.owner.id).equalTo(userId)
      // Restrict to public and authenticated user's groups
      ..predicate = QueryPredicate(
          "presentation = @presentation OR owner_id = @ownerId:int8", {
        "presentation": ElementPresentation.public,
        "ownerId": request.authorization.ownerID,
      });

    final entries = await query.fetch();
    return Response.ok(entries);
  }
}
