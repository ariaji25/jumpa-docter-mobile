import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jd_mobile/common/routes/routes.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/pages/doctor/serach_doctor_page.dart';
import 'package:jd_mobile/persentation/pages/global/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      theme: AppTheme.light,
      title: 'JumpaDokter',
      onGenerateRoute: AppRoutes.generateRoute,
      home: const SearchDoctorPage(),
    );
  }
}
