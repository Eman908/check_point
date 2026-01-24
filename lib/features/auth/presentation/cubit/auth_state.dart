import 'package:check_point/core/base/base_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  BaseStatus<User> loginState;
  BaseStatus resetPasswordState;
  bool isPassword;
  AuthState({
    this.loginState = const BaseStatus<User>.initial(),
    this.resetPasswordState = const BaseStatus.initial(),
    this.isPassword = true,
  });
  AuthState copyWith({
    BaseStatus<User>? loginState,
    BaseStatus? resetPasswordState,
    bool? isPassword,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      isPassword: isPassword ?? this.isPassword,
    );
  }
}

sealed class AuthActions {}

final class AuthLogin extends AuthActions {
  final String email;
  final String password;
  AuthLogin(this.email, this.password);
}

final class AuthForgetPassword extends AuthActions {
  final String email;
  AuthForgetPassword(this.email);
}

final class PasswordVisibility extends AuthActions {}
