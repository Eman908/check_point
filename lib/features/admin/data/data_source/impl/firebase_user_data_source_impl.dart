import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/error/safe_call.dart';
import 'package:check_point/core/firebase/auth_service.dart';
import 'package:check_point/core/firebase/users_service.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/features/admin/data/data_source/contract/firebase_user_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FirebaseUserDataSource)
class FirebaseUserDataSourceImpl implements FirebaseUserDataSource {
  final UsersService _userService = getIt();
  final AuthService _authService = getIt();

  @override
  Future<Results<String>> updateUserName(String name) async {
    return safeCall(() async {
      await _authService.updateUserName(name);
      return Success(data: name);
    });
  }

  @override
  Future<Results<UserModel>> getUserData() async {
    return safeCall(() async {
      var response = await _userService.getUserData();
      return Success(data: response);
    });
  }

  @override
  Future<Results<String>> userChangePassword(
    String currentPassword,
    String newPassword,
  ) async {
    return safeCall(() async {
      await _authService.changePassword(currentPassword, newPassword);
      if (currentPassword == newPassword) {
        return Failure(
          exception: Exception('Same password'),
          message: 'New password must be different from current password',
        );
      }
      return Success();
    });
  }

  @override
  Future<Results<String>> addStaff({
    required String email,
    required String managerId,
  }) async {
    return safeCall(() async {
      await _userService.addStaff(email: email, managerId: managerId);
      if (email == 'emantharwat102@gmail.com') {
        return Failure(message: 'You cannot add a manager');
      }
      return Success(data: 'Success');
    });
  }
}
