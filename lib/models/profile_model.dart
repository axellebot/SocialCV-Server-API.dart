import 'package:social_cv_api/social_cv_api.dart';

class Profile extends BaseManagedObject<_Profile> implements _Profile {}

@Table(name: 'profiles')
class _Profile extends BaseTableDefinition {
  @uidPrimaryKey
  String id;

  @Column()
  String title;

  @Column()
  String subtitle;

  ManagedSet<ProfilePartJoin> profileParts;

  @Relate(#profiles)
  User owner;
}
