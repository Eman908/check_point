import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/error/safe_call.dart';
import 'package:check_point/core/firebase/auth_service.dart';
import 'package:check_point/features/auth/data/data_source/contract/firebase_auth_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FirebaseAuthDataSource)
class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final AuthService _authService = getIt();
  @override
  Future<Results<User>> userLogin(String email, String password) async {
    return safeCall(() async {
      var response = await _authService.login(email, password);
      if (response.user == null) {
        return Failure(message: 'Login failed');
      }
      return Success(data: response.user);
    });
  }

  @override
  Future<Results<void>> userSignOut() async {
    return safeCall(() async {
      await _authService.signOut();
      return Success();
    });
  }


  @override
  Future<Results<void>> userResetPassword(String email) async {
    return safeCall(() async {
      await _authService.resetPassword(email);
      return Success();
    });
  }


}
