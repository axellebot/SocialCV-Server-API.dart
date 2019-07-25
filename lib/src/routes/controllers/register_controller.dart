import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:social_cv_api/src/middlewares/parser_middleware.dart' as parser;
import 'package:social_cv_api/src/models/models.dart';

@Expose('/register')
class RegisterController extends Controller {
  // Auto-injected by Angel
  final QueryExecutor executor;

  RegisterController(this.executor);

  @Expose('', method: 'POST', middleware: [parser.parseUser])
  FutureOr<User> createUser(User user, User authenticatedUser) async {
    // Check for required parameters before we spend time hashing
    if (user.username == null || user.password == null) {
      throw AngelHttpException.badRequest(
        message: "username and password required.",
      );
    }

//    user
//      ..salt = AuthUtility.generateRandomSalt()
//      ..encryptedPassword = authServer.hashPassword(user.password, user.salt);
//
//    final query = UserQuery()..values = user;
//
//    final newUser = await query.insert();
//    final token = await authServer.authenticate(
//        user.username,
//        user.password,
//        request.authorization.credentials.username,
//        request.authorization.credentials.password);
//
//    final response = AuthController.tokenResponse(token);
//    final newBody = newUser.asMap()..["authorization"] = response.body;
//    return response..body = newBody;
  }

//  @override
//  Map<String, APIResponse> documentOperationResponses(
//      APIDocumentContext context, Operation operation) {
//    return {
//      "200": APIResponse.schema("User successfully registered.",
//          context.schema.getObject("UserRegistration")),
//      "400": APIResponse.schema("Error response", APISchemaObject.freeForm())
//    };
//  }
}
