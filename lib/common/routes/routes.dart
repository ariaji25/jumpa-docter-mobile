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
import 'package:jd_mobile/persentation/pages/order/doctor_page.dart';

import '../../persentation/pages/account/profile_form.dart';
import '../../persentation/pages/articles/article_page.dart';
import '../../persentation/pages/articles/detail_article_page.dart';
import '../../persentation/pages/chat/chat_page.dart';
import '../../persentation/pages/chat/chat_room_page.dart';
import '../../persentation/pages/chat/list_doctor_page.dart';
import '../../persentation/pages/chat/payment_chat_page.dart';
import '../../persentation/pages/chat/specialization_page.dart';
import '../../persentation/pages/feedback/feedback_doctor_page.dart';
import '../../persentation/pages/order/schedule_page.dart';
import '../../persentation/pages/order/summary_page.dart';
import '../../persentation/pages/webview/webview_page.dart';
import '../../persentation/pages/notifications/notification_page.dart';

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
      case ChatPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const ChatPage(),
          settings: settings,
        );
      case ChatRoomPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const ChatRoomPage(),
          settings: settings,
        );
      case ListDoctorPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const ListDoctorPage(),
          settings: settings,
        );
      case PaymentChatPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const PaymentChatPage(),
          settings: settings,
        );
      case SpecializationPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const SpecializationPage(),
          settings: settings,
        );
      case FeedbackDoctorPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const FeedbackDoctorPage(),
          settings: settings,
        );
      case ArticlePage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const ArticlePage(),
          settings: settings,
        );
      case DetailArticlePage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const DetailArticlePage(),
          settings: settings,
        );
      case NotificationPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const NotificationPage(),
          settings: settings,
        );
      case WebViewPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const WebViewPage(),
          settings: settings,
        );
      case DoctorPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const DoctorPage(),
          settings: settings,
        );
      case AppointmentSchedulePage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const AppointmentSchedulePage(),
          settings: settings,
        );
      case SummaryPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const SummaryPage(),
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
