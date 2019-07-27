// GENERATED CODE - DO NOT MODIFY BY HAND

part of social_cv_api.src.models;

// **************************************************************************
// MigrationGenerator
// **************************************************************************

class UserMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('users', (table) {
      table.varChar('id')..primaryKey();
      table.declare('created_at', ColumnType('timestamp with time zone'));
      table.declare('updated_at', ColumnType('timestamp with time zone'));
      table.varChar('username');
      table.varChar('email');
      table.varChar('first_name');
      table.varChar('last_name');
      table.varChar('password');
      table.varChar('encrypted_password');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('users', cascade: true);
  }
}

class ProfileMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('profiles', (table) {
      table.varChar('id')..primaryKey();
      table.declare('created_at', ColumnType('timestamp with time zone'));
      table.declare('updated_at', ColumnType('timestamp with time zone'));
      table.integer('presentation');
      table.declare('tags', ColumnType('jsonb'));
      table.integer('version');
      table.varChar('title');
      table.varChar('subtitle');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('profiles', cascade: true);
  }
}

class PartMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('parts', (table) {
      table.varChar('id')..primaryKey();
      table.declare('created_at', ColumnType('timestamp with time zone'));
      table.declare('updated_at', ColumnType('timestamp with time zone'));
      table.integer('presentation');
      table.declare('tags', ColumnType('jsonb'));
      table.integer('version');
      table.varChar('type');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('parts', cascade: true);
  }
}

class GroupMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('groups', (table) {
      table.varChar('id')..primaryKey();
      table.declare('created_at', ColumnType('timestamp with time zone'));
      table.declare('updated_at', ColumnType('timestamp with time zone'));
      table.integer('presentation');
      table.declare('tags', ColumnType('jsonb'));
      table.integer('version');
      table.varChar('type');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('groups', cascade: true);
  }
}

class EntryMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('entries', (table) {
      table.varChar('id')..primaryKey();
      table.declare('created_at', ColumnType('timestamp with time zone'));
      table.declare('updated_at', ColumnType('timestamp with time zone'));
      table.integer('presentation');
      table.declare('tags', ColumnType('jsonb'));
      table.integer('version');
      table.varChar('type');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('entries', cascade: true);
  }
}

class ProfilePartJoinMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('profile_part_joins', (table) {
      table
          .declare('profile_id', ColumnType('varchar'))
          .references('profiles', 'id');
      table.declare('part_id', ColumnType('varchar')).references('parts', 'id');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('profile_part_joins');
  }
}

class PartGroupJoinMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('part_group_joins', (table) {
      table.declare('part_id', ColumnType('varchar')).references('parts', 'id');
      table
          .declare('group_id', ColumnType('varchar'))
          .references('groups', 'id');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('part_group_joins');
  }
}

class GroupEntryJoinMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('group_entry_joins', (table) {
      table
          .declare('group_id', ColumnType('varchar'))
          .references('groups', 'id');
      table
          .declare('entry_id', ColumnType('varchar'))
          .references('entries', 'id');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('group_entry_joins');
  }
}

class ClientMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('clients', (table) {
      table.varChar('id')..primaryKey();
      table.declare('created_at', ColumnType('timestamp with time zone'));
      table.declare('updated_at', ColumnType('timestamp with time zone'));
      table.varChar('random_id');
      table.varChar('secret');
      table.varChar('encrypted_secret');
      table.declare('redirect_uris', ColumnType('jsonb'));
      table.declare('allowed_grant_types', ColumnType('jsonb'));
    });
  }

  @override
  down(Schema schema) {
    schema.drop('clients', cascade: true);
  }
}

class AuthTokenMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('auth_tokens', (table) {
      table.varChar('id')..primaryKey();
      table.declare('created_at', ColumnType('timestamp with time zone'));
      table.declare('updated_at', ColumnType('timestamp with time zone'));
      table.varChar('token');
      table.varChar('scope');
      table.declare('expire_at', ColumnType('timestamp with time zone'));
      table.varChar('refresh_token');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('auth_tokens', cascade: true);
  }
}

class AuthCodeMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('auth_codes', (table) {
      table.varChar('id')..primaryKey();
      table.declare('created_at', ColumnType('timestamp with time zone'));
      table.declare('updated_at', ColumnType('timestamp with time zone'));
      table.varChar('token');
      table.varChar('scope');
      table.declare('expire_at', ColumnType('timestamp with time zone'));
      table.varChar('redirect_uri');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('auth_codes', cascade: true);
  }
}

// **************************************************************************
// OrmGenerator
// **************************************************************************

class UserQuery extends Query<User, UserQueryWhere> {
  UserQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = UserQueryWhere(this);
    leftJoin(AuthTokenQuery(trampoline: trampoline), 'id', 'user_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'token',
          'scope',
          'expire_at',
          'refresh_token'
        ],
        trampoline: trampoline);
    leftJoin(AuthCodeQuery(trampoline: trampoline), 'id', 'user_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'token',
          'scope',
          'expire_at',
          'redirect_uri'
        ],
        trampoline: trampoline);
    leftJoin(ProfileQuery(trampoline: trampoline), 'id', 'owner_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'title',
          'subtitle'
        ],
        trampoline: trampoline);
    leftJoin(PartQuery(trampoline: trampoline), 'id', 'owner_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
    leftJoin(GroupQuery(trampoline: trampoline), 'id', 'owner_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
    leftJoin(EntryQuery(trampoline: trampoline), 'id', 'owner_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
  }

  @override
  final UserQueryValues values = UserQueryValues();

  UserQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'users';
  }

  @override
  get fields {
    return const [
      'id',
      'created_at',
      'updated_at',
      'username',
      'email',
      'first_name',
      'last_name',
      'password',
      'encrypted_password'
    ];
  }

  @override
  UserQueryWhere get where {
    return _where;
  }

  @override
  UserQueryWhere newWhereClause() {
    return UserQueryWhere(this);
  }

  static User parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = User(
        id: (row[0] as String),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        username: (row[3] as String),
        email: (row[4] as String),
        firstName: (row[5] as String),
        lastName: (row[6] as String),
        password: (row[7] as String),
        encryptedPassword: (row[8] as String));
    if (row.length > 9) {
      model = model.copyWith(
          tokens: [AuthTokenQuery.parseRow(row.skip(9).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    if (row.length > 16) {
      model = model.copyWith(
          authCodes: [AuthCodeQuery.parseRow(row.skip(16).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    if (row.length > 23) {
      model = model.copyWith(
          profiles: [ProfileQuery.parseRow(row.skip(23).take(8).toList())]
              .where((x) => x != null)
              .toList());
    }
    if (row.length > 31) {
      model = model.copyWith(
          parts: [PartQuery.parseRow(row.skip(31).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    if (row.length > 38) {
      model = model.copyWith(
          groups: [GroupQuery.parseRow(row.skip(38).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    if (row.length > 45) {
      model = model.copyWith(
          entries: [EntryQuery.parseRow(row.skip(45).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }

  @override
  get(QueryExecutor executor) {
    return super.get(executor).then((result) {
      return result.fold<List<User>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                tokens: List<_AuthToken>.from(l.tokens ?? [])
                  ..addAll(model.tokens ?? []),
                authCodes: List<_AuthCode>.from(l.authCodes ?? [])
                  ..addAll(model.authCodes ?? []),
                profiles: List<_Profile>.from(l.profiles ?? [])
                  ..addAll(model.profiles ?? []),
                parts: List<_Part>.from(l.parts ?? [])
                  ..addAll(model.parts ?? []),
                groups: List<_Group>.from(l.groups ?? [])
                  ..addAll(model.groups ?? []),
                entries: List<_Entry>.from(l.entries ?? [])
                  ..addAll(model.entries ?? []));
        }
      });
    });
  }

  @override
  update(QueryExecutor executor) {
    return super.update(executor).then((result) {
      return result.fold<List<User>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                tokens: List<_AuthToken>.from(l.tokens ?? [])
                  ..addAll(model.tokens ?? []),
                authCodes: List<_AuthCode>.from(l.authCodes ?? [])
                  ..addAll(model.authCodes ?? []),
                profiles: List<_Profile>.from(l.profiles ?? [])
                  ..addAll(model.profiles ?? []),
                parts: List<_Part>.from(l.parts ?? [])
                  ..addAll(model.parts ?? []),
                groups: List<_Group>.from(l.groups ?? [])
                  ..addAll(model.groups ?? []),
                entries: List<_Entry>.from(l.entries ?? [])
                  ..addAll(model.entries ?? []));
        }
      });
    });
  }

  @override
  delete(QueryExecutor executor) {
    return super.delete(executor).then((result) {
      return result.fold<List<User>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                tokens: List<_AuthToken>.from(l.tokens ?? [])
                  ..addAll(model.tokens ?? []),
                authCodes: List<_AuthCode>.from(l.authCodes ?? [])
                  ..addAll(model.authCodes ?? []),
                profiles: List<_Profile>.from(l.profiles ?? [])
                  ..addAll(model.profiles ?? []),
                parts: List<_Part>.from(l.parts ?? [])
                  ..addAll(model.parts ?? []),
                groups: List<_Group>.from(l.groups ?? [])
                  ..addAll(model.groups ?? []),
                entries: List<_Entry>.from(l.entries ?? [])
                  ..addAll(model.entries ?? []));
        }
      });
    });
  }
}

class UserQueryWhere extends QueryWhere {
  UserQueryWhere(UserQuery query)
      : id = StringSqlExpressionBuilder(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        username = StringSqlExpressionBuilder(query, 'username'),
        email = StringSqlExpressionBuilder(query, 'email'),
        firstName = StringSqlExpressionBuilder(query, 'first_name'),
        lastName = StringSqlExpressionBuilder(query, 'last_name'),
        password = StringSqlExpressionBuilder(query, 'password'),
        encryptedPassword =
            StringSqlExpressionBuilder(query, 'encrypted_password');

  final StringSqlExpressionBuilder id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final StringSqlExpressionBuilder username;

  final StringSqlExpressionBuilder email;

  final StringSqlExpressionBuilder firstName;

  final StringSqlExpressionBuilder lastName;

  final StringSqlExpressionBuilder password;

  final StringSqlExpressionBuilder encryptedPassword;

  @override
  get expressionBuilders {
    return [
      id,
      createdAt,
      updatedAt,
      username,
      email,
      firstName,
      lastName,
      password,
      encryptedPassword
    ];
  }
}

class UserQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  String get username {
    return (values['username'] as String);
  }

  set username(String value) => values['username'] = value;
  String get email {
    return (values['email'] as String);
  }

  set email(String value) => values['email'] = value;
  String get firstName {
    return (values['first_name'] as String);
  }

  set firstName(String value) => values['first_name'] = value;
  String get lastName {
    return (values['last_name'] as String);
  }

  set lastName(String value) => values['last_name'] = value;
  String get password {
    return (values['password'] as String);
  }

  set password(String value) => values['password'] = value;
  String get encryptedPassword {
    return (values['encrypted_password'] as String);
  }

  set encryptedPassword(String value) => values['encrypted_password'] = value;
  void copyFrom(User model) {
    id = model.id;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    username = model.username;
    email = model.email;
    firstName = model.firstName;
    lastName = model.lastName;
    password = model.password;
    encryptedPassword = model.encryptedPassword;
  }
}

class ProfileQuery extends Query<Profile, ProfileQueryWhere> {
  ProfileQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = ProfileQueryWhere(this);
    leftJoin('users', 'id', 'owner_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'username',
          'email',
          'first_name',
          'last_name',
          'password',
          'encrypted_password'
        ],
        trampoline: trampoline);
    leftJoin(ProfilePartJoinQuery(trampoline: trampoline), 'id', 'profile_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
  }

  @override
  final ProfileQueryValues values = ProfileQueryValues();

  ProfileQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'profiles';
  }

  @override
  get fields {
    return const [
      'id',
      'created_at',
      'updated_at',
      'presentation',
      'tags',
      'version',
      'title',
      'subtitle'
    ];
  }

  @override
  ProfileQueryWhere get where {
    return _where;
  }

  @override
  ProfileQueryWhere newWhereClause() {
    return ProfileQueryWhere(this);
  }

  static Profile parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = Profile(
        id: (row[0] as String),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        presentation:
            row[3] == null ? null : ElementPresentation.values[(row[3] as int)],
        tags: (row[4] as List<dynamic>),
        version: (row[5] as int),
        title: (row[6] as String),
        subtitle: (row[7] as String));
    if (row.length > 8) {
      model = model.copyWith(
          owner: UserQuery.parseRow(row.skip(8).take(9).toList()));
    }
    if (row.length > 17) {
      model = model.copyWith(
          parts: [PartQuery.parseRow(row.skip(17).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }

  @override
  bool canCompile(trampoline) {
    return (!(trampoline.contains('profiles') &&
        trampoline.contains('profile_part_joins')));
  }

  @override
  get(QueryExecutor executor) {
    return super.get(executor).then((result) {
      return result.fold<List<Profile>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                parts: List<_Part>.from(l.parts ?? [])
                  ..addAll(model.parts ?? []));
        }
      });
    });
  }

  @override
  update(QueryExecutor executor) {
    return super.update(executor).then((result) {
      return result.fold<List<Profile>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                parts: List<_Part>.from(l.parts ?? [])
                  ..addAll(model.parts ?? []));
        }
      });
    });
  }

  @override
  delete(QueryExecutor executor) {
    return super.delete(executor).then((result) {
      return result.fold<List<Profile>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                parts: List<_Part>.from(l.parts ?? [])
                  ..addAll(model.parts ?? []));
        }
      });
    });
  }
}

