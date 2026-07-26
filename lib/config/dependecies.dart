import 'package:curso_mvvm/data/repositories/auth/auth_repository.dart';
import 'package:curso_mvvm/data/repositories/auth/auth_repository_remote.dart';
import 'package:curso_mvvm/data/services/api/api_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Criando uma insância
  getIt.registerSingleton<ApiClient>(
    ApiClient(apiUrl: 'https://dummyjson.com', dio: Dio()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryRemote(apiClient: getIt()),
  );
}
