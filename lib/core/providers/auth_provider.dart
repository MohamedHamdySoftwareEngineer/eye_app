import 'package:flutter/material.dart';
import '../services/api_service.dart';

enum AuthStatus { idle, loading, success, error }

class AuthProvider extends ChangeNotifier {
  final ApiService apiService;
  AuthProvider({required this.apiService});

  AuthStatus _status = AuthStatus.idle;
  String errorMessage = '';

  AuthStatus get status => _status;
  String get error => errorMessage;

  Future<void> login({required String username,required String password}) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      await apiService.login(username: username, password: password);
      _status = AuthStatus.success;
    } catch (e) {
      errorMessage = e.toString();
      _status = AuthStatus.error;
    }

    notifyListeners();
  }

  void reset() {
    _status = AuthStatus.idle;
    errorMessage = '';
    notifyListeners();
  }
}
