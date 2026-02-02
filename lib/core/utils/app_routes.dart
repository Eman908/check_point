import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:check_point/features/admin/presentation/views/admin_navigation.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/change_password.dart';
import 'package:check_point/features/auth/presentation/views/forget_password_view.dart';
import 'package:check_point/features/auth/presentation/views/login_view.dart';
import 'package:check_point/features/splash/presentation/view/splash_view.dart';
import 'package:check_point/features/staff/presentation/views/staff_navigation.dart';
import 'package:check_point/features/staff/presentation/views/tabs/staff_home_tab/qr_scanner_view.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppRoutes {
  static const kLoginView = '/loginView';
  static const kSplashView = '/';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kAdminView = '/adminView';
  static const kStaffHomeView = '/staffHomeView';
  static const kChangePasswordView = '/changePasswordView';
  static const kQrScannerView = '/qrScannerView';

  static final router = GoRouter(
    initialLocation: kSplashView,

    redirect: (context, state) {
      final prefs = getIt<SharedPreferences>();
      final token = prefs.getString(Constants.userToken);
      final role = prefs.getString(Constants.userRole);

      final isLoggingIn = state.uri.toString() == kLoginView;

      if (token == null || token.isEmpty) {
        return isLoggingIn ? null : kLoginView;
      }

      if (role == 'manager') {
        return state.uri.toString() == kAdminView ? null : kAdminView;
      }

      if (role == 'staff') {
        return state.uri.toString() == kStaffHomeView ? null : kStaffHomeView;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
      GoRoute(
        path: kChangePasswordView,
        builder: (context, state) => const ChangePassword(),
      ),
      GoRoute(
        path: kForgetPasswordView,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: kAdminView,
        builder: (context, state) => const AdminNavigation(),
      ),
      GoRoute(
        path: kQrScannerView,
        builder: (context, state) => const QRScannerView(),
      ),
      GoRoute(
        path: kStaffHomeView,
        builder: (context, state) => const StaffNavigation(),
      ),
    ],
  );
}
