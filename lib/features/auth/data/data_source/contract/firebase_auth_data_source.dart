import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class FirebaseAuthDataSource {
  Future<Results<User>> userLogin(String email, String password);
  Future<Results<void>> userSignOut();
  Future<Results<void>> userResetPassword(String email);
  Future<Results<String>> updateUserName(String name);
  Future<Results<UserModel>> getUserData();
  Future<Results<String>> userChangePassword(
    String currentPassword,
    String newPassword,
  );
}
