import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_api/src/middlewares/authorization_middleware.dart';
import 'package:social_cv_api/src/middlewares/parser_middleware.dart' as parser;
import 'package:social_cv_api/src/models/models.dart';

@Expose('/parts')
class PartController extends Controller {
  // Auto-injected by Angel
  final QueryExecutor executor;
  final AuthorizationMiddleware authMiddleware;

  PartController({
    @required this.executor,
    @required this.authMiddleware,
  })  : assert(executor != null, 'No $QueryExecutor given'),
        assert(authMiddleware != null, 'No $AuthorizationMiddleware given');

  @Expose('', method: 'GET')
  Future<List<Part>> getAll(User authenticatedUser) async {
    final q = PartQuery();
    // Restrict to public and authenticated user's groups
//      ..predicate = QueryPredicate(
//          "presentation = '@presentation' OR owner_id = '@ownerId'", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final parts = await q.get(executor);
    return parts;
  }

  @Expose('', method: 'POST', middleware: [parser.parsePart])
  Future<Part> createPart(Part part, User authenticatedUser) async {
    final q = PartQuery();
//      ..values = part
//      ..valueMap['owner_id'] = request.authorization.ownerID;

    final newPart = await q.insert(executor);
    return newPart;
  }

  @Expose('/:partId', method: 'GET')
  Future<Part> getPart(String partId, User authenticatedUser) async {
    final q = PartQuery()..where.id.equals(partId);
//      // Restrict to public or authenticated user's group
//      ..predicate = QueryPredicate(
//          "presentation = '@presentation' OR owner_id = '@ownerId'", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final part = await q.getOne(executor);
    if (part == null) {
      throw AngelHttpException.notFound();
    }

    return part;
  }

  @Expose('/:partId', method: 'PUT', middleware: [parser.parsePart])
  FutureOr<Part> updatePart(
      String partId, Part part, User authenticatedUser) async {
    final q = PartQuery();
//      ..values = part
//      ..where((pa) => pa.id).equalTo(partId)
//      // Restrict to authenticated user's part
//      ..where((pa) => pa.owner.id).equalTo(request.authorization.ownerID);

    final updatedPart = await q.updateOne(executor);
    if (updatedPart == null) {
      throw AngelHttpException.notFound();
    }

    return updatedPart;
  }

  @Expose('/:partId', method: 'DELETE')
  FutureOr<Part> deletePart(String partId, User authenticatedUser) async {
    final q = PartQuery()..where.id.equals(partId);
//    // Restrict to authenticated user's part
//      ..where((pa) => pa.owner.id).equalTo(request.authorization.ownerID);

    final deletedPart = await q.deleteOne(executor);
    if (deletedPart == null) {
      throw AngelHttpException.notFound();
    }

    return deletedPart;
  }

  @Expose('/:partId/groups', method: 'GET')
  FutureOr<List<Group>> getGroups(String partId, User authenticatedUser) async {
//    final q = PartQuery();
//      ..join(set: (g) => g.partsGroups)
//          .join(object: (partGroup) => partGroup.part)
//          .where((pa) => pa.id)
//          .equalTo(partId)
//      ..predicate = QueryPredicate(
//        // Restrict to public and authenticated user's groups
//          "(t0.presentation = @presentation OR t0.owner_id = @ownerId:int8) "
//          // Restrict to public and authenticated user's part
//              "AND (t2.presentation = @presentation OR t2.owner_id = @ownerId:int8)",
//          {
//            "presentation": ElementPresentation.public,
//            "ownerId": request.authorization.ownerID,
//          });
//
//    List<Group> groups = await q.get(executor);
//    return groups;
  }
}
