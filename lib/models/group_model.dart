import 'package:social_cv_api/social_cv_api.dart';

class Group extends BaseManagedObject<_Group> implements _Group {}

@Table(name: 'groups')
class _Group extends BaseTableDefinition {
  @uidPrimaryKey
  String id;

  @Column()
  String type;

  ManagedSet<PartGroupJoin> partGroups;

  ManagedSet<GroupEntryJoin> groupEntries;

  @Relate(#groups)
  User owner;
}
