import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_api/src/middlewares/authorization_middleware.dart';
import 'package:social_cv_api/src/models/models.dart';

@Expose('/entries')
class EntryController extends Controller {
  // Auto-injected by Angel
  final QueryExecutor executor;
  final AuthorizationMiddleware authMiddleware;

  EntryController({
    @required this.executor,
    @required this.authMiddleware,
  });

  @Expose('', method: 'GET', middleware: [authMiddleware.requireAuth])
  Future<List<Entry>> getAll(User authenticatedUser) async {
    final q = EntryQuery()
      // Restrict to public and authenticated user's entries
      ..where.presentation.equals(ElementPresentation.public);
//    "ownerId": request.authorization.ownerID,

    final entries = await q.get(executor);
    return entries;
  }

  @Expose('', method: 'POST')
  Future<Entry> createEntry(Entry entry, User authenticatedUser) async {
    final q = EntryQuery()..substitutionValues.addAll(entry.toJson());
//      ..valueMap['owner_id'] = request.authorization.ownerID;

    final newEntry = await q.insert(executor);
    return newEntry;
  }

  @Expose('/:entryId', method: 'GET')
  Future<Entry> getEntry(String entryId, User authenticatedUser) async {
    final q = EntryQuery()..where.id.equals(entryId);
//      ..where((e) => e.id).equalTo(entryId)
//      // Restrict to public or authenticated user's entry
//      ..predicate = QueryPredicate(
//          "presentation = '@presentation' OR owner_id = '@ownerId'", {
//        "presentation": ElementPresentation.public,
//        "ownerId": request.authorization.ownerID,
//      });

    final entry = await q.getOne(executor);
    if (entry == null) {
      throw AngelHttpException.notFound();
    }

    return entry;
  }

  @Expose('/:entryId', method: 'PUT')
  Future<Entry> updateEntry(
      String entryId, Entry entry, User authenticatedUser) async {
    final q = EntryQuery()..where.id.equals(entryId);
//      ..values = entry
//      ..where((e) => e.id).equalTo(entryId)
//      // Restrict to authenticated user's entry
//      ..where((e) => e.owner.id).equalTo(request.authorization.ownerID);

    final updatedEntry = await q.updateOne(executor);
    if (updatedEntry == null) {
      throw AngelHttpException.notFound();
    }

    return updatedEntry;
  }

  @Expose('/:entryId', method: 'DELETE')
  Future<Entry> deleteEntry(String entryId, User authenticatedUser) async {
    final q = EntryQuery()..where.id.equals(entryId);
//      // Restrict to authenticated user's entry
//      ..where((e) => e.owner.id).equalTo(request.authorization.ownerID);

    final deletedEntry = await q.deleteOne(executor);
    if (deletedEntry == null) {
      throw AngelHttpException.notFound();
    }

    return deletedEntry;
  }
}
