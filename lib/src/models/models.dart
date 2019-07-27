library social_cv_api.src.models;

import 'package:angel_migration/angel_migration.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:angel_serialize/angel_serialize.dart';
import 'package:dbcrypt/dbcrypt.dart';

part 'models.g.dart';

final DBCrypt bCrypt = DBCrypt();

class _Model {
  /// A unique identifier corresponding to this item.
  @primaryKey
  String id;

  /// The time at which this item was created.
  @Column(type: ColumnType.timeStampWithTimeZone)
  DateTime createdAt;

  /// The last time at which this item was updated.
  @Column(type: ColumnType.timeStampWithTimeZone)
  DateTime updatedAt;
}

@serializable
@Orm(tableName: 'users', generateMigrations: true)
class _User extends _Model {
  /// The username of the user.
  String username;

  /// The email of the user.
  String email;

  /// The first name of the user
  String firstName;

  /// The last name of the user
  String lastName;

  /// The plain text password of the user (should not be in the outputs)
  @SerializableField(canSerialize: false, canDeserialize: true)
  String password;

  /// The encrypted password of the user.
  @SerializableField(canSerialize: false, canDeserialize: false)
  String encryptedPassword;

  /// OAuth 2.0
  /// The list of tokens issue for this user.
  @HasMany(localKey: 'id', foreignKey: 'user_id', cascadeOnDelete: true)
  List<_AuthToken> tokens;

  /// OAuth 2.0
  /// The list of authentication code issue for this user.
  @HasMany(localKey: 'id', foreignKey: 'user_id', cascadeOnDelete: true)
  List<_AuthCode> authCodes;

  @HasMany(localKey: 'id', foreignKey: 'owner_id', cascadeOnDelete: true)
  List<_Profile> profiles;

  @HasMany(localKey: 'id', foreignKey: 'owner_id', cascadeOnDelete: true)
  List<_Part> parts;

  @HasMany(localKey: 'id', foreignKey: 'owner_id', cascadeOnDelete: true)
  List<_Group> groups;

  @HasMany(localKey: 'id', foreignKey: 'owner_id', cascadeOnDelete: true)
  List<_Entry> entries;

  bool validatePassword(String pw) => bCrypt.checkpw(pw, encryptedPassword);
}

enum ElementPresentation {
  private,
  public,
}

/// ----------------------------------------------------------------------------
///                                  Elements
/// ----------------------------------------------------------------------------

abstract class _Element extends _Model {
  ElementPresentation presentation;

  List tags;

  @HasOne(foreignKey: 'owner_id')
  _User owner;

  int version;
}

@serializable
@Orm(tableName: 'profiles', generateMigrations: true)
class _Profile extends _Element {
  String title;

  String subtitle;

  @ManyToMany(_ProfilePartJoin)
  List<_Part> parts;
}

@serializable
@Orm(tableName: 'parts', generateMigrations: true)
class _Part extends _Element {
  @ManyToMany(_ProfilePartJoin)
  List<_Profile> profiles;

  @ManyToMany(_PartGroupJoin)
  List<_Group> groups;

  String type;
}

@serializable
@Orm(tableName: 'groups', generateMigrations: true)
class _Group extends _Element {
  @ManyToMany(_PartGroupJoin)
  List<_Part> parts;

  @ManyToMany(_GroupEntryJoin)
  List<_Entry> entries;

  String type;
}

@serializable
@Orm(tableName: 'entries', generateMigrations: true)
class _Entry extends _Element {
  @ManyToMany(_GroupEntryJoin)
  List<_Entry> entries;

  String type;
}

/// ----------------------------------------------------------------------------
///                                Element Pivots
/// ----------------------------------------------------------------------------

@serializable
@Orm(tableName: 'profiles_parts', generateMigrations: true)
class _ProfilePartJoin {
  @belongsTo
  _Profile profile;

  @belongsTo
  _Part part;
}

@serializable
@Orm(tableName: 'parts_groups', generateMigrations: true)
class _PartGroupJoin {
  @belongsTo
  _Part part;

  @belongsTo
  _Group group;
}

@serializable
@Orm(tableName: 'groups_entries', generateMigrations: true)
class _GroupEntryJoin {
  @belongsTo
  _Group group;

  @belongsTo
  _Entry entry;
}

/// ----------------------------------------------------------------------------
///                                 OAuth 2.0
/// ----------------------------------------------------------------------------

@serializable
@Orm(tableName: 'clients', generateMigrations: true)
class _Client extends _Model {
  String randomId;

  @SerializableField(canSerialize: false)
  String secret;

  String encryptedSecret;

  List redirectUris;

  List allowedGrantTypes;

  @HasMany(cascadeOnDelete: true)
  List<_AuthToken> accessTokens;

  @HasMany(cascadeOnDelete: true)
  List<_AuthCode> authCodes;

  bool validatePassword(String secret) =>
      bCrypt.checkpw(secret, encryptedSecret);
}

@serializable
class _Token extends _Model {
  String token;

  String scope;

  @Column(type: ColumnType.timeStampWithTimeZone)
  DateTime expireAt;

  @HasOne(cascadeOnDelete: false)
  _User user;

  @HasOne(cascadeOnDelete: false)
  _Client client;

  bool get isExpired => DateTime.now().isAfter(expireAt);

  int get expiresIn => expireAt.compareTo(DateTime.now());

  bool validateScope(String scope) {
    return this.scope == scope;
  }
}

@serializable
@Orm(tableName: 'auth_tokens', generateMigrations: true)
class _AuthToken extends _Token {
  String refreshToken;
}

@serializable
@Orm(tableName: 'auth_codes', generateMigrations: true)
class _AuthCode extends _Token {
  String redirectUri;
}
