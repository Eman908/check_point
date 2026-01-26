import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/user_model.dart';

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
}
