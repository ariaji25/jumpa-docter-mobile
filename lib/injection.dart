import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:jd_mobile/data/datasources/http_services.dart';
import 'package:jd_mobile/data/repositories/auth/auth_repository_impl.dart';
import 'package:jd_mobile/domain/repositories/auth/auth_repository.dart';
import 'package:jd_mobile/domain/usecases/auth/sign_in.dart';
import 'package:jd_mobile/persentation/provider/auth/auth_provider.dart';

import 'data/datasources/firebase/auth/auth_firebase.dart';
import 'data/datasources/firebase/auth/auth_firebase_impl.dart';
import 'data/datasources/patient/patient_api.dart';
import 'data/repositories/patient/patient_repository_impl.dart';
import 'domain/repositories/patient_repositorty.dart';
import 'domain/usecases/patient/create_patient.dart';
import 'persentation/provider/patient_provider.dart';

final GetIt getIt = GetIt.instance;

Future setup() async {
  // PROVIDER
  getIt.registerFactory<PatientProvider>(
      () => PatientProvider(createPatient: getIt()));

  // USECASE
  getIt.registerLazySingleton<CreatePatient>(() => CreatePatient(getIt()));

  // REPOSITORY
  getIt.registerLazySingleton<PatientRepository>(
      () => PatientRepositoryImpl(api: getIt()));

  // API
  getIt.registerLazySingleton<PatientApi>(
      () => PatientApi(getIt<HttpService>().dio));

  // Provider
  getIt.registerFactory<AuthProvider>(() => AuthProvider(signIn: getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authFirebase: getIt()));

  // Usecase
  getIt.registerLazySingleton<SignIn>(() => SignIn(getIt()));

  // External
  final auth = FirebaseAuth.instance;
  getIt.registerLazySingleton(() => auth);

  // Http Service
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerLazySingleton<AuthFirebase>(
      () => AuthFirebaseImpl(auth: getIt()));
}
