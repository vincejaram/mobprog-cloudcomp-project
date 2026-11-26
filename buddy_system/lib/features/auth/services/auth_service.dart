import '../../models/auth_result.dart';
import '../../models/user_model.dart';

abstract class AuthService {
  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<AuthResult> login({
    required String username,
    required String password,
    bool rememberMe = false,
  });

  Future<bool> isLoggedIn();
  Future<UserModel?> getCurrentUser();
  Future<String?> getRememberUsername();
  Future<void> logout();
}