class ProfileQueryWhere extends QueryWhere {
  ProfileQueryWhere(ProfileQuery query)
      : id = StringSqlExpressionBuilder(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        presentation = EnumSqlExpressionBuilder<ElementPresentation>(
            query, 'presentation', (v) => v.index),
        tags = ListSqlExpressionBuilder(query, 'tags'),
        version = NumericSqlExpressionBuilder<int>(query, 'version'),
        title = StringSqlExpressionBuilder(query, 'title'),
        subtitle = StringSqlExpressionBuilder(query, 'subtitle');

  final StringSqlExpressionBuilder id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final EnumSqlExpressionBuilder<ElementPresentation> presentation;

  final ListSqlExpressionBuilder tags;

  final NumericSqlExpressionBuilder<int> version;

  final StringSqlExpressionBuilder title;

  final StringSqlExpressionBuilder subtitle;

  @override
  get expressionBuilders {
    return [
      id,
      createdAt,
      updatedAt,
      presentation,
      tags,
      version,
      title,
      subtitle
    ];
  }
}

class ProfileQueryValues extends MapQueryValues {
  @override
  get casts {
    return {'tags': 'jsonb'};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  ElementPresentation get presentation {
    return ElementPresentation.values[(values['presentation'] as int)];
  }

  set presentation(ElementPresentation value) =>
      values['presentation'] = value?.index;
  List<dynamic> get tags {
    return (json.decode((values['tags'] as String)) as List);
  }

  set tags(List<dynamic> value) => values['tags'] = json.encode(value);
  int get version {
    return (values['version'] as int);
  }

  set version(int value) => values['version'] = value;
  String get title {
    return (values['title'] as String);
  }

  set title(String value) => values['title'] = value;
  String get subtitle {
    return (values['subtitle'] as String);
  }

  set subtitle(String value) => values['subtitle'] = value;
  void copyFrom(Profile model) {
    id = model.id;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    presentation = model.presentation;
    tags = model.tags;
    version = model.version;
    title = model.title;
    subtitle = model.subtitle;
  }
}

class PartQuery extends Query<Part, PartQueryWhere> {
  PartQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = PartQueryWhere(this);
    leftJoin('users', 'id', 'owner_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'username',
          'email',
          'first_name',
          'last_name',
          'password',
          'encrypted_password'
        ],
        trampoline: trampoline);
    leftJoin(ProfilePartJoinQuery(trampoline: trampoline), 'id', 'part_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'title',
          'subtitle'
        ],
        trampoline: trampoline);
    leftJoin(PartGroupJoinQuery(trampoline: trampoline), 'id', 'part_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
  }

  @override
  final PartQueryValues values = PartQueryValues();

  PartQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'parts';
  }

  @override
  get fields {
    return const [
      'id',
      'created_at',
      'updated_at',
      'presentation',
      'tags',
      'version',
      'type'
    ];
  }

  @override
  PartQueryWhere get where {
    return _where;
  }

  @override
  PartQueryWhere newWhereClause() {
    return PartQueryWhere(this);
  }

  static Part parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = Part(
        id: (row[0] as String),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        presentation:
            row[3] == null ? null : ElementPresentation.values[(row[3] as int)],
        tags: (row[4] as List<dynamic>),
        version: (row[5] as int),
        type: (row[6] as String));
    if (row.length > 7) {
      model = model.copyWith(
          owner: UserQuery.parseRow(row.skip(7).take(9).toList()));
    }
    if (row.length > 16) {
      model = model.copyWith(
          profiles: [ProfileQuery.parseRow(row.skip(16).take(8).toList())]
              .where((x) => x != null)
              .toList());
    }
    if (row.length > 24) {
      model = model.copyWith(
          groups: [GroupQuery.parseRow(row.skip(24).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }

  @override
  bool canCompile(trampoline) {
    return (!(trampoline.contains('parts') &&
            trampoline.contains('profile_part_joins'))) &&
        (!(trampoline.contains('parts') &&
            trampoline.contains('part_group_joins')));
  }

  @override
  get(QueryExecutor executor) {
    return super.get(executor).then((result) {
      return result.fold<List<Part>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                profiles: List<_Profile>.from(l.profiles ?? [])
                  ..addAll(model.profiles ?? []),
                groups: List<_Group>.from(l.groups ?? [])
                  ..addAll(model.groups ?? []));
        }
      });
    });
  }

  @override
  update(QueryExecutor executor) {
    return super.update(executor).then((result) {
      return result.fold<List<Part>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                profiles: List<_Profile>.from(l.profiles ?? [])
                  ..addAll(model.profiles ?? []),
                groups: List<_Group>.from(l.groups ?? [])
                  ..addAll(model.groups ?? []));
        }
      });
    });
  }

  @override
  delete(QueryExecutor executor) {
    return super.delete(executor).then((result) {
      return result.fold<List<Part>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                profiles: List<_Profile>.from(l.profiles ?? [])
                  ..addAll(model.profiles ?? []),
                groups: List<_Group>.from(l.groups ?? [])
                  ..addAll(model.groups ?? []));
        }
      });
    });
  }
}

class PartQueryWhere extends QueryWhere {
  PartQueryWhere(PartQuery query)
      : id = StringSqlExpressionBuilder(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        presentation = EnumSqlExpressionBuilder<ElementPresentation>(
            query, 'presentation', (v) => v.index),
        tags = ListSqlExpressionBuilder(query, 'tags'),
        version = NumericSqlExpressionBuilder<int>(query, 'version'),
        type = StringSqlExpressionBuilder(query, 'type');

  final StringSqlExpressionBuilder id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final EnumSqlExpressionBuilder<ElementPresentation> presentation;

  final ListSqlExpressionBuilder tags;

  final NumericSqlExpressionBuilder<int> version;

  final StringSqlExpressionBuilder type;

  @override
  get expressionBuilders {
    return [id, createdAt, updatedAt, presentation, tags, version, type];
  }
}

class PartQueryValues extends MapQueryValues {
  @override
  get casts {
    return {'tags': 'jsonb'};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  ElementPresentation get presentation {
    return ElementPresentation.values[(values['presentation'] as int)];
  }

  set presentation(ElementPresentation value) =>
      values['presentation'] = value?.index;
  List<dynamic> get tags {
    return (json.decode((values['tags'] as String)) as List);
  }

  set tags(List<dynamic> value) => values['tags'] = json.encode(value);
  int get version {
    return (values['version'] as int);
  }

  set version(int value) => values['version'] = value;
  String get type {
    return (values['type'] as String);
  }

  set type(String value) => values['type'] = value;
  void copyFrom(Part model) {
    id = model.id;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    presentation = model.presentation;
    tags = model.tags;
    version = model.version;
    type = model.type;
  }
}

class GroupQuery extends Query<Group, GroupQueryWhere> {
  GroupQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = GroupQueryWhere(this);
    leftJoin('users', 'id', 'owner_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'username',
          'email',
          'first_name',
          'last_name',
          'password',
          'encrypted_password'
        ],
        trampoline: trampoline);
    leftJoin(PartGroupJoinQuery(trampoline: trampoline), 'id', 'group_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
    leftJoin(GroupEntryJoinQuery(trampoline: trampoline), 'id', 'group_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
  }

  @override
  final GroupQueryValues values = GroupQueryValues();

  GroupQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'groups';
  }

  @override
  get fields {
    return const [
      'id',
      'created_at',
      'updated_at',
      'presentation',
      'tags',
      'version',
      'type'
    ];
  }

  @override
  GroupQueryWhere get where {
    return _where;
  }

  @override
  GroupQueryWhere newWhereClause() {
    return GroupQueryWhere(this);
  }

  static Group parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = Group(
        id: (row[0] as String),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        presentation:
            row[3] == null ? null : ElementPresentation.values[(row[3] as int)],
        tags: (row[4] as List<dynamic>),
        version: (row[5] as int),
        type: (row[6] as String));
    if (row.length > 7) {
      model = model.copyWith(
          owner: UserQuery.parseRow(row.skip(7).take(9).toList()));
    }
    if (row.length > 16) {
      model = model.copyWith(
          parts: [PartQuery.parseRow(row.skip(16).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    if (row.length > 23) {
      model = model.copyWith(
          entries: [EntryQuery.parseRow(row.skip(23).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }

  @override
  bool canCompile(trampoline) {
    return (!(trampoline.contains('groups') &&
            trampoline.contains('part_group_joins'))) &&
        (!(trampoline.contains('groups') &&
            trampoline.contains('group_entry_joins')));
  }

  @override
  get(QueryExecutor executor) {
    return super.get(executor).then((result) {
      return result.fold<List<Group>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                parts: List<_Part>.from(l.parts ?? [])
                  ..addAll(model.parts ?? []),
                entries: List<_Entry>.from(l.entries ?? [])
                  ..addAll(model.entries ?? []));
        }
      });
    });
  }

  @override
  update(QueryExecutor executor) {
    return super.update(executor).then((result) {
      return result.fold<List<Group>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                parts: List<_Part>.from(l.parts ?? [])
                  ..addAll(model.parts ?? []),
                entries: List<_Entry>.from(l.entries ?? [])
                  ..addAll(model.entries ?? []));
        }
      });
    });
  }

