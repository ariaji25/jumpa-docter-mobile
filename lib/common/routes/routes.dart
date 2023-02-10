import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_mobile/persentation/pages/account/about_page.dart';
import 'package:jd_mobile/persentation/pages/account/components/map/map_page.dart';
import 'package:jd_mobile/persentation/pages/auth/login_page.dart';
import 'package:jd_mobile/persentation/pages/auth/otp_page.dart';
import 'package:jd_mobile/persentation/pages/base/base_page.dart';
import 'package:jd_mobile/persentation/pages/global/on_boarding_page.dart';
import 'package:jd_mobile/persentation/pages/global/splash_page.dart';
import 'package:jd_mobile/persentation/pages/order/complaint_page.dart';

import '../../persentation/pages/account/profile_form.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
      case OnBoardingPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const OnBoardingPage(),
          settings: settings,
        );
      case LoginPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case OtpPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const OtpPage(),
          settings: settings,
        );
      case BasePage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const BasePage(),
          settings: settings,
        );
      case ComplaintPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const ComplaintPage(),
          settings: settings,
        );
      case AboutPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const AboutPage(),
          settings: settings,
        );
      case ProfileForm.routeName:
        return CupertinoPageRoute(
          builder: (_) => const ProfileForm(),
          settings: settings,
        );
      case MapPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => MapPage(onTap: (value) {}),
          settings: settings,
        );

      default:
        return CupertinoPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text('Page not found :(')),
            );
          },
        );
    }
  }
}
