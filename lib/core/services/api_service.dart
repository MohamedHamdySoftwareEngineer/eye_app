import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final _baseUrl = 'http://192.168.1.8:5236/api';

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final uri = Uri.parse('$_baseUrl/users/login');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (resp.statusCode != 200) {
      throw Exception('Login failed: ${resp.statusCode}');
    }
    // optionally parse resp.body if you need a token/model
  }
}