  @override
  delete(QueryExecutor executor) {
    return super.delete(executor).then((result) {
      return result.fold<List<Group>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                parts: List<_Part>.from(l.parts ?? [])
                  ..addAll(model.parts ?? []),
                entries: List<_Entry>.from(l.entries ?? [])
                  ..addAll(model.entries ?? []));
        }
      });
    });
  }
}

class GroupQueryWhere extends QueryWhere {
  GroupQueryWhere(GroupQuery query)
      : id = StringSqlExpressionBuilder(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        presentation = EnumSqlExpressionBuilder<ElementPresentation>(
            query, 'presentation', (v) => v.index),
        tags = ListSqlExpressionBuilder(query, 'tags'),
        version = NumericSqlExpressionBuilder<int>(query, 'version'),
        type = StringSqlExpressionBuilder(query, 'type');

  final StringSqlExpressionBuilder id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final EnumSqlExpressionBuilder<ElementPresentation> presentation;

  final ListSqlExpressionBuilder tags;

  final NumericSqlExpressionBuilder<int> version;

  final StringSqlExpressionBuilder type;

  @override
  get expressionBuilders {
    return [id, createdAt, updatedAt, presentation, tags, version, type];
  }
}

class GroupQueryValues extends MapQueryValues {
  @override
  get casts {
    return {'tags': 'jsonb'};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  ElementPresentation get presentation {
    return ElementPresentation.values[(values['presentation'] as int)];
  }

  set presentation(ElementPresentation value) =>
      values['presentation'] = value?.index;
  List<dynamic> get tags {
    return (json.decode((values['tags'] as String)) as List);
  }

  set tags(List<dynamic> value) => values['tags'] = json.encode(value);
  int get version {
    return (values['version'] as int);
  }

  set version(int value) => values['version'] = value;
  String get type {
    return (values['type'] as String);
  }

  set type(String value) => values['type'] = value;
  void copyFrom(Group model) {
    id = model.id;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    presentation = model.presentation;
    tags = model.tags;
    version = model.version;
    type = model.type;
  }
}

class EntryQuery extends Query<Entry, EntryQueryWhere> {
  EntryQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = EntryQueryWhere(this);
    leftJoin('users', 'id', 'owner_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'username',
          'email',
          'first_name',
          'last_name',
          'password',
          'encrypted_password'
        ],
        trampoline: trampoline);
    leftJoin(GroupEntryJoinQuery(trampoline: trampoline), 'id', 'entry_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
  }

  @override
  final EntryQueryValues values = EntryQueryValues();

  EntryQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'entries';
  }

  @override
  get fields {
    return const [
      'id',
      'created_at',
      'updated_at',
      'presentation',
      'tags',
      'version',
      'type'
    ];
  }

  @override
  EntryQueryWhere get where {
    return _where;
  }

  @override
  EntryQueryWhere newWhereClause() {
    return EntryQueryWhere(this);
  }

  static Entry parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = Entry(
        id: (row[0] as String),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        presentation:
            row[3] == null ? null : ElementPresentation.values[(row[3] as int)],
        tags: (row[4] as List<dynamic>),
        version: (row[5] as int),
        type: (row[6] as String));
    if (row.length > 7) {
      model = model.copyWith(
          owner: UserQuery.parseRow(row.skip(7).take(9).toList()));
    }
    if (row.length > 16) {
      model = model.copyWith(
          entries: [EntryQuery.parseRow(row.skip(16).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }

  @override
  bool canCompile(trampoline) {
    return (!(trampoline.contains('entries') &&
        trampoline.contains('group_entry_joins')));
  }

  @override
  get(QueryExecutor executor) {
    return super.get(executor).then((result) {
      return result.fold<List<Entry>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                entries: List<_Entry>.from(l.entries ?? [])
                  ..addAll(model.entries ?? []));
        }
      });
    });
  }

  @override
  update(QueryExecutor executor) {
    return super.update(executor).then((result) {
      return result.fold<List<Entry>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                entries: List<_Entry>.from(l.entries ?? [])
                  ..addAll(model.entries ?? []));
        }
      });
    });
  }

  @override
  delete(QueryExecutor executor) {
    return super.delete(executor).then((result) {
      return result.fold<List<Entry>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                entries: List<_Entry>.from(l.entries ?? [])
                  ..addAll(model.entries ?? []));
        }
      });
    });
  }
}

class EntryQueryWhere extends QueryWhere {
  EntryQueryWhere(EntryQuery query)
      : id = StringSqlExpressionBuilder(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        presentation = EnumSqlExpressionBuilder<ElementPresentation>(
            query, 'presentation', (v) => v.index),
        tags = ListSqlExpressionBuilder(query, 'tags'),
        version = NumericSqlExpressionBuilder<int>(query, 'version'),
        type = StringSqlExpressionBuilder(query, 'type');

  final StringSqlExpressionBuilder id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final EnumSqlExpressionBuilder<ElementPresentation> presentation;

  final ListSqlExpressionBuilder tags;

  final NumericSqlExpressionBuilder<int> version;

  final StringSqlExpressionBuilder type;

  @override
  get expressionBuilders {
    return [id, createdAt, updatedAt, presentation, tags, version, type];
  }
}

class EntryQueryValues extends MapQueryValues {
  @override
  get casts {
    return {'tags': 'jsonb'};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  ElementPresentation get presentation {
    return ElementPresentation.values[(values['presentation'] as int)];
  }

  set presentation(ElementPresentation value) =>
      values['presentation'] = value?.index;
  List<dynamic> get tags {
    return (json.decode((values['tags'] as String)) as List);
  }

  set tags(List<dynamic> value) => values['tags'] = json.encode(value);
  int get version {
    return (values['version'] as int);
  }

  set version(int value) => values['version'] = value;
  String get type {
    return (values['type'] as String);
  }

  set type(String value) => values['type'] = value;
  void copyFrom(Entry model) {
    id = model.id;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    presentation = model.presentation;
    tags = model.tags;
    version = model.version;
    type = model.type;
  }
}

class ProfilePartJoinQuery
    extends Query<ProfilePartJoin, ProfilePartJoinQueryWhere> {
  ProfilePartJoinQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = ProfilePartJoinQueryWhere(this);
    leftJoin('profiles', 'profile_id', 'id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'title',
          'subtitle'
        ],
        trampoline: trampoline);
    leftJoin('parts', 'part_id', 'id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
  }

  @override
  final ProfilePartJoinQueryValues values = ProfilePartJoinQueryValues();

  ProfilePartJoinQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'profile_part_joins';
  }

  @override
  get fields {
    return const ['profile_id', 'part_id'];
  }

  @override
  ProfilePartJoinQueryWhere get where {
    return _where;
  }

  @override
  ProfilePartJoinQueryWhere newWhereClause() {
    return ProfilePartJoinQueryWhere(this);
  }

  static ProfilePartJoin parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = ProfilePartJoin();
    if (row.length > 2) {
      model = model.copyWith(
          profile: ProfileQuery.parseRow(row.skip(2).take(8).toList()));
    }
    if (row.length > 10) {
      model = model.copyWith(
          part: PartQuery.parseRow(row.skip(10).take(7).toList()));
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class ProfilePartJoinQueryWhere extends QueryWhere {
  ProfilePartJoinQueryWhere(ProfilePartJoinQuery query)
      : profileId = StringSqlExpressionBuilder(query, 'profile_id'),
        partId = StringSqlExpressionBuilder(query, 'part_id');

  final StringSqlExpressionBuilder profileId;

  final StringSqlExpressionBuilder partId;

  @override
  get expressionBuilders {
    return [profileId, partId];
  }
}

class ProfilePartJoinQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  String get profileId {
    return (values['profile_id'] as String);
  }

  set profileId(String value) => values['profile_id'] = value;
  String get partId {
    return (values['part_id'] as String);
  }

  set partId(String value) => values['part_id'] = value;
  void copyFrom(ProfilePartJoin model) {
    if (model.profile != null) {
      values['profile_id'] = model.profile.id;
    }
    if (model.part != null) {
      values['part_id'] = model.part.id;
    }
  }
}

class PartGroupJoinQuery extends Query<PartGroupJoin, PartGroupJoinQueryWhere> {
  PartGroupJoinQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = PartGroupJoinQueryWhere(this);
    leftJoin('parts', 'part_id', 'id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
    leftJoin('groups', 'group_id', 'id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
  }

  @override
  final PartGroupJoinQueryValues values = PartGroupJoinQueryValues();

  PartGroupJoinQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'part_group_joins';
  }

  @override
  get fields {
    return const ['part_id', 'group_id'];
  }

  @override
  PartGroupJoinQueryWhere get where {
    return _where;
  }

  @override
  PartGroupJoinQueryWhere newWhereClause() {
    return PartGroupJoinQueryWhere(this);
  }

  static PartGroupJoin parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = PartGroupJoin();
    if (row.length > 2) {
      model = model.copyWith(
          part: PartQuery.parseRow(row.skip(2).take(7).toList()));
    }
    if (row.length > 9) {
      model = model.copyWith(
          group: GroupQuery.parseRow(row.skip(9).take(7).toList()));
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class PartGroupJoinQueryWhere extends QueryWhere {
  PartGroupJoinQueryWhere(PartGroupJoinQuery query)
      : partId = StringSqlExpressionBuilder(query, 'part_id'),
        groupId = StringSqlExpressionBuilder(query, 'group_id');

  final StringSqlExpressionBuilder partId;

  final StringSqlExpressionBuilder groupId;

  @override
  get expressionBuilders {
    return [partId, groupId];
  }
}

class PartGroupJoinQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  String get partId {
    return (values['part_id'] as String);
  }

  set partId(String value) => values['part_id'] = value;
  String get groupId {
    return (values['group_id'] as String);
  }

  set groupId(String value) => values['group_id'] = value;
  void copyFrom(PartGroupJoin model) {
    if (model.part != null) {
      values['part_id'] = model.part.id;
    }
    if (model.group != null) {
      values['group_id'] = model.group.id;
    }
  }
}

class GroupEntryJoinQuery
    extends Query<GroupEntryJoin, GroupEntryJoinQueryWhere> {
  GroupEntryJoinQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = GroupEntryJoinQueryWhere(this);
    leftJoin('groups', 'group_id', 'id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
    leftJoin('entries', 'entry_id', 'id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'presentation',
          'tags',
          'version',
          'type'
        ],
        trampoline: trampoline);
  }

  @override
  final GroupEntryJoinQueryValues values = GroupEntryJoinQueryValues();

  GroupEntryJoinQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'group_entry_joins';
  }

  @override
  get fields {
    return const ['group_id', 'entry_id'];
  }

  @override
  GroupEntryJoinQueryWhere get where {
    return _where;
  }

  @override
  GroupEntryJoinQueryWhere newWhereClause() {
    return GroupEntryJoinQueryWhere(this);
  }

