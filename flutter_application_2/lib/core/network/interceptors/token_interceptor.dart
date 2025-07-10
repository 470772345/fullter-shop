import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 示例：从本地/Provider获取token
    final token = await _getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  Future<String?> _getToken() async {
    // TODO: 替换为实际token获取逻辑
    return '';
  }
}
