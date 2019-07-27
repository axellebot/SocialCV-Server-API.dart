import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:social_cv_api/src/models/models.dart';

Future<bool> parseUser(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final User user = UserSerializer.fromMap(req.bodyAsMap);

  req.params['user'] = user;

  return true;
}

Future<bool> parseProfile(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final Profile profile = ProfileSerializer.fromMap(req.bodyAsMap);

  req.params['profile'] = profile;

  return true;
}

Future<bool> parsePart(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final Part part = PartSerializer.fromMap(req.bodyAsMap);

  req.params['part'] = part;

  return true;
}

Future<bool> parseGroup(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final Group group = GroupSerializer.fromMap(req.bodyAsMap);

  req.params['group'] = group;

  return true;
}

Future<bool> parseEntry(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final Entry entry = EntrySerializer.fromMap(req.bodyAsMap);

  req.params['entry'] = entry;

  return true;
}
