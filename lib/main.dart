import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jd_mobile/app.dart';
import 'package:jd_mobile/common/env/env.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  di.getIt.registerLazySingleton(() => EnvType.staging);
  di.setup();
  runApp(const MyApp());
} 