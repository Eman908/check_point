import 'package:check_point/features/admin_home/presentation/views/admin_home_view.dart';
import 'package:check_point/features/auth/presentation/views/forget_password_view.dart';
import 'package:check_point/features/auth/presentation/views/login_view.dart';
import 'package:check_point/features/splash/presentation/view/splash_view.dart';
import 'package:check_point/features/stuff_home/presentation/views/stuff_home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static const kLoginView = '/loginView';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kAdminHomeView = '/adminHomeView';
  static const kStuffHomeView = '/stuffHomeView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder:
            (BuildContext context, GoRouterState state) => const SplashView(),
      ),
      GoRoute(
        path: kLoginView,
        builder:
            (BuildContext context, GoRouterState state) => const LoginView(),
      ),
      GoRoute(
        path: kForgetPasswordView,
        builder:
            (BuildContext context, GoRouterState state) =>
                const ForgetPasswordView(),
      ),
      GoRoute(
        path: kAdminHomeView,
        builder:
            (BuildContext context, GoRouterState state) =>
                const AdminHomeView(),
      ),
      GoRoute(
        path: kStuffHomeView,
        builder:
            (BuildContext context, GoRouterState state) =>
                const StuffHomeView(),
      ),
    ],
  );
}
