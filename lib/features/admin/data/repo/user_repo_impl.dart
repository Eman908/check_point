import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:check_point/features/admin/data/data_source/contract/firebase_user_data_source.dart';
import 'package:check_point/features/admin/domain/repo/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: UserRepo)
class UserRepoImpl implements UserRepo {
  final FirebaseUserDataSource _firebaseAuthDataSource = getIt();
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
  Future<Results<String>> userChangeUserName(String name) async {
    var response = await _firebaseAuthDataSource.updateUserName(name);
    switch (response) {
      case Success<String>():
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

  @override
  Future<Results<String>> addStaff({required String email}) async {
    final String managerIdSaved =
        _preferences.getString(Constants.userId) ?? '';
    var response = await _firebaseAuthDataSource.addStaff(
      email: email,
      managerId: managerIdSaved,
    );
    switch (response) {
      case Success<String>():
        return Success();
      case Failure<String>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<Stream<QuerySnapshot<UserModel>>>> getStaffList() async {
    final String managerIdSaved =
        _preferences.getString(Constants.userId) ?? '';
    var response = await _firebaseAuthDataSource.getStaffList(managerIdSaved);
    switch (response) {
      case Success<Stream<QuerySnapshot<UserModel>>>():
        return Success(data: response.data);
      case Failure<Stream<QuerySnapshot<UserModel>>>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<Stream<QuerySnapshot<ShiftModel>>>> getShift() async {
    var response = await _firebaseAuthDataSource.getShift();
    switch (response) {
      case Success<Stream<QuerySnapshot<ShiftModel>>>():
        return Success(data: response.data);
      case Failure<Stream<QuerySnapshot<ShiftModel>>>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<String>> startShift(ShiftModel shift) async {
    var response = await _firebaseAuthDataSource.startShift(shift);
    switch (response) {
      case Success<String>():
        return Success(data: response.data);
      case Failure<String>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<String>> updateShiftQrCode(
    String qrCode,
    String shiftId,
  ) async {
    var response = await _firebaseAuthDataSource.updateShiftQrCode(
      qrCode,
      shiftId,
    );
    switch (response) {
      case Success<String>():
        return Success();
      case Failure<String>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<String>> endShift(String shiftId) async {
    var response = await _firebaseAuthDataSource.endShiftNow(shiftId);
    switch (response) {
      case Success<String>():
        return Success();
      case Failure<String>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<List<UserModel>>> getAttendance() async {
    var response = await _firebaseAuthDataSource.getAttendance();
    switch (response) {
      case Success<List<UserModel>>():
        return Success(data: response.data);
      case Failure<List<UserModel>>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<String>> deleteAttendance() async {
    var response = await _firebaseAuthDataSource.deleteAttendance();
    switch (response) {
      case Success<String>():
        return Success(data: response.data);
      case Failure<String>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<String>> getShiftId() async {
    var response = await _firebaseAuthDataSource.getShiftId();
    switch (response) {
      case Success<String>():
        return Success(data: response.data);
      case Failure<String>():
        return Failure(message: response.message);
    }
  }
}
