import 'package:social_cv_api/social_cv_api.dart';

class Entry extends ElementManagedObject<_Entry> implements _Entry {
  @Serialize(input: true, output: true)
  List<int> get groupIds {
    removePropertyFromBackingMap("groupsEntries");
    return groupsEntries.map((groupEntry) => groupEntry.group.id).toList();
  }

  @Serialize(input: true, output: true)
  int get ownerId => owner.id;
}

@Table(name: 'entries')
class _Entry extends ElementTableDefinition {
  ManagedSet<GroupEntryJoin> groupsEntries;

  @Column()
  String type;

  @override
  @Relate(#entries)
  User owner;
}
