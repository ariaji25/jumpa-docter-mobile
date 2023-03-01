import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:jd_mobile/data/datasources/articles/article_api.dart';
import 'package:jd_mobile/data/datasources/chat/chat_api.dart';
import 'package:jd_mobile/data/datasources/http_services.dart';
import 'package:jd_mobile/data/datasources/schedule/schedule_api.dart';
import 'package:jd_mobile/data/repositories/articles/articles_repositpry_impl.dart';
import 'package:jd_mobile/data/repositories/auth/auth_repository_impl.dart';
import 'package:jd_mobile/data/repositories/schedule/schedule_repositpry_impl.dart';
import 'package:jd_mobile/domain/repositories/articles/articles_repository.dart';
import 'package:jd_mobile/domain/repositories/auth/auth_repository.dart';
import 'package:jd_mobile/domain/repositories/chat/chat_repository.dart';
import 'package:jd_mobile/domain/usecases/articles/get_articles.dart';
import 'package:jd_mobile/domain/usecases/articles/get_tags.dart';
import 'package:jd_mobile/domain/usecases/auth/sign_in.dart';
import 'package:jd_mobile/domain/usecases/chat/get_rooms.dart';
import 'package:jd_mobile/domain/usecases/patient/create_patient_nrm.dart';
import 'package:jd_mobile/domain/usecases/patient/detail_patient_by_nrm.dart';
import 'package:jd_mobile/domain/usecases/patient/update_patient.dart';
import 'package:jd_mobile/domain/usecases/schedule/get_enrollments.dart';
import 'package:jd_mobile/domain/usecases/schedule/get_history_enrollments.dart';
import 'package:jd_mobile/persentation/provider/article/article_provider.dart';
import 'package:jd_mobile/persentation/provider/auth/auth_provider.dart';
import 'package:jd_mobile/persentation/provider/chat/chat_room_provider.dart';
import 'package:jd_mobile/persentation/provider/chat/room_chat_provider.dart';
import 'package:jd_mobile/persentation/provider/home/home_provider.dart';
import 'package:jd_mobile/persentation/provider/map/map_provider.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
import 'package:jd_mobile/persentation/provider/schedule/schedule_provider.dart';

import 'data/datasources/firebase/auth/auth_firebase.dart';
import 'data/datasources/firebase/auth/auth_firebase_impl.dart';
import 'data/datasources/patient/patient_api.dart';
import 'data/repositories/chat/chat_repository_impl.dart';
import 'data/repositories/patient/patient_repository_impl.dart';
import 'domain/repositories/patient/patient_repositorty.dart';
import 'domain/repositories/schedule/schedule_repository.dart';
import 'domain/usecases/patient/create_patient.dart';
import 'persentation/provider/patient/patient_provider.dart';

final GetIt getIt = GetIt.instance;

Future setup() async {
  // Provider
  getIt.registerFactory<AuthProvider>(() => AuthProvider(signIn: getIt()));
  getIt.registerFactory<PatientProvider>(
    () => PatientProvider(
      createPatient: getIt(),
      createPatientNrm: getIt(),
      updatePatient: getIt(),
      detailPatientByNrm: getIt(),
    ),
  );
  getIt.registerFactory<MapProvider>(() => MapProvider());
  getIt.registerFactory<ChatRoomProvider>(() => ChatRoomProvider());
  getIt.registerFactory<RoomChatProvider>(
    () => RoomChatProvider(
      getRooms: getIt(),
    ),
  );
  getIt.registerFactory<HomeProvider>(() => HomeProvider());
  getIt.registerFactory<ArticleProvider>(
    () => ArticleProvider(
      getArticles: getIt(),
      getTags: getIt(),
    ),
  );
  getIt.registerFactory<ScheduleProvider>(
    () => ScheduleProvider(
      getEnrollments: getIt(),
      getHistoryEnrollments: getIt(),
    ),
  );
  getIt.registerFactory<OrderProvider>(
    () => OrderProvider(detailPatientByNrm: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authFirebase: getIt(),
    ),
  );
  getIt.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(
      api: getIt(),
    ),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      api: getIt(),
    ),
  );
  getIt.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(
      api: getIt(),
    ),
  );
  getIt.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(
      api: getIt(),
    ),
  );

  // Usecase
  getIt.registerLazySingleton<SignIn>(() => SignIn(getIt()));
  getIt.registerLazySingleton<CreatePatient>(
    () => CreatePatient(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<CreatePatientNrm>(
    () => CreatePatientNrm(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<UpdatePatient>(() => UpdatePatient(getIt()));
  getIt.registerLazySingleton<DetailPatientByNrm>(
    () => DetailPatientByNrm(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<GetRooms>(() => GetRooms(getIt()));
  getIt.registerLazySingleton<GetArticles>(() => GetArticles(getIt()));
  getIt.registerLazySingleton<GetTags>(() => GetTags(getIt()));
  getIt.registerLazySingleton<GetEnrollments>(() => GetEnrollments(getIt()));
  getIt.registerLazySingleton<GetHistoryEnrollments>(
    () => GetHistoryEnrollments(
      getIt(),
    ),
  );

  // External
  final auth = FirebaseAuth.instance;
  getIt.registerLazySingleton(() => auth);

  // Http Service
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerLazySingleton<AuthFirebase>(
    () => AuthFirebaseImpl(
      auth: getIt(),
    ),
  );
  getIt.registerLazySingleton<PatientApi>(
      () => PatientApi(getIt<HttpService>().dio));
  getIt.registerLazySingleton<ChatApi>(
    () => ChatApi(
      getIt<HttpService>().dio,
    ),
  );
  getIt.registerLazySingleton<ArticleApi>(
    () => ArticleApi(
      getIt<HttpService>().dio,
    ),
  );
  getIt.registerLazySingleton<ScheduleApi>(
    () => ScheduleApi(
      getIt<HttpService>().dio,
    ),
  );
}
