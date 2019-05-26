import 'package:social_cv_api/social_cv_api.dart';

class IdentityController extends ResourceController {
  IdentityController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getIdentity() async {
    final q = Query<User>(context)
      ..where((u) => u.id == request.authorization.ownerID);

    final user = await q.fetchOne();
    if (user == null) {
      return Response.notFound();
    }

    return Response.ok(user);
  }
}

class IdentityProfilesController extends ResourceController {
  IdentityProfilesController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getProfiles() async {
    final q = Query<Profile>(context)
      ..where((pr) => pr.owner.id == request.authorization.ownerID);

    final profiles = await q.fetch();
    return Response.ok(profiles);
  }
}

class IdentityPartsController extends ResourceController {
  IdentityPartsController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getParts() async {
    final q = Query<Part>(context)
      ..where((pa) => pa.owner.id == request.authorization.ownerID);

    final parts = await q.fetch();
    return Response.ok(parts);
  }
}

class IdentityGroupsController extends ResourceController {
  IdentityGroupsController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getGroups() async {
    final q = Query<Group>(context)
      ..where((g) => g.owner.id == request.authorization.ownerID);

    final groups = await q.fetch();
    return Response.ok(groups);
  }
}

class IdentityEntriesController extends ResourceController {
  IdentityEntriesController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getEntries() async {
    final q = Query<Entry>(context)
      ..where((e) => e.owner.id == request.authorization.ownerID);

    final entries = await q.fetch();
    return Response.ok(entries);
  }
}
