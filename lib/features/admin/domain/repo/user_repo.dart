import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class UserRepo {
  Future<Results<String>> userChangeUserName(String name);
  Future<Results<UserModel>> getUserData();

  Future<Results<String>> userChangePassword(
    String currentPassword,
    String newPassword,
  );
  Future<Results<String>> addStaff({required String email});
  Future<Results<Stream<QuerySnapshot<UserModel>>>> getStaffList();
  Future<Results<String>> startShift(ShiftModel shift);
  Future<Results<String>> updateShiftQrCode(String qrCode, String shiftId);
  Future<Results<String>> endShift(String shiftId);
  Future<Results<List<UserModel>>> getAttendance();
  Future<Results<Stream<QuerySnapshot<ShiftModel>>>> getShift();
}
