import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/firebase/users_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final UsersService _userService = getIt();
  Future<UserCredential> login(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final credential = EmailAuthProvider.credential(
      email: firebaseAuth.currentUser!.email!,
      password: currentPassword,
    );
    await firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    await firebaseAuth.currentUser!.updatePassword(newPassword);
  }

  Future<void> updateUserName(String name) async {
    if (firebaseAuth.currentUser == null) {
      throw Exception('No user is currently logged in');
    }

    await firebaseAuth.currentUser!.updateDisplayName(name);

    await _userService.updateUserData(firebaseAuth.currentUser!.uid, {
      'userName': name,
    });

    await firebaseAuth.currentUser!.reload();
  }
}
