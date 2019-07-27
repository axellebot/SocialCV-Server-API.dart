import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:social_cv_api/src/middlewares/authorization_middleware.dart';
import 'package:social_cv_api/src/middlewares/parser_middleware.dart' as parser;
import 'package:social_cv_api/src/models/models.dart';

@Expose('/profiles')
class ProfileController extends Controller {
  // Auto-injected by Angel
  final QueryExecutor executor;
  final AuthorizationMiddleware authMiddleware;

  ProfileController(
    this.executor,
    this.authMiddleware,
  )   : assert(executor != null, 'No $QueryExecutor given'),
        assert(authMiddleware != null, 'No $AuthorizationMiddleware given');

  @override
  FutureOr<void> configureRoutes(Routable routable) {
    routable.all('*', authMiddleware.requireAuth);
  }

  @Expose('', method: 'GET')
  FutureOr<List<Profile>> getAll(User authenticatedUser) async {
    final query = ProfileQuery();
//      // Restrict to public and authenticated user's profiles
//      ..predicate = QueryPredicate(
//          "presentation = @presentation OR owner_id = @ownerId:int8", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final profiles = await query.get(executor);
    return profiles;
  }

  @Expose('', method: 'POST', middleware: [parser.parseProfile])
  FutureOr<Profile> createProfile(
      Profile profile, User authenticatedUser) async {
    final q = ProfileQuery();
//      ..values = profile
//      ..valueMap['owner_id'] = request.authorization.ownerID;

    final newProfile = await q.insert(executor);
    return newProfile;
  }

  @Expose('/:profileId', method: 'GET')
  FutureOr<Profile> getProfile(String profileId, User authenticatedUser) async {
    final query = ProfileQuery()..where.id.equals(profileId);
//      // Restrict to public and authenticated user's profile
//      ..predicate = QueryPredicate(
//          "presentation = @presentation OR owner_id = @ownerId:int8", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final profile = await query.getOne(executor);
    if (profile == null) {
      throw AngelHttpException.notFound();
    }

    return profile;
  }

  @Expose('/:profileId', method: 'PUT', middleware: [parser.parseProfile])
  FutureOr<Profile> updateProfile(
      String profileId, Profile profile, User authenticatedUser) async {
    final q = ProfileQuery()..where.id.equals(profileId);
//      ..values = profile
//      ..where((pr) => pr.id).equalTo(profileId)
//      // Restrict to authenticated user's profile
//      ..where((pr) => pr.owner.id).equalTo(request.authorization.ownerID);

    final updatedProfile = await q.updateOne(executor);
    if (updatedProfile == null) {
      throw AngelHttpException.notFound();
    }

    return updatedProfile;
  }

  @Expose('/:profileId', method: 'DELETE')
  FutureOr<Profile> deleteProfile(
      String profileId, User authenticatedUser) async {
    final q = ProfileQuery()..where.id.equals(profileId);
//      // Restrict to authenticated user's profile
//      ..where((pr) => pr.owner.id).equalTo(request.authorization.ownerID);

    final deletedProfile = await q.deleteOne(executor);
    if (deletedProfile == null) {
      throw AngelHttpException.notFound();
    }

    return deletedProfile;
  }

  @Expose('/:profileId/parts', method: 'GET')
  Future<List<Part>> getParts(String profileId, User authenticatedUser) async {
    final q = PartQuery();
//      ..join(set: (pa) => pa.profilesParts)
//          .join(object: (profilePart) => profilePart.profile)
//          .where((pr) => pr.id)
//          .equalTo(profileId)
//      ..predicate = QueryPredicate(
//          // Restrict to public and authenticated user's parts
//          "(t0.presentation = @presentation OR t0.owner_id = @ownerId:int8)"
//          // Restrict to public and authenticated user's profile
//          "AND (t2.presentation = @presentation OR t2.owner_id = @ownerId:int8)",
//          {
//            "presentation": ElementPresentation.public,
//            "ownerId": request.authorization.ownerID,
//          });

    final parts = await q.get(executor);
    return parts;
  }
}
