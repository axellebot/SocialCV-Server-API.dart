import 'dart:convert';
import 'dart:math';

import 'package:uuid/uuid.dart';

class Utils {
  static final Random _random = Random.secure();
  static final Uuid _uuid = Uuid();

  static String createCryptoRandomString([int length = 32]) {
    final values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }

  static String createUuid() {
    return _uuid.v4();
  }

  static DateTime createTokenExpirationDate() {
    return DateTime.now().add(Duration(days: 10));
  }
}
