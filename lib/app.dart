import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jd_mobile/common/routes/routes.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/domain/usecases/patient/create_patient.dart';
import 'package:jd_mobile/persentation/pages/global/splash_page.dart';
import 'package:jd_mobile/persentation/provider/map_provider.dart';
import 'package:jd_mobile/persentation/provider/patient_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: kDebugMode,
        theme: AppTheme.light,
        title: 'JumpaDokter',
        onGenerateRoute: AppRoutes.generateRoute,
        home: const SplashPage(),
      ),
    );
  }
}