  static GroupEntryJoin parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = GroupEntryJoin();
    if (row.length > 2) {
      model = model.copyWith(
          group: GroupQuery.parseRow(row.skip(2).take(7).toList()));
    }
    if (row.length > 9) {
      model = model.copyWith(
          entry: EntryQuery.parseRow(row.skip(9).take(7).toList()));
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class GroupEntryJoinQueryWhere extends QueryWhere {
  GroupEntryJoinQueryWhere(GroupEntryJoinQuery query)
      : groupId = StringSqlExpressionBuilder(query, 'group_id'),
        entryId = StringSqlExpressionBuilder(query, 'entry_id');

  final StringSqlExpressionBuilder groupId;

  final StringSqlExpressionBuilder entryId;

  @override
  get expressionBuilders {
    return [groupId, entryId];
  }
}

class GroupEntryJoinQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  String get groupId {
    return (values['group_id'] as String);
  }

  set groupId(String value) => values['group_id'] = value;
  String get entryId {
    return (values['entry_id'] as String);
  }

  set entryId(String value) => values['entry_id'] = value;
  void copyFrom(GroupEntryJoin model) {
    if (model.group != null) {
      values['group_id'] = model.group.id;
    }
    if (model.entry != null) {
      values['entry_id'] = model.entry.id;
    }
  }
}

class ClientQuery extends Query<Client, ClientQueryWhere> {
  ClientQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = ClientQueryWhere(this);
    leftJoin(AuthTokenQuery(trampoline: trampoline), 'id', 'client_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'token',
          'scope',
          'expire_at',
          'refresh_token'
        ],
        trampoline: trampoline);
    leftJoin(AuthCodeQuery(trampoline: trampoline), 'id', 'client_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'token',
          'scope',
          'expire_at',
          'redirect_uri'
        ],
        trampoline: trampoline);
  }

  @override
  final ClientQueryValues values = ClientQueryValues();

  ClientQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'clients';
  }

  @override
  get fields {
    return const [
      'id',
      'created_at',
      'updated_at',
      'random_id',
      'secret',
      'encrypted_secret',
      'redirect_uris',
      'allowed_grant_types'
    ];
  }

  @override
  ClientQueryWhere get where {
    return _where;
  }

  @override
  ClientQueryWhere newWhereClause() {
    return ClientQueryWhere(this);
  }

  static Client parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = Client(
        id: (row[0] as String),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        randomId: (row[3] as String),
        secret: (row[4] as String),
        encryptedSecret: (row[5] as String),
        redirectUris: (row[6] as List<dynamic>),
        allowedGrantTypes: (row[7] as List<dynamic>));
    if (row.length > 8) {
      model = model.copyWith(
          accessTokens: [AuthTokenQuery.parseRow(row.skip(8).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    if (row.length > 15) {
      model = model.copyWith(
          authCodes: [AuthCodeQuery.parseRow(row.skip(15).take(7).toList())]
              .where((x) => x != null)
              .toList());
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }

  @override
  get(QueryExecutor executor) {
    return super.get(executor).then((result) {
      return result.fold<List<Client>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                accessTokens: List<_AuthToken>.from(l.accessTokens ?? [])
                  ..addAll(model.accessTokens ?? []),
                authCodes: List<_AuthCode>.from(l.authCodes ?? [])
                  ..addAll(model.authCodes ?? []));
        }
      });
    });
  }

  @override
  update(QueryExecutor executor) {
    return super.update(executor).then((result) {
      return result.fold<List<Client>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                accessTokens: List<_AuthToken>.from(l.accessTokens ?? [])
                  ..addAll(model.accessTokens ?? []),
                authCodes: List<_AuthCode>.from(l.authCodes ?? [])
                  ..addAll(model.authCodes ?? []));
        }
      });
    });
  }

  @override
  delete(QueryExecutor executor) {
    return super.delete(executor).then((result) {
      return result.fold<List<Client>>([], (out, model) {
        var idx = out.indexWhere((m) => m.id == model.id);

        if (idx == -1) {
          return out..add(model);
        } else {
          var l = out[idx];
          return out
            ..[idx] = l.copyWith(
                accessTokens: List<_AuthToken>.from(l.accessTokens ?? [])
                  ..addAll(model.accessTokens ?? []),
                authCodes: List<_AuthCode>.from(l.authCodes ?? [])
                  ..addAll(model.authCodes ?? []));
        }
      });
    });
  }
}

class ClientQueryWhere extends QueryWhere {
  ClientQueryWhere(ClientQuery query)
      : id = StringSqlExpressionBuilder(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        randomId = StringSqlExpressionBuilder(query, 'random_id'),
        secret = StringSqlExpressionBuilder(query, 'secret'),
        encryptedSecret = StringSqlExpressionBuilder(query, 'encrypted_secret'),
        redirectUris = ListSqlExpressionBuilder(query, 'redirect_uris'),
        allowedGrantTypes =
            ListSqlExpressionBuilder(query, 'allowed_grant_types');

  final StringSqlExpressionBuilder id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final StringSqlExpressionBuilder randomId;

  final StringSqlExpressionBuilder secret;

  final StringSqlExpressionBuilder encryptedSecret;

  final ListSqlExpressionBuilder redirectUris;

  final ListSqlExpressionBuilder allowedGrantTypes;

  @override
  get expressionBuilders {
    return [
      id,
      createdAt,
      updatedAt,
      randomId,
      secret,
      encryptedSecret,
      redirectUris,
      allowedGrantTypes
    ];
  }
}

class ClientQueryValues extends MapQueryValues {
  @override
  get casts {
    return {'redirect_uris': 'jsonb', 'allowed_grant_types': 'jsonb'};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  String get randomId {
    return (values['random_id'] as String);
  }

  set randomId(String value) => values['random_id'] = value;
  String get secret {
    return (values['secret'] as String);
  }

  set secret(String value) => values['secret'] = value;
  String get encryptedSecret {
    return (values['encrypted_secret'] as String);
  }

  set encryptedSecret(String value) => values['encrypted_secret'] = value;
  List<dynamic> get redirectUris {
    return (json.decode((values['redirect_uris'] as String)) as List);
  }

  set redirectUris(List<dynamic> value) =>
      values['redirect_uris'] = json.encode(value);
  List<dynamic> get allowedGrantTypes {
    return (json.decode((values['allowed_grant_types'] as String)) as List);
  }

  set allowedGrantTypes(List<dynamic> value) =>
      values['allowed_grant_types'] = json.encode(value);
  void copyFrom(Client model) {
    id = model.id;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    randomId = model.randomId;
    secret = model.secret;
    encryptedSecret = model.encryptedSecret;
    redirectUris = model.redirectUris;
    allowedGrantTypes = model.allowedGrantTypes;
  }
}

class AuthTokenQuery extends Query<AuthToken, AuthTokenQueryWhere> {
  AuthTokenQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = AuthTokenQueryWhere(this);
    leftJoin('users', 'id', 'auth_token_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'username',
          'email',
          'first_name',
          'last_name',
          'password',
          'encrypted_password'
        ],
        trampoline: trampoline);
    leftJoin('clients', 'id', 'auth_token_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'random_id',
          'secret',
          'encrypted_secret',
          'redirect_uris',
          'allowed_grant_types'
        ],
        trampoline: trampoline);
  }

  @override
  final AuthTokenQueryValues values = AuthTokenQueryValues();

  AuthTokenQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'auth_tokens';
  }

  @override
  get fields {
    return const [
      'id',
      'created_at',
      'updated_at',
      'token',
      'scope',
      'expire_at',
      'refresh_token'
    ];
  }

  @override
  AuthTokenQueryWhere get where {
    return _where;
  }

  @override
  AuthTokenQueryWhere newWhereClause() {
    return AuthTokenQueryWhere(this);
  }

  static AuthToken parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = AuthToken(
        id: (row[0] as String),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        token: (row[3] as String),
        scope: (row[4] as String),
        expireAt: (row[5] as DateTime),
        refreshToken: (row[6] as String));
    if (row.length > 7) {
      model = model.copyWith(
          user: UserQuery.parseRow(row.skip(7).take(9).toList()));
    }
    if (row.length > 16) {
      model = model.copyWith(
          client: ClientQuery.parseRow(row.skip(16).take(8).toList()));
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class AuthTokenQueryWhere extends QueryWhere {
  AuthTokenQueryWhere(AuthTokenQuery query)
      : id = StringSqlExpressionBuilder(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        token = StringSqlExpressionBuilder(query, 'token'),
        scope = StringSqlExpressionBuilder(query, 'scope'),
        expireAt = DateTimeSqlExpressionBuilder(query, 'expire_at'),
        refreshToken = StringSqlExpressionBuilder(query, 'refresh_token');

  final StringSqlExpressionBuilder id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final StringSqlExpressionBuilder token;

  final StringSqlExpressionBuilder scope;

  final DateTimeSqlExpressionBuilder expireAt;

  final StringSqlExpressionBuilder refreshToken;

  @override
  get expressionBuilders {
    return [id, createdAt, updatedAt, token, scope, expireAt, refreshToken];
  }
}

class AuthTokenQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  String get token {
    return (values['token'] as String);
  }

  set token(String value) => values['token'] = value;
  String get scope {
    return (values['scope'] as String);
  }

  set scope(String value) => values['scope'] = value;
  DateTime get expireAt {
    return (values['expire_at'] as DateTime);
  }

  set expireAt(DateTime value) => values['expire_at'] = value;
  String get refreshToken {
    return (values['refresh_token'] as String);
  }

  set refreshToken(String value) => values['refresh_token'] = value;
  void copyFrom(AuthToken model) {
    id = model.id;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    token = model.token;
    scope = model.scope;
    expireAt = model.expireAt;
    refreshToken = model.refreshToken;
  }
}

class AuthCodeQuery extends Query<AuthCode, AuthCodeQueryWhere> {
  AuthCodeQuery({Set<String> trampoline}) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = AuthCodeQueryWhere(this);
    leftJoin('users', 'id', 'auth_code_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'username',
          'email',
          'first_name',
          'last_name',
          'password',
          'encrypted_password'
        ],
        trampoline: trampoline);
    leftJoin('clients', 'id', 'auth_code_id',
        additionalFields: const [
          'id',
          'created_at',
          'updated_at',
          'random_id',
          'secret',
          'encrypted_secret',
          'redirect_uris',
          'allowed_grant_types'
        ],
        trampoline: trampoline);
  }

  @override
  final AuthCodeQueryValues values = AuthCodeQueryValues();

  AuthCodeQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'auth_codes';
  }

  @override
  get fields {
    return const [
      'id',
      'created_at',
      'updated_at',
      'token',
      'scope',
      'expire_at',
      'redirect_uri'
    ];
  }

  @override
  AuthCodeQueryWhere get where {
    return _where;
  }

  @override
  AuthCodeQueryWhere newWhereClause() {
    return AuthCodeQueryWhere(this);
  }

  static AuthCode parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = AuthCode(
        id: (row[0] as String),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        token: (row[3] as String),
        scope: (row[4] as String),
        expireAt: (row[5] as DateTime),
        redirectUri: (row[6] as String));
    if (row.length > 7) {
      model = model.copyWith(
          user: UserQuery.parseRow(row.skip(7).take(9).toList()));
    }
    if (row.length > 16) {
      model = model.copyWith(
          client: ClientQuery.parseRow(row.skip(16).take(8).toList()));
    }
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class AuthCodeQueryWhere extends QueryWhere {
  AuthCodeQueryWhere(AuthCodeQuery query)
      : id = StringSqlExpressionBuilder(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        token = StringSqlExpressionBuilder(query, 'token'),
        scope = StringSqlExpressionBuilder(query, 'scope'),
        expireAt = DateTimeSqlExpressionBuilder(query, 'expire_at'),
        redirectUri = StringSqlExpressionBuilder(query, 'redirect_uri');

  final StringSqlExpressionBuilder id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final StringSqlExpressionBuilder token;

  final StringSqlExpressionBuilder scope;

  final DateTimeSqlExpressionBuilder expireAt;

  final StringSqlExpressionBuilder redirectUri;

  @override
  get expressionBuilders {
    return [id, createdAt, updatedAt, token, scope, expireAt, redirectUri];
  }
}

class AuthCodeQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  String get token {
    return (values['token'] as String);
  }

  set token(String value) => values['token'] = value;
  String get scope {
    return (values['scope'] as String);
  }

  set scope(String value) => values['scope'] = value;
  DateTime get expireAt {
    return (values['expire_at'] as DateTime);
  }

  set expireAt(DateTime value) => values['expire_at'] = value;
  String get redirectUri {
    return (values['redirect_uri'] as String);
  }

  set redirectUri(String value) => values['redirect_uri'] = value;
  void copyFrom(AuthCode model) {
    id = model.id;
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    token = model.token;
    scope = model.scope;
    expireAt = model.expireAt;
    redirectUri = model.redirectUri;
  }
}

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class User extends _User {
  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.password,
      this.encryptedPassword,
      List<_AuthToken> tokens,
      List<_AuthCode> authCodes,
      List<_Profile> profiles,
      List<_Part> parts,
      List<_Group> groups,
      List<_Entry> entries})
      : this.tokens = List.unmodifiable(tokens ?? []),
        this.authCodes = List.unmodifiable(authCodes ?? []),
        this.profiles = List.unmodifiable(profiles ?? []),
        this.parts = List.unmodifiable(parts ?? []),
        this.groups = List.unmodifiable(groups ?? []),
        this.entries = List.unmodifiable(entries ?? []);

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  /// The username of the user.
  @override
  String username;

  /// The email of the user.
  @override
  String email;

  /// The first name of the user
  @override
  String firstName;

  /// The last name of the user
  @override
  String lastName;

  /// The plain text password of the user (should not be in the outputs)
  @override
  String password;

  /// The encrypted password of the user.
  @override
  String encryptedPassword;

  /// OAuth 2.0
  /// The list of tokens issue for this user.
  @override
  List<_AuthToken> tokens;

  /// OAuth 2.0
  /// The list of authentication code issue for this user.
  @override
  List<_AuthCode> authCodes;

  @override
  List<_Profile> profiles;

  @override
  List<_Part> parts;

  @override
  List<_Group> groups;

  @override
  List<_Entry> entries;

  User copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      String username,
      String email,
      String firstName,
      String lastName,
      String password,
      String encryptedPassword,
      List<_AuthToken> tokens,
      List<_AuthCode> authCodes,
      List<_Profile> profiles,
      List<_Part> parts,
      List<_Group> groups,
      List<_Entry> entries}) {
    return User(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        username: username ?? this.username,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password,
        encryptedPassword: encryptedPassword ?? this.encryptedPassword,
        tokens: tokens ?? this.tokens,
        authCodes: authCodes ?? this.authCodes,
        profiles: profiles ?? this.profiles,
        parts: parts ?? this.parts,
        groups: groups ?? this.groups,
        entries: entries ?? this.entries);
  }

  bool operator ==(other) {
    return other is _User &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.username == username &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.password == password &&
        other.encryptedPassword == encryptedPassword &&
        ListEquality<_AuthToken>(DefaultEquality<_AuthToken>())
            .equals(other.tokens, tokens) &&
        ListEquality<_AuthCode>(DefaultEquality<_AuthCode>())
            .equals(other.authCodes, authCodes) &&
        ListEquality<_Profile>(DefaultEquality<_Profile>())
            .equals(other.profiles, profiles) &&
        ListEquality<_Part>(DefaultEquality<_Part>())
            .equals(other.parts, parts) &&
        ListEquality<_Group>(DefaultEquality<_Group>())
            .equals(other.groups, groups) &&
        ListEquality<_Entry>(DefaultEquality<_Entry>())
            .equals(other.entries, entries);
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      createdAt,
      updatedAt,
      username,
      email,
      firstName,
      lastName,
      password,
      encryptedPassword,
      tokens,
      authCodes,
      profiles,
      parts,
      groups,
      entries
    ]);
  }

  @override
  String toString() {
    return "User(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, username=$username, email=$email, firstName=$firstName, lastName=$lastName, password=$password, encryptedPassword=$encryptedPassword, tokens=$tokens, authCodes=$authCodes, profiles=$profiles, parts=$parts, groups=$groups, entries=$entries)";
  }

  Map<String, dynamic> toJson() {
    return UserSerializer.toMap(this);
  }
}

