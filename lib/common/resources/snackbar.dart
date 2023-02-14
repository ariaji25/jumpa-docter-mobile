import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:jd_mobile/common/theme/theme.dart';

import 'size.dart';

enum SnackBarType { success, warning, error }

class SnackBarCustom {
  SnackBarCustom._();

  static void showSnackBarMessage(
      {typeMessage = SnackBarType.success,
      required BuildContext context,
      required String title,
      required String message,
      int duration = 3}) {
    Map<String, dynamic> data = getProperty(typeMessage);
    Flushbar(
      title: title,
      titleColor: data['color'],
      messageText: Text(
        message,
        style: AppTheme.subtitle.copyWith(
            color: data['color'], fontSize: 14, fontWeight: FontWeight.w600),
      ),
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: data['colorIcon'],
          shape: BoxShape.circle,
        ),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            data['icon'],
            size: 15,
            color: data['colorIcon'],
          ),
        ),
      ),
      margin: const EdgeInsets.only(
          top: SizeConstants.margin,
          left: SizeConstants.margin,
          right: SizeConstants.margin),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
      backgroundColor: data['backgroundColor'],
      borderRadius: BorderRadius.circular(16),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      duration: Duration(seconds: duration),
    ).show(context);
  }

  static Map<String, dynamic> getProperty(SnackBarType typeMessage) {
    if (typeMessage == SnackBarType.success) {
      return {
        "color": const Color(0XFF4AAE8C),
        "colorIcon": const Color(0XFF8CDFB3),
        "backgroundColor": const Color(0XFFDEFFEE),
        "icon": Icons.check
      };
    } else if (typeMessage == SnackBarType.warning) {
      return {
        "color": Colors.white,
        "colorIcon": const Color(0XFFb35a00),
        "backgroundColor": const Color(0XFFff8000),
        "icon": Icons.info_outline
      };
    } else {
      return {
        "color": Colors.white,
        "colorIcon": const Color(0XFFb30000),
        "backgroundColor": const Color(0XFFFF0000),
        "icon": Icons.error_outline
      };
    }
  }
}
