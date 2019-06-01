import 'package:social_cv_api/social_cv_api.dart';

class User extends ManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

@Table(name: 'users')
class _User implements ResourceOwnerTableDefinition {
  @override
  @primaryKey
  int id;

  /// The username of a resource owner.
  @override
  @Column(unique: true, indexed: true)
  String username;

  @Column(unique: true, indexed: true)
  String email;

  @Column()
  String firstName;

  @Column()
  String lastName;

  /// The hashed password of a resource owner.
  @override
  @Column(omitByDefault: true)
  String hashedPassword;

  /// The salt for [hashedPassword].
  @override
  @Column(omitByDefault: true)
  String salt;

  /// The list of tokens issue for this resource owner.
  @override
  ManagedSet<ManagedAuthToken> tokens;

  ManagedSet<Profile> profiles;
  ManagedSet<Part> parts;
  ManagedSet<Group> groups;
  ManagedSet<Entry> entries;
}
