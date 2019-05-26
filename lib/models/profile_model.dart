import 'package:social_cv_api/social_cv_api.dart';

class Profile extends ElementManagedObject<_Profile> implements _Profile {}

@Table(name: 'profiles')
class _Profile extends ElementTableDefinition {
  @primaryKey
  int id;

  @Column(name: 'title')
  String title;

  @Column(name: 'subtitle')
  String subtitle;

  @Column(name:'tags')
  Document tags;

  ManagedSet<ProfilePartJoin> profilesParts;

  @Relate(#profiles)
  User owner;
}
