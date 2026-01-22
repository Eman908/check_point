import 'package:check_point/features/admin/presentation/views/admin_navigation.dart';
import 'package:check_point/features/auth/presentation/views/forget_password_view.dart';
import 'package:check_point/features/auth/presentation/views/login_view.dart';
import 'package:check_point/features/splash/presentation/view/splash_view.dart';
import 'package:check_point/features/stuff/presentation/views/stuff_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static const kLoginView = '/loginView';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kAdminView = '/adminView';
  static const kEmployeeView = '/employeeView';
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
        path: kAdminView,
        builder:
            (BuildContext context, GoRouterState state) =>
                const AdminNavigation(),
      ),
      GoRoute(
        path: kStuffHomeView,
        builder:
            (BuildContext context, GoRouterState state) =>
                const StuffNavigation(),
      ),
    ],
  );
}
