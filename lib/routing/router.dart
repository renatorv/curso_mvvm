import 'package:curso_mvvm/config/dependecies.dart';
import 'package:curso_mvvm/data/repositories/auth/auth_repository.dart';
import 'package:curso_mvvm/routing/routes.dart';
import 'package:curso_mvvm/ui/auth/login/widgets/login_screen.dart';
import 'package:curso_mvvm/ui/home/widgets/home_screen.dart';
import 'package:curso_mvvm/ui/splash/widgets/splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../ui/auth/login/view_models/login_viewmodel.dart';

GoRouter get router {
  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: getIt<AuthRepository>(),
    redirect: _redirect,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => LoginScreen(
          loginViewmodel: LoginViewmodel(authRepository: getIt()),
        ),
      ),
      GoRoute(path: Routes.home, builder: (context, state) => HomeScreen()),
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => SplashScreen(authRepository: getIt()),
      ),
    ],
  );
}

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final loggedIn = await getIt<AuthRepository>().isAuthenticated;

  print('IsLoggedIn $loggedIn');

  if (!loggedIn) return Routes.login;

  print('state: ${state.matchedLocation}');

  final isLogginIn =
      state.matchedLocation == Routes.splash ||
      state.matchedLocation == Routes.login;

  if (isLogginIn) return Routes.home;

  return null;
}
