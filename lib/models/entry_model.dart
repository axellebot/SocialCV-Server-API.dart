import 'package:social_cv_api/social_cv_api.dart';

class Entry extends ElementManagedObject<_Entry> implements _Entry {}

@Table(name: 'entries')
class _Entry extends ElementTableDefinition {
  @primaryKey
  int id;

  ManagedSet<GroupEntryJoin> groupsEntries;

  @Column()
  String type;

  @Relate(#entries)
  User owner;
}
