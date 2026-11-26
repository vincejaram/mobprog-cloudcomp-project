import 'package:flutter/foundation.dart';

import '../../models/auth_result.dart';
import '../../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider({required AuthService authService}) : _authService = authService;

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  String? get errorMessage => _errorMessage;

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  Future<String?> loadRememberedUsername() {
    return _authService.getRememberUsername();
  }

  Future<AuthResult> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    if (_isLoading) {
      return AuthResult.failure('Request already in progress.');
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authService.login(
      username: username,
      password: password,
      rememberMe: rememberMe,
    );

    _isLoading = false;
    if (result.success) {
      _currentUser = result.user;
    } else {
      _errorMessage = result.message;
    }
    notifyListeners();
    return result;
  }

  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    if (_isLoading) {
      return AuthResult.failure('Request already in progress.');
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authService.register(
      username: username,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );

    _isLoading = false;
    if (result.success) {
      _currentUser = result.user;
    } else {
      _errorMessage = result.message;
    }
    notifyListeners();
    return result;
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _authService.logout();
    _currentUser = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
