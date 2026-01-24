import 'package:check_point/core/base/base_cubit.dart';
import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/cubit/profile_state.dart';
import 'package:check_point/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends BaseCubit<ProfileState, ProfileActions> {
  ProfileCubit() : super(ProfileState());
  final AuthRepo _authRepo = getIt<AuthRepo>();
  @override
  Future<void> doAction(ProfileActions action) async {
    switch (action) {
      case DeleteAccount():
        // TODO: Handle this case.
        throw UnimplementedError();
      case Logout():
        _logoutUser();
      case ChangePasswordAction():
        _changePassword(action.oldPassword, action.newPassword);
      case ChangePasswordVisibility():
        _changePasswordVisibility();
      case UpdateUserNameAction():
        _updateUserName(action.name);
      case GetUserData():
        _getUserData();
    }
  }

  Future<void> _getUserData() async {
    safeEmit(state.copyWith(getUserDataState: const BaseStatus.loading()));
    var response = await _authRepo.getUserData();
    switch (response) {
      case Success<UserModel>():
        safeEmit(
          state.copyWith(
            getUserDataState: BaseStatus.success(data: response.data),
          ),
        );
      case Failure<UserModel>():
        safeEmit(state.copyWith(getUserDataState: const BaseStatus.failure()));
    }
  }

  Future<void> _updateUserName(String name) async {
    safeEmit(state.copyWith(updateUserNameState: const BaseStatus.loading()));
    var response = await _authRepo.userChangeUserName(name);
    switch (response) {
      case Success<void>():
        safeEmit(
          state.copyWith(updateUserNameState: const BaseStatus.success()),
        );
        await _getUserData();

      case Failure<void>():
        safeEmit(
          state.copyWith(updateUserNameState: const BaseStatus.failure()),
        );
    }
  }

  Future<void> _changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    safeEmit(state.copyWith(changePasswordState: const BaseStatus.loading()));
    var response = await _authRepo.userChangePassword(
      currentPassword,
      newPassword,
    );
    switch (response) {
      case Success<String>():
        safeEmit(
          state.copyWith(changePasswordState: const BaseStatus.success()),
        );
      case Failure<String>():
        safeEmit(
          state.copyWith(changePasswordState: const BaseStatus.failure()),
        );
    }
  }

  void _changePasswordVisibility() {
    safeEmit(state.copyWith(isPassword: !state.isPassword));
  }

  Future<void> _logoutUser() async {
    safeEmit(state.copyWith(logoutState: const BaseStatus.loading()));
    var response = await _authRepo.userSignOut();
    switch (response) {
      case Success<void>():
        safeEmit(state.copyWith(logoutState: const BaseStatus.success()));
      case Failure<void>():
        safeEmit(state.copyWith(logoutState: const BaseStatus.failure()));
    }
  }
}
