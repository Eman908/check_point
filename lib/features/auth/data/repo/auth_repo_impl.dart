import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/firebase/users_service.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:check_point/features/auth/data/data_source/contract/firebase_auth_data_source.dart';
import 'package:check_point/features/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final UsersService _usersService = getIt();
  final FirebaseAuthDataSource _firebaseAuthDataSource = getIt();
  final SharedPreferences _preferences = getIt();
  @override
  Future<Results<String>> userChangePassword(
    String currentPassword,
    String newPassword,
  ) async {
    var response = await _firebaseAuthDataSource.userChangePassword(
      currentPassword,
      newPassword,
    );
    switch (response) {
      case Success<String>():
        return Success();
      case Failure<String>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<User>> userLogin(String email, String password) async {
    var response = await _firebaseAuthDataSource.userLogin(email, password);
    switch (response) {
      case Success<User>():
        var role =
            (response.data?.email == 'emantharwat102@gmail.com')
                ? 'manager'
                : 'staff';

        UserModel user = UserModel(
          userName: response.data?.displayName ?? 'Name',
          userId: response.data?.uid ?? '',
          email: response.data?.email ?? '',
          role: role,
        );
        var token = await response.data?.getIdToken();
        _preferences.setString(Constants.userToken, token ?? '');
        _preferences.setString(Constants.userRole, role);
        _preferences.setString(Constants.userName, user.userName);
        _preferences.setString(Constants.userEmail, user.email);
        await _usersService.setUser(user);
        return Success(data: response.data);
      case Failure<User>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<void>> userResetPassword(String email) async {
    var response = await _firebaseAuthDataSource.userResetPassword(email);
    switch (response) {
      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure();
    }
  }

  @override
  Future<Results<void>> userSignOut() async {
    var response = await _firebaseAuthDataSource.userSignOut();
    switch (response) {
      case Success<void>():
        return Success();
      case Failure<void>():
        return Failure();
    }
  }

  @override
  Future<Results<String>> userChangeUserName(String name) async {
    var response = await _firebaseAuthDataSource.updateUserName(name);
    switch (response) {
      case Success<String>():
        _preferences.setString(Constants.userName, name);
        return Success();
      case Failure<String>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<UserModel>> getUserData() async {
    var response = await _firebaseAuthDataSource.getUserData();
    switch (response) {
      case Success<UserModel>():
        return Success(data: response.data);
      case Failure<UserModel>():
        return Failure(message: response.message);
    }
  }
}
