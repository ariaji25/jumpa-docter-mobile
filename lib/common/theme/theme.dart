import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jd_mobile/common/resources/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        colorScheme: const ColorScheme(
          primary: AppColors.primaryColor,
          secondary: AppColors.primaryColor,
          surface: AppColors.whiteColor,
          background: AppColors.whiteColor,
          error: AppColors.redPrimaryColor,
          onPrimary: AppColors.whiteColor,
          onSecondary: AppColors.whiteColor,
          onSurface: Colors.black,
          onBackground: AppColors.whiteColor,
          onError: AppColors.whiteColor,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          headline5: heading5,
          headline6: heading6,
          subtitle1: subtitle,
          bodyText2: bodyText,
        ),
      );

  // Part
  static TextStyle get heading5 {
    return GoogleFonts.inter(
      fontSize: 23,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get heading6 {
    return GoogleFonts.inter(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    );
  }

  static TextStyle get subtitle {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    );
  }

  static TextStyle get bodyText {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    );
  }
}
