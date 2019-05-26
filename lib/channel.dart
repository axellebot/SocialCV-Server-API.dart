import 'package:social_cv_api/social_cv_api.dart';

import 'utility/html_template.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class SocialCvApiChannel extends ApplicationChannel
    implements AuthRedirectControllerDelegate {
  final HTMLRenderer htmlRenderer = HTMLRenderer();
  AuthServer authServer;
  ManagedContext context;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = SocialCvApiConfiguration(options.configurationFilePath);

    context = contextWithConnectionInfo(config.database);

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    /* OAuth 2.0 Endpoints */
    router.route("/auth/token").link(() => AuthController(authServer));

    router
        .route("/auth/form")
        .link(() => AuthRedirectController(authServer, delegate: this));

    /* Create an account */
    router
        .route("/register")
        .link(() => Authorizer.basic(authServer))
        .link(() => RegisterController(context, authServer));

    /* Get identity for user with bearer token */
    router
        .route("/me")
        .link(() => Authorizer.bearer(authServer))
        .link(() => IdentityController(context));

    /* Get profiles for user with bearer token */
    router
        .route("/me/profiles")
        .link(() => Authorizer.bearer(authServer))
        .link(() => IdentityProfilesController(context));

    /* Get parts for user with bearer token */
    router
        .route("/me/parts")
        .link(() => Authorizer.bearer(authServer))
        .link(() => IdentityPartsController(context));

    /* Get groups for user with bearer token */
    router
        .route("/me/groups")
        .link(() => Authorizer.bearer(authServer))
        .link(() => IdentityGroupsController(context));

    /* Get entries for user with bearer token */
    router
        .route("/me/entries")
        .link(() => Authorizer.bearer(authServer))
        .link(() => IdentityEntriesController(context));

    /* Gets all users or one specific user by id */
    router
        .route("/users/[:userId]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => UserController(context, authServer));

    /* Gets all profiles of one specific user by id */
    router
        .route("/users/:userId/profiles")
        .link(() => Authorizer.bearer(authServer))
        .link(() => UserProfilesController(context, authServer));

    /* Gets all parts of one specific user by id */
    router
        .route("/users/:userId/parts")
        .link(() => Authorizer.bearer(authServer))
        .link(() => UserPartsController(context, authServer));

    /* Gets all groups of one specific user by id */
    router
        .route("/users/:userId/groups")
        .link(() => Authorizer.bearer(authServer))
        .link(() => UserGroupsController(context, authServer));

    /* Gets all entries of one specific user by id */
    router
        .route("/users/:userId/entries")
        .link(() => Authorizer.bearer(authServer))
        .link(() => UserEntriesController(context, authServer));

    /* Gets all profiles or one specific profile by id */
    router
        .route("/profiles/[:profileId]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => ProfileController(context, authServer));

    /* Gets all parts of one specific profile by id */
    router
        .route("/profiles/:profileId/parts")
        .link(() => Authorizer.bearer(authServer))
        .link(() => ProfilePartsController(context, authServer));

    /* Gets all parts or one specific part by id */
    router
        .route("/parts/[:partId]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => PartController(context, authServer));

    /* Gets all groups of one specific part by id */
    router
        .route("/parts/:partId/groups")
        .link(() => Authorizer.bearer(authServer))
        .link(() => PartGroupsController(context, authServer));

    /* Gets all groups or one specific group by id */
    router
        .route("/groups/[:groupId]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => GroupController(context, authServer));

    /* Gets all entries of one specific group by id */
    router
        .route("/groups/:groupId/entries")
        .link(() => Authorizer.bearer(authServer))
        .link(() => GroupEntriesController(context, authServer));

    /* Gets all entries or one specific entry by id */
    router
        .route("/entries/[:entryId]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => EntryController(context, authServer));

    return router;
  }

  /*
   * Helper methods
   */

  ManagedContext contextWithConnectionInfo(
      DatabaseConfiguration connectionInfo) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore(
        connectionInfo.username,
        connectionInfo.password,
        connectionInfo.host,
        connectionInfo.port,
        connectionInfo.databaseName);

    return ManagedContext(dataModel, psc);
  }

  @override
  Future<String> render(AuthRedirectController forController, Uri requestUri,
      String responseType, String clientID, String state, String scope) async {
    final map = {
      "response_type": responseType,
      "client_id": clientID,
      "state": state
    };

    map["path"] = requestUri.path;
    if (scope != null) {
      map["scope"] = scope;
    }

    return htmlRenderer.renderHTML("web/login.html", map);
  }
}

/// An instance of this class represents values from a configuration
/// file specific to this application.
///
/// Configuration files must have key-value for the properties in this class.
/// For more documentation on configuration files, see
/// https://pub.dartlang.org/packages/safe_config.
class SocialCvApiConfiguration extends Configuration {
  SocialCvApiConfiguration(String fileName) : super.fromFile(File(fileName));

  DatabaseConfiguration database;
}
