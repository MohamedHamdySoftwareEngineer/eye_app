// this file contains the ApiService class which is responsible for making API calls
// and handling responses.
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  ApiService() : _dio = Dio(BaseOptions(baseUrl: 'https://10.0.2.2:7053/api/',
  responseType: ResponseType.plain,));

  Future<String> login(
      {required String username, required String password}) async {
    try {
      final response = await _dio.post('users/login', data: {
        'username': username,
        'password': password,
      });
      // Since responseType is plain, data is already a String:
      final token = response.data as String;
      if (token.isNotEmpty) return token.trim();
      throw Exception('Empty token received');
    } on DioException catch (e) {
      throw Exception('Error during login (Dio): ${e.message}');
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }
}