@generatedSerializable
class Profile extends _Profile {
  Profile(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.presentation,
      List<dynamic> tags,
      this.owner,
      this.version,
      this.title,
      this.subtitle,
      List<_Part> parts})
      : this.tags = List.unmodifiable(tags ?? []),
        this.parts = List.unmodifiable(parts ?? []);

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  ElementPresentation presentation;

  @override
  List<dynamic> tags;

  @override
  _User owner;

  @override
  int version;

  @override
  String title;

  @override
  String subtitle;

  @override
  List<_Part> parts;

  Profile copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      ElementPresentation presentation,
      List<dynamic> tags,
      _User owner,
      int version,
      String title,
      String subtitle,
      List<_Part> parts}) {
    return Profile(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        presentation: presentation ?? this.presentation,
        tags: tags ?? this.tags,
        owner: owner ?? this.owner,
        version: version ?? this.version,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        parts: parts ?? this.parts);
  }

  bool operator ==(other) {
    return other is _Profile &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.presentation == presentation &&
        ListEquality<dynamic>(DefaultEquality()).equals(other.tags, tags) &&
        other.owner == owner &&
        other.version == version &&
        other.title == title &&
        other.subtitle == subtitle &&
        ListEquality<_Part>(DefaultEquality<_Part>())
            .equals(other.parts, parts);
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      createdAt,
      updatedAt,
      presentation,
      tags,
      owner,
      version,
      title,
      subtitle,
      parts
    ]);
  }

  @override
  String toString() {
    return "Profile(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, presentation=$presentation, tags=$tags, owner=$owner, version=$version, title=$title, subtitle=$subtitle, parts=$parts)";
  }

  Map<String, dynamic> toJson() {
    return ProfileSerializer.toMap(this);
  }
}

@generatedSerializable
class Part extends _Part {
  Part(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.presentation,
      List<dynamic> tags,
      this.owner,
      this.version,
      List<_Profile> profiles,
      List<_Group> groups,
      this.type})
      : this.tags = List.unmodifiable(tags ?? []),
        this.profiles = List.unmodifiable(profiles ?? []),
        this.groups = List.unmodifiable(groups ?? []);

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  ElementPresentation presentation;

  @override
  List<dynamic> tags;

  @override
  _User owner;

  @override
  int version;

  @override
  List<_Profile> profiles;

  @override
  List<_Group> groups;

  @override
  String type;

  Part copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      ElementPresentation presentation,
      List<dynamic> tags,
      _User owner,
      int version,
      List<_Profile> profiles,
      List<_Group> groups,
      String type}) {
    return Part(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        presentation: presentation ?? this.presentation,
        tags: tags ?? this.tags,
        owner: owner ?? this.owner,
        version: version ?? this.version,
        profiles: profiles ?? this.profiles,
        groups: groups ?? this.groups,
        type: type ?? this.type);
  }

  bool operator ==(other) {
    return other is _Part &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.presentation == presentation &&
        ListEquality<dynamic>(DefaultEquality()).equals(other.tags, tags) &&
        other.owner == owner &&
        other.version == version &&
        ListEquality<_Profile>(DefaultEquality<_Profile>())
            .equals(other.profiles, profiles) &&
        ListEquality<_Group>(DefaultEquality<_Group>())
            .equals(other.groups, groups) &&
        other.type == type;
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      createdAt,
      updatedAt,
      presentation,
      tags,
      owner,
      version,
      profiles,
      groups,
      type
    ]);
  }

  @override
  String toString() {
    return "Part(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, presentation=$presentation, tags=$tags, owner=$owner, version=$version, profiles=$profiles, groups=$groups, type=$type)";
  }

  Map<String, dynamic> toJson() {
    return PartSerializer.toMap(this);
  }
}

@generatedSerializable
class Group extends _Group {
  Group(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.presentation,
      List<dynamic> tags,
      this.owner,
      this.version,
      List<_Part> parts,
      List<_Entry> entries,
      this.type})
      : this.tags = List.unmodifiable(tags ?? []),
        this.parts = List.unmodifiable(parts ?? []),
        this.entries = List.unmodifiable(entries ?? []);

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  ElementPresentation presentation;

  @override
  List<dynamic> tags;

  @override
  _User owner;

  @override
  int version;

  @override
  List<_Part> parts;

  @override
  List<_Entry> entries;

  @override
  String type;

  Group copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      ElementPresentation presentation,
      List<dynamic> tags,
      _User owner,
      int version,
      List<_Part> parts,
      List<_Entry> entries,
      String type}) {
    return Group(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        presentation: presentation ?? this.presentation,
        tags: tags ?? this.tags,
        owner: owner ?? this.owner,
        version: version ?? this.version,
        parts: parts ?? this.parts,
        entries: entries ?? this.entries,
        type: type ?? this.type);
  }

  bool operator ==(other) {
    return other is _Group &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.presentation == presentation &&
        ListEquality<dynamic>(DefaultEquality()).equals(other.tags, tags) &&
        other.owner == owner &&
        other.version == version &&
        ListEquality<_Part>(DefaultEquality<_Part>())
            .equals(other.parts, parts) &&
        ListEquality<_Entry>(DefaultEquality<_Entry>())
            .equals(other.entries, entries) &&
        other.type == type;
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      createdAt,
      updatedAt,
      presentation,
      tags,
      owner,
      version,
      parts,
      entries,
      type
    ]);
  }

  @override
  String toString() {
    return "Group(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, presentation=$presentation, tags=$tags, owner=$owner, version=$version, parts=$parts, entries=$entries, type=$type)";
  }

  Map<String, dynamic> toJson() {
    return GroupSerializer.toMap(this);
  }
}

@generatedSerializable
class Entry extends _Entry {
  Entry(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.presentation,
      List<dynamic> tags,
      this.owner,
      this.version,
      List<_Entry> entries,
      this.type})
      : this.tags = List.unmodifiable(tags ?? []),
        this.entries = List.unmodifiable(entries ?? []);

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  ElementPresentation presentation;

  @override
  List<dynamic> tags;

  @override
  _User owner;

  @override
  int version;

  @override
  List<_Entry> entries;

  @override
  String type;

  Entry copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      ElementPresentation presentation,
      List<dynamic> tags,
      _User owner,
      int version,
      List<_Entry> entries,
      String type}) {
    return Entry(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        presentation: presentation ?? this.presentation,
        tags: tags ?? this.tags,
        owner: owner ?? this.owner,
        version: version ?? this.version,
        entries: entries ?? this.entries,
        type: type ?? this.type);
  }

  bool operator ==(other) {
    return other is _Entry &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.presentation == presentation &&
        ListEquality<dynamic>(DefaultEquality()).equals(other.tags, tags) &&
        other.owner == owner &&
        other.version == version &&
        ListEquality<_Entry>(DefaultEquality<_Entry>())
            .equals(other.entries, entries) &&
        other.type == type;
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      createdAt,
      updatedAt,
      presentation,
      tags,
      owner,
      version,
      entries,
      type
    ]);
  }

  @override
  String toString() {
    return "Entry(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, presentation=$presentation, tags=$tags, owner=$owner, version=$version, entries=$entries, type=$type)";
  }

  Map<String, dynamic> toJson() {
    return EntrySerializer.toMap(this);
  }
}

