import 'package:get_it/get_it.dart';
import 'package:jd_mobile/data/datasources/http_services.dart';
import 'package:jd_mobile/data/datasources/patient/patient_api.dart';
import 'package:jd_mobile/data/repositories/patient/patient_repository_impl.dart';
import 'package:jd_mobile/domain/repositories/patient_repositorty.dart';
import 'package:jd_mobile/domain/usecases/patient/create_patient.dart';
import 'package:jd_mobile/persentation/provider/patient_provider.dart';

final GetIt getIt = GetIt.instance;

Future setup() async {
  // PROVIDER
  getIt.registerFactory<PatientProvider>(() => PatientProvider(createPatient: getIt()));

  // USECASE
  getIt.registerLazySingleton<CreatePatient>(() => CreatePatient(getIt()));

  // REPOSITORY
  getIt.registerLazySingleton<PatientRepository>(() => PatientRepositoryImpl(api: getIt()));

  // API
  getIt.registerLazySingleton<PatientApi>(() => PatientApi(getIt<HttpService>().dio));

  // Http Service
  getIt.registerLazySingleton<HttpService>(() => HttpService());
}
