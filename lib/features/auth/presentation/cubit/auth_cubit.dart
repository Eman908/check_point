import 'package:check_point/core/base/base_cubit.dart';
import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/features/auth/domain/repo/auth_repo.dart';
import 'package:check_point/features/auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends BaseCubit<AuthState, AuthActions> {
  AuthCubit() : super(AuthState());
  final AuthRepo _authRepo = getIt();

  @override
  Future<void> doAction(AuthActions action) async {
    switch (action) {
      case AuthLogin():
        _loginUser(action.email, action.password);
      case AuthForgetPassword():
        _forgetPassword(action.email);
      case PasswordVisibility():
        _changePasswordVisibility();
    }
  }

  void _changePasswordVisibility() {
    safeEmit(state.copyWith(isPassword: !state.isPassword));
  }

  Future<void> _forgetPassword(String email) async {
    safeEmit(state.copyWith(resetPasswordState: const BaseStatus.loading()));
    var response = await _authRepo.userResetPassword(email);
    switch (response) {
      case Success<void>():
        safeEmit(
          state.copyWith(resetPasswordState: const BaseStatus.success()),
        );
      case Failure<void>():
        safeEmit(
          state.copyWith(
            resetPasswordState: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }

  Future<void> _loginUser(String email, String password) async {
    safeEmit(state.copyWith(loginState: const BaseStatus.loading()));
    var response = await _authRepo.userLogin(email, password);
    switch (response) {
      case Success<User>():
        safeEmit(
          state.copyWith(loginState: BaseStatus.success(data: response.data)),
        );
      case Failure<User>():
        safeEmit(
          state.copyWith(
            loginState: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }
}
