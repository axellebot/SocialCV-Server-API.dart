import 'package:social_cv_api/social_cv_api.dart';

class Entry extends BaseManagedObject<_Entry> implements _Entry {}

@Table(name: 'entries')
class _Entry extends BaseTableDefinition {
  @uidPrimaryKey
  String id;

  @Column()
  String type;

  ManagedSet<GroupEntryJoin> groupEntries;

  @Relate(#entries)
  User owner;
}
