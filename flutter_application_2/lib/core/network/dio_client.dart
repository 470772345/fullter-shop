import 'package:dio/dio.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/token_interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));
    dio.interceptors.add(AppLogInterceptor());
    dio.interceptors.add(TokenInterceptor());
    // 可添加更多拦截器
  }
}