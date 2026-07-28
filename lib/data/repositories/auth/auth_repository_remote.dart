import 'package:curso_mvvm/data/repositories/auth/auth_repository.dart';
import 'package:curso_mvvm/data/services/api/api_client.dart';
import 'package:curso_mvvm/data/services/api/models/login_request.dart';
import 'package:curso_mvvm/data/services/shared_preferences_services.dart';
import 'package:curso_mvvm/utils/result.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/models/user.dart';

class AuthRepositoryRemote extends ChangeNotifier implements AuthRepository {
  final ApiClient _apiClient;
  final SharedPreferencesServices _sharedPreferencesServices;

  AuthRepositoryRemote({
    required this._apiClient,
    required this._sharedPreferencesServices,
  });

  @override
  Future<Result<void>> login({
    required String username,
    required String password,
  }) async {
    try {
      final LoginRequest loginRequest = LoginRequest(
        username: username,
        password: password,
        expiresInMins: 30,
      );

      final result = await _apiClient.login(loginRequest);

      switch (result) {
        case Ok():
          final user = User(
            accessToken: result.value.accessToken,
            refreshToken: result.value.refreshToken,
            id: result.value.id,
            username: result.value.username,
            email: result.value.email,
            firstName: result.value.firstName,
            lastName: result.value.lastName,
            gender: result.value.gender,
            image: result.value.image,
          );

          await _sharedPreferencesServices.saveUser(user);
          break;
        default:
      }

      return result;
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<bool> get isAuthenticated async {
    final result = await _sharedPreferencesServices.fetchUser();

    switch (result) {
      case Ok<User?>():
        return result.value != null;
      default:
        return false;
    }
  }

  @override
  Future<void> verifyLogin() async {
    await _sharedPreferencesServices.fetchUser();
    notifyListeners();
  }
}
