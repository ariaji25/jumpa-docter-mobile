import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:jd_mobile/data/datasources/http_services.dart';
import 'package:jd_mobile/data/repositories/auth/auth_repository_impl.dart';
import 'package:jd_mobile/domain/repositories/auth/auth_repository.dart';
import 'package:jd_mobile/domain/usecases/auth/sign_in.dart';
import 'package:jd_mobile/domain/usecases/patient/create_patient_nrm.dart';
import 'package:jd_mobile/domain/usecases/patient/detail_patient_by_nrm.dart';
import 'package:jd_mobile/domain/usecases/patient/update_patient.dart';
import 'package:jd_mobile/persentation/provider/auth/auth_provider.dart';
import 'package:jd_mobile/persentation/provider/map/map_provider.dart';

import 'data/datasources/firebase/auth/auth_firebase.dart';
import 'data/datasources/firebase/auth/auth_firebase_impl.dart';
import 'data/datasources/patient/patient_api.dart';
import 'data/repositories/patient/patient_repository_impl.dart';
import 'domain/repositories/patient/patient_repositorty.dart';
import 'domain/usecases/patient/create_patient.dart';
import 'persentation/provider/patient/patient_provider.dart';

final GetIt getIt = GetIt.instance;

Future setup() async {
  // Provider
  getIt.registerFactory<AuthProvider>(() => AuthProvider(signIn: getIt()));
  getIt.registerFactory<PatientProvider>(() => PatientProvider(
      createPatient: getIt(),
      createPatientNrm: getIt(),
      updatePatient: getIt(),
      detailPatientByNrm: getIt()));
  getIt.registerFactory<MapProvider>(() => MapProvider());

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authFirebase: getIt()));
  getIt.registerLazySingleton<PatientRepository>(
      () => PatientRepositoryImpl(api: getIt()));

  // Usecase
  getIt.registerLazySingleton<SignIn>(() => SignIn(getIt()));
  getIt.registerLazySingleton<CreatePatient>(() => CreatePatient(getIt()));
  getIt
      .registerLazySingleton<CreatePatientNrm>(() => CreatePatientNrm(getIt()));
  getIt.registerLazySingleton<UpdatePatient>(() => UpdatePatient(getIt()));
  getIt.registerLazySingleton<DetailPatientByNrm>(
      () => DetailPatientByNrm(getIt()));

  // External
  final auth = FirebaseAuth.instance;
  getIt.registerLazySingleton(() => auth);

  // Http Service
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerLazySingleton<AuthFirebase>(
      () => AuthFirebaseImpl(auth: getIt()));
  getIt.registerLazySingleton<PatientApi>(
      () => PatientApi(getIt<HttpService>().dio));
}
