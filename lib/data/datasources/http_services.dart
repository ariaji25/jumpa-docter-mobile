import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:jd_mobile/common/env/env.dart';
import 'package:jd_mobile/injection.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpService {
  final Env _env = getIt<Env>();
  late Dio _dio;
  static HttpService? _instance;

  Dio get dio => _dio;

  factory HttpService() => _instance ??= HttpService._internal();

  HttpService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _env.baseUrl ?? '',
        receiveTimeout: 30000,
        headers: {
          'Accept': 'application/json',
          'authorizationType': 'token',
        },
      ),
    );

    if (!kReleaseMode) {
      _dio.interceptors.add(DioLogInterceptor());
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 150,
        ),
      );
    }
  }

  void setToken({required String token}) {
    _dio.options.headers['Authorization'] = "Bearer $token";
  }

  void removeToken() {
    _dio.options.headers['Authorization'] = null;
  }

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}
