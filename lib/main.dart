import 'package:flutter/material.dart';
import 'package:jd_mobile/app.dart';
import 'package:jd_mobile/common/env/env.dart';
import 'injection.dart' as di;

void main() {
  di.getIt.registerLazySingleton(() => EnvType.staging);
  di.setup();
  runApp(const MyApp());
}
