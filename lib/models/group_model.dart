import 'package:social_cv_api/social_cv_api.dart';

class Group extends ElementManagedObject<_Group> implements _Group {}

@Table(name: 'groups')
class _Group extends ElementTableDefinition {
  @primaryKey
  int id;

  @Column(name:'tags')
  Document tags;

  ManagedSet<PartGroupJoin> partsGroups;

  ManagedSet<GroupEntryJoin> groupsEntries;

  @Column(name:'type')
  String type;

  @Relate(#groups)
  User owner;
}
