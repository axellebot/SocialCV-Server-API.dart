import 'package:social_cv_api/social_cv_api.dart';

class User extends BaseManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

@Table(name: 'users')
class _User extends BaseTableDefinition
    implements ResourceOwnerTableDefinition {
  @override
  @primaryKey
  int id;

  /// The username of a resource owner.
  @override
  @Column(name: 'username', unique: true, indexed: true)
  String username;

  @Column(name: 'email', unique: true, indexed: true)
  String email;

  @Column(name: 'fist_name')
  String firstName;

  @Column(name: 'last_name')
  String lastName;

  /// The hashed password of a resource owner.
  @override
  @Column(name: 'hashed_password', omitByDefault: true)
  String hashedPassword;

  /// The salt for [hashedPassword].
  @override
  @Column(name: 'salt', omitByDefault: true)
  String salt;

  /// The list of tokens issue for this resource owner.
  @override
  ManagedSet<ManagedAuthToken> tokens;

  ManagedSet<Profile> profiles;
  ManagedSet<Part> parts;
  ManagedSet<Group> groups;
  ManagedSet<Entry> entries;
}
