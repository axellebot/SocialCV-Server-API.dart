import 'package:social_cv_api/social_cv_api.dart';

class Part extends ElementManagedObject<_Part> implements _Part {
  @Serialize(input: true, output: true)
  List<int> get profileIds {
    removePropertyFromBackingMap("profilesParts");
    return profilesParts.map((profilePart) => profilePart.profile.id).toList();
  }

  @Serialize(input: true, output: true)
  List<int> get groupIds {
    removePropertyFromBackingMap("partsGroups");
    return partsGroups.map((partGroup) => partGroup.group.id).toList();
  }

  @Serialize(input: true, output: true)
  int get ownerId => owner.id;
}

@Table(name: 'parts')
class _Part extends ElementTableDefinition {
  ManagedSet<ProfilePartJoin> profilesParts;

  ManagedSet<PartGroupJoin> partsGroups;

  @Column()
  String type;

  @override
  @Relate(#parts)
  User owner;
}
