import 'package:social_cv_api/social_cv_api.dart';

class Profile extends ElementManagedObject<_Profile> implements _Profile {}

@Table(name: 'profiles')
class _Profile extends ElementTableDefinition {
  @primaryKey
  int id;

  @Column()
  String title;

  @Column()
  String subtitle;

  ManagedSet<ProfilePartJoin> profilesParts;

  @Relate(#profiles)
  User owner;
}
