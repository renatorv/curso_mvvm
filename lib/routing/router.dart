import 'package:curso_mvvm/config/dependecies.dart';
import 'package:curso_mvvm/routing/routes.dart';
import 'package:curso_mvvm/ui/auth/login/widgets/login_screen.dart';
import 'package:curso_mvvm/ui/home/widgets/home_screen.dart';
import 'package:curso_mvvm/ui/splash/widgets/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../ui/auth/login/view_models/login_viewmodel.dart';

GoRouter get router {
  return GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => LoginScreen(
          loginViewmodel: LoginViewmodel(authRepository: getIt()),
        ),
      ),
      GoRoute(path: Routes.home, builder: (context, state) => HomeScreen()),
      GoRoute(path: Routes.splash, builder: (context, state) => SplashScreen()),
    ],
  );
}
