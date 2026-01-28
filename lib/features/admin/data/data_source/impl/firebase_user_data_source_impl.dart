import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/error/safe_call.dart';
import 'package:check_point/core/firebase/auth_service.dart';
import 'package:check_point/core/firebase/shifts_service.dart';
import 'package:check_point/core/firebase/users_service.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/features/admin/data/data_source/contract/firebase_user_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FirebaseUserDataSource)
class FirebaseUserDataSourceImpl implements FirebaseUserDataSource {
  final UsersService _userService = getIt();
  final AuthService _authService = getIt();
  final ShiftsService _shiftsService = getIt();

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

  @override
  Future<Results<Stream<QuerySnapshot<UserModel>>>> getStaffList(
    String managerId,
  ) {
    return safeCall(() async {
      var response = _userService.getStaffList(managerId);
      return Success(data: response);
    });
  }

  @override
  Future<Results<Stream<QuerySnapshot<ShiftModel>>>> getShift() async {
    return safeCall(() async {
      var response = _shiftsService.getShift();
      return Success(data: response);
    });
  }

  @override
  Future<Results<String>> startShift(ShiftModel shift) async {
    return safeCall(() async {
      await _shiftsService.setShift(shift);
      return Success(data: 'Success');
    });
  }
}
