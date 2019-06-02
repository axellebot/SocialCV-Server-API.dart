import 'package:social_cv_api/social_cv_api.dart';

class Group extends ElementManagedObject<_Group> implements _Group {
  @Serialize(input: true, output: true)
  List<int> get partIds {
    removePropertyFromBackingMap('partsGroups');
    return partsGroups.map((partGroup) => partGroup.part.id).toList();
  }

  @Serialize(input: true, output: true)
  List<int> get entryIds {
    removePropertyFromBackingMap('groupsEntries');
    return groupsEntries.map((groupEntry) => groupEntry.entry.id).toList();
  }

  @Serialize(input: true, output: true)
  int get ownerId => owner.id;
}

@Table(name: 'groups')
class _Group extends ElementTableDefinition {
  ManagedSet<PartGroupJoin> partsGroups;

  ManagedSet<GroupEntryJoin> groupsEntries;

  @Column()
  String type;

  @override
  @Relate(#groups)
  User owner;
}
