import 'package:social_cv_api/social_cv_api.dart';

class GroupEntryJoin extends ManagedObject<_GroupEntryJoin>
    implements _GroupEntryJoin {}

@Table(name: 'groups_entries')
class _GroupEntryJoin {
  @primaryKey
  int id;

  @Relate(#groupEntries)
  Group group;

  @Relate(#groupEntries)
  Entry entry;
}
