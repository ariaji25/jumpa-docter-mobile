import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:jd_mobile/data/datasources/firebase/auth/auth_firebase.dart';
import 'package:jd_mobile/data/datasources/firebase/auth/auth_firebase_impl.dart';
import 'package:jd_mobile/data/datasources/http_services.dart';
import 'package:jd_mobile/data/repositories/auth/auth_repository_impl.dart';
import 'package:jd_mobile/domain/repositories/auth/auth_repository.dart';
import 'package:jd_mobile/domain/usecases/auth/sign_in.dart';
import 'package:jd_mobile/persentation/provider/auth/auth_provider.dart';

final GetIt getIt = GetIt.instance;

Future setup() async {
  // Provider
  getIt.registerFactory<AuthProvider>(() => AuthProvider(signIn: getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authFirebase: getIt()));

  // Usecase
  getIt.registerLazySingleton<SignIn>(() => SignIn(getIt()));

  // External
  final auth = FirebaseAuth.instance;
  getIt.registerLazySingleton(() => auth);

  // Http Service
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerLazySingleton<AuthFirebase>(() => AuthFirebaseImpl(auth: getIt()));
}
