
import 'package:social_cv_api/social_cv_api.dart';

class User extends ManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

@Table(name: 'users')
class _User extends ResourceOwnerTableDefinition {
  @override
  @primaryKey
  int id;

  @override
  @Column(unique: true, indexed: true)
  String username;

  @Column(unique: true, indexed: true)
  String email;

  @Column()
  String firstName;

  @override
  @Column(omitByDefault: true)
  String hashedPassword;

  @override
  @Column(omitByDefault: true)
  String salt;

  ManagedSet<Profile> profiles;
  ManagedSet<Part> parts;
  ManagedSet<Group> groups;
  ManagedSet<Entry> entries;

  @override
  ManagedSet<ManagedAuthToken> tokens;
}
