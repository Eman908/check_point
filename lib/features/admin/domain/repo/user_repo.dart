import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/user_model.dart';

abstract interface class UserRepo {
  Future<Results<String>> userChangeUserName(String name);
  Future<Results<UserModel>> getUserData();

  Future<Results<String>> userChangePassword(
    String currentPassword,
    String newPassword,
  );
  Future<Results<String>> addStaff({required String email});
}