@generatedSerializable
class ProfilePartJoin extends _ProfilePartJoin {
  ProfilePartJoin({this.profile, this.part});

  @override
  _Profile profile;

  @override
  _Part part;

  ProfilePartJoin copyWith({_Profile profile, _Part part}) {
    return ProfilePartJoin(
        profile: profile ?? this.profile, part: part ?? this.part);
  }

  bool operator ==(other) {
    return other is _ProfilePartJoin &&
        other.profile == profile &&
        other.part == part;
  }

  @override
  int get hashCode {
    return hashObjects([profile, part]);
  }

  @override
  String toString() {
    return "ProfilePartJoin(profile=$profile, part=$part)";
  }

  Map<String, dynamic> toJson() {
    return ProfilePartJoinSerializer.toMap(this);
  }
}

@generatedSerializable
class PartGroupJoin extends _PartGroupJoin {
  PartGroupJoin({this.part, this.group});

  @override
  _Part part;

  @override
  _Group group;

  PartGroupJoin copyWith({_Part part, _Group group}) {
    return PartGroupJoin(part: part ?? this.part, group: group ?? this.group);
  }

  bool operator ==(other) {
    return other is _PartGroupJoin &&
        other.part == part &&
        other.group == group;
  }

  @override
  int get hashCode {
    return hashObjects([part, group]);
  }

  @override
  String toString() {
    return "PartGroupJoin(part=$part, group=$group)";
  }

  Map<String, dynamic> toJson() {
    return PartGroupJoinSerializer.toMap(this);
  }
}

@generatedSerializable
class GroupEntryJoin extends _GroupEntryJoin {
  GroupEntryJoin({this.group, this.entry});

  @override
  _Group group;

  @override
  _Entry entry;

  GroupEntryJoin copyWith({_Group group, _Entry entry}) {
    return GroupEntryJoin(
        group: group ?? this.group, entry: entry ?? this.entry);
  }

  bool operator ==(other) {
    return other is _GroupEntryJoin &&
        other.group == group &&
        other.entry == entry;
  }

  @override
  int get hashCode {
    return hashObjects([group, entry]);
  }

  @override
  String toString() {
    return "GroupEntryJoin(group=$group, entry=$entry)";
  }

  Map<String, dynamic> toJson() {
    return GroupEntryJoinSerializer.toMap(this);
  }
}

@generatedSerializable
class Client extends _Client {
  Client(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.randomId,
      this.secret,
      this.encryptedSecret,
      List<dynamic> redirectUris,
      List<dynamic> allowedGrantTypes,
      List<_AuthToken> accessTokens,
      List<_AuthCode> authCodes})
      : this.redirectUris = List.unmodifiable(redirectUris ?? []),
        this.allowedGrantTypes = List.unmodifiable(allowedGrantTypes ?? []),
        this.accessTokens = List.unmodifiable(accessTokens ?? []),
        this.authCodes = List.unmodifiable(authCodes ?? []);

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  String randomId;

  @override
  String secret;

  @override
  String encryptedSecret;

  @override
  List<dynamic> redirectUris;

  @override
  List<dynamic> allowedGrantTypes;

  @override
  List<_AuthToken> accessTokens;

  @override
  List<_AuthCode> authCodes;

  Client copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      String randomId,
      String secret,
      String encryptedSecret,
      List<dynamic> redirectUris,
      List<dynamic> allowedGrantTypes,
      List<_AuthToken> accessTokens,
      List<_AuthCode> authCodes}) {
    return Client(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        randomId: randomId ?? this.randomId,
        secret: secret ?? this.secret,
        encryptedSecret: encryptedSecret ?? this.encryptedSecret,
        redirectUris: redirectUris ?? this.redirectUris,
        allowedGrantTypes: allowedGrantTypes ?? this.allowedGrantTypes,
        accessTokens: accessTokens ?? this.accessTokens,
        authCodes: authCodes ?? this.authCodes);
  }

  bool operator ==(other) {
    return other is _Client &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.randomId == randomId &&
        other.secret == secret &&
        other.encryptedSecret == encryptedSecret &&
        ListEquality<dynamic>(DefaultEquality())
            .equals(other.redirectUris, redirectUris) &&
        ListEquality<dynamic>(DefaultEquality())
            .equals(other.allowedGrantTypes, allowedGrantTypes) &&
        ListEquality<_AuthToken>(DefaultEquality<_AuthToken>())
            .equals(other.accessTokens, accessTokens) &&
        ListEquality<_AuthCode>(DefaultEquality<_AuthCode>())
            .equals(other.authCodes, authCodes);
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      createdAt,
      updatedAt,
      randomId,
      secret,
      encryptedSecret,
      redirectUris,
      allowedGrantTypes,
      accessTokens,
      authCodes
    ]);
  }

  @override
  String toString() {
    return "Client(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, randomId=$randomId, secret=$secret, encryptedSecret=$encryptedSecret, redirectUris=$redirectUris, allowedGrantTypes=$allowedGrantTypes, accessTokens=$accessTokens, authCodes=$authCodes)";
  }

  Map<String, dynamic> toJson() {
    return ClientSerializer.toMap(this);
  }
}

@generatedSerializable
class Token extends _Token {
  Token(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.scope,
      this.expireAt,
      this.user,
      this.client});

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  String token;

  @override
  String scope;

  @override
  DateTime expireAt;

  @override
  _User user;

  @override
  _Client client;

  Token copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      String token,
      String scope,
      DateTime expireAt,
      _User user,
      _Client client}) {
    return Token(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        token: token ?? this.token,
        scope: scope ?? this.scope,
        expireAt: expireAt ?? this.expireAt,
        user: user ?? this.user,
        client: client ?? this.client);
  }

  bool operator ==(other) {
    return other is _Token &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.token == token &&
        other.scope == scope &&
        other.expireAt == expireAt &&
        other.user == user &&
        other.client == client;
  }

  @override
  int get hashCode {
    return hashObjects(
        [id, createdAt, updatedAt, token, scope, expireAt, user, client]);
  }

  @override
  String toString() {
    return "Token(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, token=$token, scope=$scope, expireAt=$expireAt, user=$user, client=$client)";
  }

  Map<String, dynamic> toJson() {
    return TokenSerializer.toMap(this);
  }
}

@generatedSerializable
class AuthToken extends _AuthToken {
  AuthToken(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.scope,
      this.expireAt,
      this.user,
      this.client,
      this.refreshToken});

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  String token;

  @override
  String scope;

  @override
  DateTime expireAt;

  @override
  _User user;

  @override
  _Client client;

  @override
  String refreshToken;

  AuthToken copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      String token,
      String scope,
      DateTime expireAt,
      _User user,
      _Client client,
      String refreshToken}) {
    return AuthToken(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        token: token ?? this.token,
        scope: scope ?? this.scope,
        expireAt: expireAt ?? this.expireAt,
        user: user ?? this.user,
        client: client ?? this.client,
        refreshToken: refreshToken ?? this.refreshToken);
  }

  bool operator ==(other) {
    return other is _AuthToken &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.token == token &&
        other.scope == scope &&
        other.expireAt == expireAt &&
        other.user == user &&
        other.client == client &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      createdAt,
      updatedAt,
      token,
      scope,
      expireAt,
      user,
      client,
      refreshToken
    ]);
  }

  @override
  String toString() {
    return "AuthToken(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, token=$token, scope=$scope, expireAt=$expireAt, user=$user, client=$client, refreshToken=$refreshToken)";
  }

  Map<String, dynamic> toJson() {
    return AuthTokenSerializer.toMap(this);
  }
}

@generatedSerializable
class AuthCode extends _AuthCode {
  AuthCode(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.scope,
      this.expireAt,
      this.user,
      this.client,
      this.redirectUri});

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  String token;

  @override
  String scope;

  @override
  DateTime expireAt;

  @override
  _User user;

  @override
  _Client client;

  @override
  String redirectUri;

  AuthCode copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      String token,
      String scope,
      DateTime expireAt,
      _User user,
      _Client client,
      String redirectUri}) {
    return AuthCode(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        token: token ?? this.token,
        scope: scope ?? this.scope,
        expireAt: expireAt ?? this.expireAt,
        user: user ?? this.user,
        client: client ?? this.client,
        redirectUri: redirectUri ?? this.redirectUri);
  }

  bool operator ==(other) {
    return other is _AuthCode &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.token == token &&
        other.scope == scope &&
        other.expireAt == expireAt &&
        other.user == user &&
        other.client == client &&
        other.redirectUri == redirectUri;
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      createdAt,
      updatedAt,
      token,
      scope,
      expireAt,
      user,
      client,
      redirectUri
    ]);
  }

  @override
  String toString() {
    return "AuthCode(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, token=$token, scope=$scope, expireAt=$expireAt, user=$user, client=$client, redirectUri=$redirectUri)";
  }

  Map<String, dynamic> toJson() {
    return AuthCodeSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

const UserSerializer userSerializer = UserSerializer();

class UserEncoder extends Converter<User, Map> {
  const UserEncoder();

  @override
  Map convert(User model) => UserSerializer.toMap(model);
}

class UserDecoder extends Converter<Map, User> {
  const UserDecoder();

  @override
  User convert(Map map) => UserSerializer.fromMap(map);
}

class UserSerializer extends Codec<User, Map> {
  const UserSerializer();

  @override
  get encoder => const UserEncoder();
  @override
  get decoder => const UserDecoder();
  static User fromMap(Map map) {
    return User(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        username: map['username'] as String,
        email: map['email'] as String,
        firstName: map['first_name'] as String,
        lastName: map['last_name'] as String,
        password: map['password'] as String,
        encryptedPassword: map['encrypted_password'] as String,
        tokens: map['tokens'] is Iterable
            ? List.unmodifiable(((map['tokens'] as Iterable).whereType<Map>())
                .map(AuthTokenSerializer.fromMap))
            : null,
        authCodes: map['auth_codes'] is Iterable
            ? List.unmodifiable(
                ((map['auth_codes'] as Iterable).whereType<Map>())
                    .map(AuthCodeSerializer.fromMap))
            : null,
        profiles: map['profiles'] is Iterable
            ? List.unmodifiable(((map['profiles'] as Iterable).whereType<Map>())
                .map(ProfileSerializer.fromMap))
            : null,
        parts: map['parts'] is Iterable
            ? List.unmodifiable(
                ((map['parts'] as Iterable).whereType<Map>()).map(PartSerializer.fromMap))
            : null,
        groups: map['groups'] is Iterable ? List.unmodifiable(((map['groups'] as Iterable).whereType<Map>()).map(GroupSerializer.fromMap)) : null,
        entries: map['entries'] is Iterable ? List.unmodifiable(((map['entries'] as Iterable).whereType<Map>()).map(EntrySerializer.fromMap)) : null);
  }

  static Map<String, dynamic> toMap(_User model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'username': model.username,
      'email': model.email,
      'first_name': model.firstName,
      'last_name': model.lastName,
      'password': model.password,
      'encrypted_password': model.encryptedPassword,
      'tokens':
          model.tokens?.map((m) => AuthTokenSerializer.toMap(m))?.toList(),
      'auth_codes':
          model.authCodes?.map((m) => AuthCodeSerializer.toMap(m))?.toList(),
      'profiles':
          model.profiles?.map((m) => ProfileSerializer.toMap(m))?.toList(),
      'parts': model.parts?.map((m) => PartSerializer.toMap(m))?.toList(),
      'groups': model.groups?.map((m) => GroupSerializer.toMap(m))?.toList(),
      'entries': model.entries?.map((m) => EntrySerializer.toMap(m))?.toList()
    };
  }
}

