import 'package:get_it/get_it.dart';
import 'package:jd_mobile/data/datasources/http_services.dart';

final GetIt getIt = GetIt.instance;

Future setup() async {
  // Http Service
  getIt.registerLazySingleton<HttpService>(() => HttpService());
}
