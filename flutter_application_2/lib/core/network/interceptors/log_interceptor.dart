import 'package:dio/dio.dart';

class AppLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('--> \\${options.method} \\${options.uri}');
    print('Headers: \\${options.headers}');
    print('Data: \\${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('<-- \\${response.statusCode} \\${response.requestOptions.uri}');
    print('Response: \\${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('Error: \\${err.message}');
    super.onError(err, handler);
  }
}