abstract class UserFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    username,
    email,
    firstName,
    lastName,
    password,
    encryptedPassword,
    tokens,
    authCodes,
    profiles,
    parts,
    groups,
    entries
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String username = 'username';

  static const String email = 'email';

  static const String firstName = 'first_name';

  static const String lastName = 'last_name';

  static const String password = 'password';

  static const String encryptedPassword = 'encrypted_password';

  static const String tokens = 'tokens';

  static const String authCodes = 'auth_codes';

  static const String profiles = 'profiles';

  static const String parts = 'parts';

  static const String groups = 'groups';

  static const String entries = 'entries';
}

const ProfileSerializer profileSerializer = ProfileSerializer();

class ProfileEncoder extends Converter<Profile, Map> {
  const ProfileEncoder();

  @override
  Map convert(Profile model) => ProfileSerializer.toMap(model);
}

class ProfileDecoder extends Converter<Map, Profile> {
  const ProfileDecoder();

  @override
  Profile convert(Map map) => ProfileSerializer.fromMap(map);
}

class ProfileSerializer extends Codec<Profile, Map> {
  const ProfileSerializer();

  @override
  get encoder => const ProfileEncoder();
  @override
  get decoder => const ProfileDecoder();
  static Profile fromMap(Map map) {
    return Profile(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        presentation: map['presentation'] is ElementPresentation
            ? (map['presentation'] as ElementPresentation)
            : (map['presentation'] is int
                ? ElementPresentation.values[map['presentation'] as int]
                : null),
        tags: map['tags'] is Iterable
            ? (map['tags'] as Iterable).cast<dynamic>().toList()
            : null,
        owner: map['owner'] != null
            ? UserSerializer.fromMap(map['owner'] as Map)
            : null,
        version: map['version'] as int,
        title: map['title'] as String,
        subtitle: map['subtitle'] as String,
        parts: map['parts'] is Iterable
            ? List.unmodifiable(((map['parts'] as Iterable).whereType<Map>())
                .map(PartSerializer.fromMap))
            : null);
  }

  static Map<String, dynamic> toMap(_Profile model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'presentation': model.presentation == null
          ? null
          : ElementPresentation.values.indexOf(model.presentation),
      'tags': model.tags,
      'owner': UserSerializer.toMap(model.owner),
      'version': model.version,
      'title': model.title,
      'subtitle': model.subtitle,
      'parts': model.parts?.map((m) => PartSerializer.toMap(m))?.toList()
    };
  }
}

abstract class ProfileFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    presentation,
    tags,
    owner,
    version,
    title,
    subtitle,
    parts
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String presentation = 'presentation';

  static const String tags = 'tags';

  static const String owner = 'owner';

  static const String version = 'version';

  static const String title = 'title';

  static const String subtitle = 'subtitle';

  static const String parts = 'parts';
}

const PartSerializer partSerializer = PartSerializer();

class PartEncoder extends Converter<Part, Map> {
  const PartEncoder();

  @override
  Map convert(Part model) => PartSerializer.toMap(model);
}

class PartDecoder extends Converter<Map, Part> {
  const PartDecoder();

  @override
  Part convert(Map map) => PartSerializer.fromMap(map);
}

class PartSerializer extends Codec<Part, Map> {
  const PartSerializer();

  @override
  get encoder => const PartEncoder();
  @override
  get decoder => const PartDecoder();
  static Part fromMap(Map map) {
    return Part(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        presentation: map['presentation'] is ElementPresentation
            ? (map['presentation'] as ElementPresentation)
            : (map['presentation'] is int
                ? ElementPresentation.values[map['presentation'] as int]
                : null),
        tags: map['tags'] is Iterable
            ? (map['tags'] as Iterable).cast<dynamic>().toList()
            : null,
        owner: map['owner'] != null
            ? UserSerializer.fromMap(map['owner'] as Map)
            : null,
        version: map['version'] as int,
        profiles: map['profiles'] is Iterable
            ? List.unmodifiable(((map['profiles'] as Iterable).whereType<Map>())
                .map(ProfileSerializer.fromMap))
            : null,
        groups: map['groups'] is Iterable
            ? List.unmodifiable(((map['groups'] as Iterable).whereType<Map>())
                .map(GroupSerializer.fromMap))
            : null,
        type: map['type'] as String);
  }

  static Map<String, dynamic> toMap(_Part model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'presentation': model.presentation == null
          ? null
          : ElementPresentation.values.indexOf(model.presentation),
      'tags': model.tags,
      'owner': UserSerializer.toMap(model.owner),
      'version': model.version,
      'profiles':
          model.profiles?.map((m) => ProfileSerializer.toMap(m))?.toList(),
      'groups': model.groups?.map((m) => GroupSerializer.toMap(m))?.toList(),
      'type': model.type
    };
  }
}

abstract class PartFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    presentation,
    tags,
    owner,
    version,
    profiles,
    groups,
    type
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String presentation = 'presentation';

  static const String tags = 'tags';

  static const String owner = 'owner';

  static const String version = 'version';

  static const String profiles = 'profiles';

  static const String groups = 'groups';

  static const String type = 'type';
}

const GroupSerializer groupSerializer = GroupSerializer();

class GroupEncoder extends Converter<Group, Map> {
  const GroupEncoder();

  @override
  Map convert(Group model) => GroupSerializer.toMap(model);
}

class GroupDecoder extends Converter<Map, Group> {
  const GroupDecoder();

  @override
  Group convert(Map map) => GroupSerializer.fromMap(map);
}

class GroupSerializer extends Codec<Group, Map> {
  const GroupSerializer();

  @override
  get encoder => const GroupEncoder();
  @override
  get decoder => const GroupDecoder();
  static Group fromMap(Map map) {
    return Group(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        presentation: map['presentation'] is ElementPresentation
            ? (map['presentation'] as ElementPresentation)
            : (map['presentation'] is int
                ? ElementPresentation.values[map['presentation'] as int]
                : null),
        tags: map['tags'] is Iterable
            ? (map['tags'] as Iterable).cast<dynamic>().toList()
            : null,
        owner: map['owner'] != null
            ? UserSerializer.fromMap(map['owner'] as Map)
            : null,
        version: map['version'] as int,
        parts: map['parts'] is Iterable
            ? List.unmodifiable(((map['parts'] as Iterable).whereType<Map>())
                .map(PartSerializer.fromMap))
            : null,
        entries: map['entries'] is Iterable
            ? List.unmodifiable(((map['entries'] as Iterable).whereType<Map>())
                .map(EntrySerializer.fromMap))
            : null,
        type: map['type'] as String);
  }

  static Map<String, dynamic> toMap(_Group model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'presentation': model.presentation == null
          ? null
          : ElementPresentation.values.indexOf(model.presentation),
      'tags': model.tags,
      'owner': UserSerializer.toMap(model.owner),
      'version': model.version,
      'parts': model.parts?.map((m) => PartSerializer.toMap(m))?.toList(),
      'entries': model.entries?.map((m) => EntrySerializer.toMap(m))?.toList(),
      'type': model.type
    };
  }
}

abstract class GroupFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    presentation,
    tags,
    owner,
    version,
    parts,
    entries,
    type
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String presentation = 'presentation';

  static const String tags = 'tags';

  static const String owner = 'owner';

  static const String version = 'version';

  static const String parts = 'parts';

  static const String entries = 'entries';

  static const String type = 'type';
}

const EntrySerializer entrySerializer = EntrySerializer();

class EntryEncoder extends Converter<Entry, Map> {
  const EntryEncoder();

  @override
  Map convert(Entry model) => EntrySerializer.toMap(model);
}

class EntryDecoder extends Converter<Map, Entry> {
  const EntryDecoder();

  @override
  Entry convert(Map map) => EntrySerializer.fromMap(map);
}

class EntrySerializer extends Codec<Entry, Map> {
  const EntrySerializer();

  @override
  get encoder => const EntryEncoder();
  @override
  get decoder => const EntryDecoder();
  static Entry fromMap(Map map) {
    return Entry(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        presentation: map['presentation'] is ElementPresentation
            ? (map['presentation'] as ElementPresentation)
            : (map['presentation'] is int
                ? ElementPresentation.values[map['presentation'] as int]
                : null),
        tags: map['tags'] is Iterable
            ? (map['tags'] as Iterable).cast<dynamic>().toList()
            : null,
        owner: map['owner'] != null
            ? UserSerializer.fromMap(map['owner'] as Map)
            : null,
        version: map['version'] as int,
        entries: map['entries'] is Iterable
            ? List.unmodifiable(((map['entries'] as Iterable).whereType<Map>())
                .map(EntrySerializer.fromMap))
            : null,
        type: map['type'] as String);
  }

  static Map<String, dynamic> toMap(_Entry model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'presentation': model.presentation == null
          ? null
          : ElementPresentation.values.indexOf(model.presentation),
      'tags': model.tags,
      'owner': UserSerializer.toMap(model.owner),
      'version': model.version,
      'entries': model.entries?.map((m) => EntrySerializer.toMap(m))?.toList(),
      'type': model.type
    };
  }
}

abstract class EntryFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    presentation,
    tags,
    owner,
    version,
    entries,
    type
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String presentation = 'presentation';

  static const String tags = 'tags';

  static const String owner = 'owner';

  static const String version = 'version';

  static const String entries = 'entries';

  static const String type = 'type';
}

const ProfilePartJoinSerializer profilePartJoinSerializer =
    ProfilePartJoinSerializer();

class ProfilePartJoinEncoder extends Converter<ProfilePartJoin, Map> {
  const ProfilePartJoinEncoder();

  @override
  Map convert(ProfilePartJoin model) => ProfilePartJoinSerializer.toMap(model);
}

class ProfilePartJoinDecoder extends Converter<Map, ProfilePartJoin> {
  const ProfilePartJoinDecoder();

  @override
  ProfilePartJoin convert(Map map) => ProfilePartJoinSerializer.fromMap(map);
}

class ProfilePartJoinSerializer extends Codec<ProfilePartJoin, Map> {
  const ProfilePartJoinSerializer();

  @override
  get encoder => const ProfilePartJoinEncoder();
  @override
  get decoder => const ProfilePartJoinDecoder();
  static ProfilePartJoin fromMap(Map map) {
    return ProfilePartJoin(
        profile: map['profile'] != null
            ? ProfileSerializer.fromMap(map['profile'] as Map)
            : null,
        part: map['part'] != null
            ? PartSerializer.fromMap(map['part'] as Map)
            : null);
  }

