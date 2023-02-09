import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Helpers {
  Helpers._();
  static var storage = const FlutterSecureStorage();
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void printDebug(value) {
    if (kDebugMode) {
      log("VALUE :: $value");
    }
  }

  static Future<String?> readLocalStorage(String key)async{
     return storage.read(key: key);
  }
}
