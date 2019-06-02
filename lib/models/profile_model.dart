import 'package:social_cv_api/social_cv_api.dart';

class Profile extends ElementManagedObject<_Profile> implements _Profile {
  @Serialize(input: true, output: true)
  List<int> get partIds {
    removePropertyFromBackingMap("profilesParts");
    return profilesParts.map((profilePart) => profilePart.part.id).toList();
  }

  @Serialize(input: true, output: true)
  int ownerId;
}

@Table(name: 'profiles')
class _Profile extends ElementTableDefinition {
  @Column()
  String title;

  @Column()
  String subtitle;

  ManagedSet<ProfilePartJoin> profilesParts;

  @override
  @Relate(#profiles)
  User owner;
}
