import 'package:dio/dio.dart';
import 'dio_client.dart';

class ApiService {
  final Dio _dio = DioClient().dio;

  Future<Response> getExampleData() async {
    return await _dio.get('/example');
  }

  Future<Response> postExampleData(Map<String, dynamic> data) async {
    return await _dio.post('/example', data: data);
  }

  // 可继续添加更多接口方法
}
