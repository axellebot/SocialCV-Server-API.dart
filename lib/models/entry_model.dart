import 'package:social_cv_api/social_cv_api.dart';

class Entry extends BaseManagedObject<_Entry> implements _Entry {}

@Table(name: 'entries')
class _Entry extends BaseTableDefinition {
  @primaryKey
  int id;

  @Column(name:'tags')
  Document tags;

  ManagedSet<GroupEntryJoin> groupsEntries;

  @Column(name:'type')
  String type;

  @Relate(#entries)
  User owner;
}
