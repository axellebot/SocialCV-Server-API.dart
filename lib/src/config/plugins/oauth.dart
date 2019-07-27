import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_oauth2/angel_oauth2.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_api/src/models/models.dart';
import 'package:social_cv_api/src/utility/utils.dart';

Future<void> configureServer(Angel app) async {
  final queryExecutor = app.container.make<QueryExecutor>();
  final oauthAuthServer = OAuthAuthorizationServer(executor: queryExecutor);
  app.container.registerSingleton<OAuthAuthorizationServer>(oauthAuthServer);
}

/// A [Client] can act on behalf of a [User].
class OAuthAuthorizationServer extends AuthorizationServer<Client, User> {
  OAuthAuthorizationServer({@required this.executor})
      : assert(executor != null);

  final QueryExecutor executor;

  @override
  FutureOr<Client> findClient(String clientId) async {
    final q = ClientQuery()..where.randomId.equals(clientId);
    return await q.getOne(executor);
  }

  @override
  FutureOr<bool> verifyClient(Client client, String clientSecret) async {
    return client.validatePassword(clientSecret);
  }

  @override
  FutureOr<void> requestAuthorizationCode(
      Client client,
      String redirectUri,
      Iterable<String> scopes,
      String state,
      RequestContext req,
      ResponseContext res,
      bool implicit) {
    res.render('');
  }

  /// Exchanges an authorization code for an authorization token.
  @override
  FutureOr<AuthorizationTokenResponse> exchangeAuthorizationCodeForToken(
      Client client,
      String authCode,
      String redirectUri,
      RequestContext req,
      ResponseContext res) async {
    //final body = await req.parseBody().then((_) => req.bodyAsMap);

    final q1 = AuthCodeQuery()..where.token.equals(authCode);

    final AuthCode aC = await q1.getOne(executor);

    // Generate token and access token

    final q2 = AuthTokenQuery()
      ..values.id = Utils.createUuid()
      ..values.token = Utils.createCryptoRandomString()
      ..values.refreshToken = Utils.createCryptoRandomString()
      ..values.expireAt = Utils.createTokenExpirationDate();

    final AuthToken authToken = await q2.insert(executor);

    if (authToken == null) {
      throw "Can't create authorization token";
    }

    // Return Authorization token response

    return AuthorizationTokenResponse(
      authToken.token,
      refreshToken: authToken.refreshToken,
      expiresIn: authToken.expiresIn,
      scope: authToken.scope.split(','),
    );
  }

  /// Refresh an authorization token.
  @override
  FutureOr<AuthorizationTokenResponse> refreshAuthorizationToken(
      Client client,
      String refreshToken,
      Iterable<String> scopes,
      RequestContext req,
      ResponseContext res) async {
    //final body = await req.parseBody().then((_) => req.bodyAsMap);

    // Find auth token entry
    final q = AuthTokenQuery()..where.refreshToken.equals(refreshToken);

    final AuthToken authToken = await q.getOne(executor);

    if (authToken == null) {
      throw "No auth token found";
    }

    // Update auth token entry

    final q2 = q
      ..values.id = Utils.createUuid()
      ..values.token = Utils.createCryptoRandomString()
      ..values.refreshToken = Utils.createCryptoRandomString()
      ..values.expireAt = Utils.createTokenExpirationDate();

    final AuthToken authToken2 = await q2.updateOne(executor);

    if (authToken2 == null) {
      throw "Can't refresh authorization token";
    }

    // Return Authorization token response
    return AuthorizationTokenResponse(
      authToken2.token,
      refreshToken: authToken2.refreshToken,
      expiresIn: authToken2.expiresIn,
      scope: authToken2.scope.split(','),
    );
  }

  /// --------------------------------------------------------------------------
  ///                                  Grants
  /// --------------------------------------------------------------------------

  /// Issue an authorization token to a user after authenticating them via
  /// [username] and [password].
  @override
  FutureOr<AuthorizationTokenResponse> resourceOwnerPasswordCredentialsGrant(
      Client client,
      String username,
      String password,
      Iterable<String> scopes,
      RequestContext req,
      ResponseContext res) async {
    //final body = await req.parseBody().then((_) => req.bodyAsMap);

    // Check client

    final List<String> grantTypes = client.allowedGrantTypes.cast<String>();

    if (grantTypes.contains('ressource_owner')) {
      throw 'Unauthorized';
    }

    // Check user credential
    final q2 = UserQuery()..where.username.equals(username);

    final User user = await q2.getOne(executor);

    if (user == null) {
      throw 'Wrong user credntials';
    }

    // Generate token and access token

    final q3 = AuthTokenQuery()
      ..values.id = Utils.createUuid()
      ..values.token = Utils.createCryptoRandomString()
      ..values.refreshToken = Utils.createCryptoRandomString()
      ..values.expireAt = Utils.createTokenExpirationDate();

    final AuthToken authToken = await q3.insert(executor);

    if (authToken == null) {
      throw "Can't create authorization token";
    }

    // Return Authorization token response

    return AuthorizationTokenResponse(
      authToken.token,
      refreshToken: authToken.refreshToken,
      expiresIn: authToken.expiresIn,
      scope: authToken.scope.split(','),
    );
  }

//  /// Performs a client credentials grant. Only use this in situations where
//  /// the client is 100% trusted.
//  @override
//  FutureOr<AuthorizationTokenResponse> clientCredentialsGrant(
//      Client client, RequestContext req, ResponseContext res) async {
//    //final body = await req.parseBody().then((_) => req.bodyAsMap);
//  }
}
