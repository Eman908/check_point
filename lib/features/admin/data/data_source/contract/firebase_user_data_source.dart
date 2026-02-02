import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class FirebaseUserDataSource {
  Future<Results<String>> updateUserName(String name);
  Future<Results<UserModel>> getUserData();
  Future<Results<String>> userChangePassword(
    String currentPassword,
    String newPassword,
  );
  Future<Results<String>> addStaff({
    required String email,
    required String managerId,
  });
  Future<Results<Stream<QuerySnapshot<UserModel>>>> getStaffList(
    String managerId,
  );

  Future<Results<String>> startShift(ShiftModel shift);
  Future<Results<String>> updateShiftQrCode(String qrCode, String shiftId);
  Future<Results<String>> endShiftNow(String shiftId);
  Future<Results<Stream<QuerySnapshot<ShiftModel>>>> getShift();
  Future<Results<List<UserModel>>> getAttendance();
}