  static Map<String, dynamic> toMap(_ProfilePartJoin model) {
    if (model == null) {
      return null;
    }
    return {
      'profile': ProfileSerializer.toMap(model.profile),
      'part': PartSerializer.toMap(model.part)
    };
  }
}

abstract class ProfilePartJoinFields {
  static const List<String> allFields = <String>[profile, part];

  static const String profile = 'profile';

  static const String part = 'part';
}

const PartGroupJoinSerializer partGroupJoinSerializer =
    PartGroupJoinSerializer();

class PartGroupJoinEncoder extends Converter<PartGroupJoin, Map> {
  const PartGroupJoinEncoder();

  @override
  Map convert(PartGroupJoin model) => PartGroupJoinSerializer.toMap(model);
}

class PartGroupJoinDecoder extends Converter<Map, PartGroupJoin> {
  const PartGroupJoinDecoder();

  @override
  PartGroupJoin convert(Map map) => PartGroupJoinSerializer.fromMap(map);
}

class PartGroupJoinSerializer extends Codec<PartGroupJoin, Map> {
  const PartGroupJoinSerializer();

  @override
  get encoder => const PartGroupJoinEncoder();
  @override
  get decoder => const PartGroupJoinDecoder();
  static PartGroupJoin fromMap(Map map) {
    return PartGroupJoin(
        part: map['part'] != null
            ? PartSerializer.fromMap(map['part'] as Map)
            : null,
        group: map['group'] != null
            ? GroupSerializer.fromMap(map['group'] as Map)
            : null);
  }

  static Map<String, dynamic> toMap(_PartGroupJoin model) {
    if (model == null) {
      return null;
    }
    return {
      'part': PartSerializer.toMap(model.part),
      'group': GroupSerializer.toMap(model.group)
    };
  }
}

abstract class PartGroupJoinFields {
  static const List<String> allFields = <String>[part, group];

  static const String part = 'part';

  static const String group = 'group';
}

const GroupEntryJoinSerializer groupEntryJoinSerializer =
    GroupEntryJoinSerializer();

class GroupEntryJoinEncoder extends Converter<GroupEntryJoin, Map> {
  const GroupEntryJoinEncoder();

  @override
  Map convert(GroupEntryJoin model) => GroupEntryJoinSerializer.toMap(model);
}

class GroupEntryJoinDecoder extends Converter<Map, GroupEntryJoin> {
  const GroupEntryJoinDecoder();

  @override
  GroupEntryJoin convert(Map map) => GroupEntryJoinSerializer.fromMap(map);
}

class GroupEntryJoinSerializer extends Codec<GroupEntryJoin, Map> {
  const GroupEntryJoinSerializer();

  @override
  get encoder => const GroupEntryJoinEncoder();
  @override
  get decoder => const GroupEntryJoinDecoder();
  static GroupEntryJoin fromMap(Map map) {
    return GroupEntryJoin(
        group: map['group'] != null
            ? GroupSerializer.fromMap(map['group'] as Map)
            : null,
        entry: map['entry'] != null
            ? EntrySerializer.fromMap(map['entry'] as Map)
            : null);
  }

  static Map<String, dynamic> toMap(_GroupEntryJoin model) {
    if (model == null) {
      return null;
    }
    return {
      'group': GroupSerializer.toMap(model.group),
      'entry': EntrySerializer.toMap(model.entry)
    };
  }
}

abstract class GroupEntryJoinFields {
  static const List<String> allFields = <String>[group, entry];

  static const String group = 'group';

  static const String entry = 'entry';
}

const ClientSerializer clientSerializer = ClientSerializer();

class ClientEncoder extends Converter<Client, Map> {
  const ClientEncoder();

  @override
  Map convert(Client model) => ClientSerializer.toMap(model);
}

class ClientDecoder extends Converter<Map, Client> {
  const ClientDecoder();

  @override
  Client convert(Map map) => ClientSerializer.fromMap(map);
}

class ClientSerializer extends Codec<Client, Map> {
  const ClientSerializer();

  @override
  get encoder => const ClientEncoder();
  @override
  get decoder => const ClientDecoder();
  static Client fromMap(Map map) {
    return Client(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        randomId: map['random_id'] as String,
        secret: map['secret'] as String,
        encryptedSecret: map['encrypted_secret'] as String,
        redirectUris: map['redirect_uris'] is Iterable
            ? (map['redirect_uris'] as Iterable).cast<dynamic>().toList()
            : null,
        allowedGrantTypes: map['allowed_grant_types'] is Iterable
            ? (map['allowed_grant_types'] as Iterable).cast<dynamic>().toList()
            : null,
        accessTokens: map['access_tokens'] is Iterable
            ? List.unmodifiable(
                ((map['access_tokens'] as Iterable).whereType<Map>())
                    .map(AuthTokenSerializer.fromMap))
            : null,
        authCodes: map['auth_codes'] is Iterable
            ? List.unmodifiable(
                ((map['auth_codes'] as Iterable).whereType<Map>())
                    .map(AuthCodeSerializer.fromMap))
            : null);
  }

  static Map<String, dynamic> toMap(_Client model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'random_id': model.randomId,
      'secret': model.secret,
      'encrypted_secret': model.encryptedSecret,
      'redirect_uris': model.redirectUris,
      'allowed_grant_types': model.allowedGrantTypes,
      'access_tokens': model.accessTokens
          ?.map((m) => AuthTokenSerializer.toMap(m))
          ?.toList(),
      'auth_codes':
          model.authCodes?.map((m) => AuthCodeSerializer.toMap(m))?.toList()
    };
  }
}

abstract class ClientFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    randomId,
    secret,
    encryptedSecret,
    redirectUris,
    allowedGrantTypes,
    accessTokens,
    authCodes
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String randomId = 'random_id';

  static const String secret = 'secret';

  static const String encryptedSecret = 'encrypted_secret';

  static const String redirectUris = 'redirect_uris';

  static const String allowedGrantTypes = 'allowed_grant_types';

  static const String accessTokens = 'access_tokens';

  static const String authCodes = 'auth_codes';
}

const TokenSerializer tokenSerializer = TokenSerializer();

class TokenEncoder extends Converter<Token, Map> {
  const TokenEncoder();

  @override
  Map convert(Token model) => TokenSerializer.toMap(model);
}

class TokenDecoder extends Converter<Map, Token> {
  const TokenDecoder();

  @override
  Token convert(Map map) => TokenSerializer.fromMap(map);
}

class TokenSerializer extends Codec<Token, Map> {
  const TokenSerializer();

  @override
  get encoder => const TokenEncoder();
  @override
  get decoder => const TokenDecoder();
  static Token fromMap(Map map) {
    return Token(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        token: map['token'] as String,
        scope: map['scope'] as String,
        expireAt: map['expire_at'] != null
            ? (map['expire_at'] is DateTime
                ? (map['expire_at'] as DateTime)
                : DateTime.parse(map['expire_at'].toString()))
            : null,
        user: map['user'] != null
            ? UserSerializer.fromMap(map['user'] as Map)
            : null,
        client: map['client'] != null
            ? ClientSerializer.fromMap(map['client'] as Map)
            : null);
  }

  static Map<String, dynamic> toMap(_Token model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'token': model.token,
      'scope': model.scope,
      'expire_at': model.expireAt?.toIso8601String(),
      'user': UserSerializer.toMap(model.user),
      'client': ClientSerializer.toMap(model.client)
    };
  }
}

abstract class TokenFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    token,
    scope,
    expireAt,
    user,
    client
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String token = 'token';

  static const String scope = 'scope';

  static const String expireAt = 'expire_at';

  static const String user = 'user';

  static const String client = 'client';
}

const AuthTokenSerializer authTokenSerializer = AuthTokenSerializer();

class AuthTokenEncoder extends Converter<AuthToken, Map> {
  const AuthTokenEncoder();

  @override
  Map convert(AuthToken model) => AuthTokenSerializer.toMap(model);
}

class AuthTokenDecoder extends Converter<Map, AuthToken> {
  const AuthTokenDecoder();

  @override
  AuthToken convert(Map map) => AuthTokenSerializer.fromMap(map);
}

class AuthTokenSerializer extends Codec<AuthToken, Map> {
  const AuthTokenSerializer();

  @override
  get encoder => const AuthTokenEncoder();
  @override
  get decoder => const AuthTokenDecoder();
  static AuthToken fromMap(Map map) {
    return AuthToken(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        token: map['token'] as String,
        scope: map['scope'] as String,
        expireAt: map['expire_at'] != null
            ? (map['expire_at'] is DateTime
                ? (map['expire_at'] as DateTime)
                : DateTime.parse(map['expire_at'].toString()))
            : null,
        user: map['user'] != null
            ? UserSerializer.fromMap(map['user'] as Map)
            : null,
        client: map['client'] != null
            ? ClientSerializer.fromMap(map['client'] as Map)
            : null,
        refreshToken: map['refresh_token'] as String);
  }

  static Map<String, dynamic> toMap(_AuthToken model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'token': model.token,
      'scope': model.scope,
      'expire_at': model.expireAt?.toIso8601String(),
      'user': UserSerializer.toMap(model.user),
      'client': ClientSerializer.toMap(model.client),
      'refresh_token': model.refreshToken
    };
  }
}

abstract class AuthTokenFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    token,
    scope,
    expireAt,
    user,
    client,
    refreshToken
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String token = 'token';

  static const String scope = 'scope';

  static const String expireAt = 'expire_at';

  static const String user = 'user';

  static const String client = 'client';

  static const String refreshToken = 'refresh_token';
}

const AuthCodeSerializer authCodeSerializer = AuthCodeSerializer();

class AuthCodeEncoder extends Converter<AuthCode, Map> {
  const AuthCodeEncoder();

  @override
  Map convert(AuthCode model) => AuthCodeSerializer.toMap(model);
}

class AuthCodeDecoder extends Converter<Map, AuthCode> {
  const AuthCodeDecoder();

  @override
  AuthCode convert(Map map) => AuthCodeSerializer.fromMap(map);
}

class AuthCodeSerializer extends Codec<AuthCode, Map> {
  const AuthCodeSerializer();

  @override
  get encoder => const AuthCodeEncoder();
  @override
  get decoder => const AuthCodeDecoder();
  static AuthCode fromMap(Map map) {
    return AuthCode(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        token: map['token'] as String,
        scope: map['scope'] as String,
        expireAt: map['expire_at'] != null
            ? (map['expire_at'] is DateTime
                ? (map['expire_at'] as DateTime)
                : DateTime.parse(map['expire_at'].toString()))
            : null,
        user: map['user'] != null
            ? UserSerializer.fromMap(map['user'] as Map)
            : null,
        client: map['client'] != null
            ? ClientSerializer.fromMap(map['client'] as Map)
            : null,
        redirectUri: map['redirect_uri'] as String);
  }

  static Map<String, dynamic> toMap(_AuthCode model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'token': model.token,
      'scope': model.scope,
      'expire_at': model.expireAt?.toIso8601String(),
      'user': UserSerializer.toMap(model.user),
      'client': ClientSerializer.toMap(model.client),
      'redirect_uri': model.redirectUri
    };
  }
}

abstract class AuthCodeFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    token,
    scope,
    expireAt,
    user,
    client,
    redirectUri
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String token = 'token';

  static const String scope = 'scope';

  static const String expireAt = 'expire_at';

  static const String user = 'user';

  static const String client = 'client';

  static const String redirectUri = 'redirect_uri';
}
