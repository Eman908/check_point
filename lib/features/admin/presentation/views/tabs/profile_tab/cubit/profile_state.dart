import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/models/user_model.dart';

class ProfileState {
  BaseStatus logoutState;
  BaseStatus deleteAccountState;
  BaseStatus changePasswordState;
  BaseStatus updateUserNameState;
  BaseStatus<UserModel> getUserDataState;
  bool isPassword;
  ProfileState({
    this.logoutState = const BaseStatus.initial(),
    this.deleteAccountState = const BaseStatus.initial(),
    this.changePasswordState = const BaseStatus.initial(),
    this.updateUserNameState = const BaseStatus.initial(),
    this.getUserDataState = const BaseStatus.initial(),
    this.isPassword = true,
  });

  ProfileState copyWith({
    BaseStatus? logoutState,
    BaseStatus? deleteAccountState,
    BaseStatus? changePasswordState,
    BaseStatus? updateUserNameState,
    BaseStatus<UserModel>? getUserDataState,
    bool? isPassword,
  }) {
    return ProfileState(
      logoutState: logoutState ?? this.logoutState,
      deleteAccountState: deleteAccountState ?? this.deleteAccountState,
      changePasswordState: changePasswordState ?? this.changePasswordState,
      updateUserNameState: updateUserNameState ?? this.updateUserNameState,
      getUserDataState: getUserDataState ?? this.getUserDataState,
      isPassword: isPassword ?? this.isPassword,
    );
  }
}

sealed class ProfileActions {}

final class DeleteAccount extends ProfileActions {}

final class Logout extends ProfileActions {}

final class UpdateUserNameAction extends ProfileActions {
  final String name;
  UpdateUserNameAction(this.name);
}

final class ChangePasswordAction extends ProfileActions {
  final String oldPassword;
  final String newPassword;
  ChangePasswordAction(this.oldPassword, this.newPassword);
}

final class ChangePasswordVisibility extends ProfileActions {}

final class GetUserData extends ProfileActions {}
