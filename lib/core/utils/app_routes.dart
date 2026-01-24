import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:check_point/features/admin/presentation/views/admin_navigation.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/change_password.dart';
import 'package:check_point/features/auth/presentation/views/forget_password_view.dart';
import 'package:check_point/features/auth/presentation/views/login_view.dart';
import 'package:check_point/features/splash/presentation/view/splash_view.dart';
import 'package:check_point/features/staff/presentation/views/staff_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppRoutes {
  static const kLoginView = '/loginView';
  static const kSplashView = '/';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kAdminView = '/adminView';
  static const kStaffHomeView = '/staffHomeView';
  static const kChangePasswordView = '/changePasswordView';

  static String _getInitialLocation() {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    final token = prefs.getString(Constants.userToken);
    final userRole = prefs.getString(Constants.userRole);

    if (token == null || token.isEmpty) {
      return kSplashView;
    }

    if (userRole == 'manager') {
      return kAdminView;
    } else if (userRole == 'staff') {
      return kStaffHomeView;
    }

    return kSplashView;
  }

  static final router = GoRouter(
    initialLocation: _getInitialLocation(),
    routes: [
      GoRoute(
        path: kSplashView,
        builder:
            (BuildContext context, GoRouterState state) => const SplashView(),
      ),
      GoRoute(
        path: kLoginView,
        builder:
            (BuildContext context, GoRouterState state) => const LoginView(),
      ),
      GoRoute(
        path: kChangePasswordView,
        builder:
            (BuildContext context, GoRouterState state) =>
                const ChangePassword(),
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
        path: kStaffHomeView,
        builder:
            (BuildContext context, GoRouterState state) =>
                const StaffNavigation(),
      ),
    ],
  );
}
