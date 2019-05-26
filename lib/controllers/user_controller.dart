import 'package:social_cv_api/social_cv_api.dart';

class UserController extends ResourceController {
  UserController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<User>(context);
    final users = await query.fetch();
    return Response.ok(users);
  }

  @Operation.get("userId")
  Future<Response> getUser(@Bind.path("userId") int userId) async {
    final query = Query<User>(context)..where((o) => o.id).equalTo(userId);
    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }

    if (request.authorization.ownerID != userId) {
      // Filter out stuff for non-owner of user
    }

    return Response.ok(u);
  }

  @Operation.put("userId")
  Future<Response> updateUser(
      @Bind.path("userId") int userId, @Bind.body() User user) async {
    if (request.authorization.ownerID != userId) {
      return Response.unauthorized();
    }

    final query = Query<User>(context)
      ..values = user
      ..where((o) => o.id).equalTo(userId);

    final u = await query.updateOne();
    if (u == null) {
      return Response.notFound();
    }

    return Response.ok(u);
  }

  @Operation.delete("userId")
  Future<Response> deleteUser(@Bind.path("userId") int userId) async {
    if (request.authorization.ownerID != userId) {
      return Response.unauthorized();
    }

    final query = Query<User>(context)..where((o) => o.id).equalTo(userId);
    await authServer.revokeAllGrantsForResourceOwner(userId);
    await query.delete();

    return Response.ok(null);
  }
}

class UserProfilesController extends ResourceController {
  UserProfilesController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.get("userId")
  Future<Response> getProfiles(@Bind.path("userId") int userId) async {
    final query = Query<Profile>(context)..where((p) => p.owner.id == userId);

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
    final query = Query<Part>(context)..where((p) => p.owner.id == userId);

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
    final query = Query<Group>(context)..where((g) => g.owner.id == userId);

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
    final query = Query<Entry>(context)..where((e) => e.owner.id == userId);

    final entries = await query.fetch();
    return Response.ok(entries);
  }
}
