import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:social_cv_api/src/models/models.dart';

Future<User> parseUser(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final User user = UserSerializer.fromMap(req.bodyAsMap);

  return user;
}

Future<Profile> parseProfile(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final Profile profile = ProfileSerializer.fromMap(req.bodyAsMap);

  return profile;
}

Future<Part> parsePart(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final Part part = PartSerializer.fromMap(req.bodyAsMap);

  return part;
}

Future<Group> parseGroup(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final Group group = GroupSerializer.fromMap(req.bodyAsMap);

  return group;
}

Future<Entry> parseEntry(RequestContext req, ResponseContext res) async {
  // Parse the body, if it has not already been parsed.
  await req.parseBody();

  final Entry entry = EntrySerializer.fromMap(req.bodyAsMap);

  return entry;
}
