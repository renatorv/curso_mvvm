import 'package:dio/dio.dart';

import '../../../utils/result.dart';
import 'models/login_request.dart';
import 'models/login_response.dart';

class ApiClient {
  final String _apiUrl;
  final Dio _dio;

  const ApiClient({required this._apiUrl, required this._dio});

  // const ApiClient({required String apiUrl, required Dio dio})
  //   : _dio = dio,
  //     _apiUrl = apiUrl;

  Future<Result<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final endpoint = '$_apiUrl/auth/login';

      final response = await _dio.post(endpoint, data: loginRequest.toJson());

      if (response.statusCode == 200) {
        final result = LoginResponse.fromJson(response.data);
        return Result.ok(result);
      }
      return Result.error(
        Exception(
          'Ocorreu um erro ao realizar o login: ${response.statusCode}',
        ),
      );
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
