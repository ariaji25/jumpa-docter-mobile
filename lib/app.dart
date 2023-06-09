// ignore_for_file: depend_on_referenced_packages

import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/routes/routes.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/pages/global/splash_page.dart';
import 'package:jd_mobile/persentation/provider/article/article_provider.dart';
import 'package:jd_mobile/persentation/provider/auth/auth_provider.dart';
import 'package:jd_mobile/persentation/provider/chat/chat_room_provider.dart';
import 'package:jd_mobile/persentation/provider/chat/room_chat_provider.dart';
import 'package:jd_mobile/persentation/provider/home/home_provider.dart';
import 'package:jd_mobile/persentation/provider/map/map_provider.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
import 'package:jd_mobile/persentation/provider/patient/patient_provider.dart';
import 'package:jd_mobile/persentation/provider/payment/payment_provider.dart';
import 'package:jd_mobile/persentation/provider/schedule/schedule_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'injection.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<PatientProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<MapProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<ChatRoomProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<RoomChatProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<HomeProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<ArticleProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<ScheduleProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<OrderProvider>()),
        ChangeNotifierProvider(create: (_) => di.getIt<PaymentProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: kDebugMode,
        theme: AppTheme.light,
        title: 'JumpaDokter',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('id', 'ID'),
        ],
        onGenerateRoute: AppRoutes.generateRoute,
        home: Builder(
          builder: (context) {
            showDebugBtn(
              context,
              btnColor: AppColors.primaryColor.withOpacity(.7),
            );
            return const SplashPage();
          },
        ),
      ),
    );
  }
}
