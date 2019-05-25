import 'package:social_cv_api/social_cv_api.dart';

class Profile extends BaseManagedObject<_Profile> implements _Profile {}

@Table(name: 'profiles')
class _Profile extends BaseTableDefinition {
  @primaryKey
  int id;

  @Column(name: 'title')
  String title;

  @Column(name: 'subtitle')
  String subtitle;

  ManagedSet<ProfilePartJoin> profileParts;

  @Relate(#profiles)
  User owner;
}
