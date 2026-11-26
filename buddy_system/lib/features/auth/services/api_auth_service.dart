import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth_result.dart';
import '../../models/user_model.dart';
import 'auth_service.dart';

class ApiAuthService implements AuthService {
  static const String _baseUrl =
      'https://n2ifyru5ti.execute-api.ap-southeast-2.amazonaws.com/dev';
  static const String _rememberedUsernameKey =
      'buddysystem_remembered_username';

  UserModel? _currentUser;

  @override
  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final now = DateTime.now();
      final createdDate =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      final response = await http.post(
        Uri.parse('$_baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username.trim(),
          'email': email.trim().toLowerCase(),
          'password': password,
          'createdDate': createdDate,
          'firstName': firstName.trim(),
          'lastName': lastName.trim(),
        }),
      );

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && decoded['data'] != null) {
        final user = UserModel.fromJson(
          decoded['data'] as Map<String, dynamic>,
        );
        _currentUser = user;
        return AuthResult.success(
          user: user,
          message: decoded['message']?.toString() ?? 'Account created!',
        );
      }

      return AuthResult.failure(
        decoded['message']?.toString() ?? 'Registration failed.',
      );
    } catch (e) {
      return AuthResult.failure('Network error: unable to reach server.');
    }
  }

  @override
  Future<AuthResult> login({
    required String username,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/auth/login').replace(
        queryParameters: {'username': username.trim(), 'password': password},
      );

      final response = await http.get(uri);
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && decoded['data'] != null) {
        final user = UserModel.fromJson(
          decoded['data'] as Map<String, dynamic>,
        );
        _currentUser = user;

        final prefs = await SharedPreferences.getInstance();
        if (rememberMe) {
          await prefs.setString(_rememberedUsernameKey, user.username);
        } else {
          await prefs.remove(_rememberedUsernameKey);
        }

        return AuthResult.success(
          user: user,
          message: 'Welcome back, ${user.firstName}!',
        );
      }

      return AuthResult.failure(
        decoded['message']?.toString() ?? 'Invalid username or password.',
      );
    } catch (e) {
      return AuthResult.failure('Network error: unable to reach server.');
    }
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }

  @override
  Future<bool> isLoggedIn() async => _currentUser != null;

  @override
  Future<UserModel?> getCurrentUser() async => _currentUser;

  @override
  Future<String?> getRememberUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_rememberedUsernameKey);
  }
}
