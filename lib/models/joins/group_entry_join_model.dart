import 'package:social_cv_api/social_cv_api.dart';

class GroupEntryJoin extends ManagedObject<_GroupEntryJoin>
    implements _GroupEntryJoin {}

@Table(name: 'groups_entries')
class _GroupEntryJoin {
  @primaryKey
  int id;

  @Relate(#groupsEntries)
  Group group;

  @Relate(#groupsEntries)
  Entry entry;
}
