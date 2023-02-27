import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

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

  static String getInitials(String? nama, [bool isInitial = true]) {
    if (nama == null || nama == "") return "-";
    return nama[0].toUpperCase();
  }

  static String twoDigits(int n) => n.toString().padLeft(2, '0');

  static Future<String?> readLocalStorage(String key) async {
    return storage.read(key: key);
  }

  static Future<void> writeLocalStorage(String key, String value) async {
    return storage.write(key: key, value: value);
  }

  // Format string to currency rupiah
  static String formatCurrency(String value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatter.format(double.parse(value));
  }
}
