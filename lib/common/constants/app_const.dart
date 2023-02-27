// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AppConst {
  AppConst._();

  static const EMPTY_STRING = '';

  static String MAP_API_KEY = "AIzaSyCPSjkk8X9GAigUMdM1aCMD427I-tu3dIk";
  static String TEI_KEY = "TEI_KEY";
  static String NRM_KEY = "NRM_KEY";
  static String PHONE_NUMBER_KEY = "PHONE_NUMBER_KEY";
  static String AUTH_TOKEN = "AUTH_TOKEN";
  static String CURRENT_USER = "CURRENT_USER";
  static String INVALID_TOKEN = "Token is invalid please login";
  static String INVALID_TOKEN_OTHER = "invalid-token";
  static String HOME_SERVICE = "Pelayanan di rumah";
  static String CLINIC_SERVICE = "Kunjungan Klinik";
  static String OPEN_FEEDBACK_KEY = "OPEN_FEEDBACK";
  static Map<String, dynamic> STATUS_PAYMENT = {
    "0": "Menunggu proses pembayaran!",
    "1": "Pembayaran dalam proses!",
    "2": "Pembayaran berhasil!",
    "4": "Payment Reserval",
    "5": "No bills found",
    "8": "Payment Cancelled",
    "9": "Unknown",
  };

  static Map<String, Widget> ICON_PAYMENT_STATUS = {
    "0": const Icon(FeatherIcons.loader, color: Color(0xffFF9900)),
    "1": const Icon(FeatherIcons.watch, color: Color(0xffFF9900)),
    "2": const Icon(FeatherIcons.checkCircle, color: Colors.green),
    "4": const Icon(FeatherIcons.checkCircle, color: Colors.green),
    "5": const Icon(FeatherIcons.stopCircle, color: Colors.red),
    "8": const Icon(FeatherIcons.stopCircle, color: Colors.red),
    "9": const Icon(FeatherIcons.stopCircle, color: Colors.red),
  };

  static Map<String, Color> COLOR_PAYMENT_STATUS = {
    "0": const Color(0xffFF9900),
    "1": const Color(0xffFF9900),
    "2": Colors.green,
    "4": Colors.green,
    "5": Colors.red,
    "8": Colors.red,
    "9": Colors.red,
  };
}
