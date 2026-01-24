import 'dart:async';
import 'dart:io';
import 'package:check_point/core/error/results.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Results<T>> safeCall<T>(Future<Results<T>> Function() call) async {
  try {
    return await call();
  } on FirebaseAuthException catch (e) {
    return Failure(exception: e, message: _mapFirebaseAuthMessage(e));
  } on FirebaseException catch (e) {
    return Failure(exception: e, message: _mapFirebaseMessage(e));
  } on TimeoutException catch (e) {
    return Failure(exception: e, message: 'Request timeout');
  } on SocketException catch (e) {
    return Failure(exception: e, message: 'No internet connection');
  } on IOException catch (e) {
    return Failure(exception: e, message: 'Network error');
  } catch (e) {
    return Failure(exception: Exception(e.toString()), message: e.toString());
  }
}

String _mapFirebaseAuthMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return 'The email address is not valid';
    case 'user-disabled':
      return 'This user account has been disabled';
    case 'user-not-found':
      return 'No user found with this email';
    case 'wrong-password':
      return 'Incorrect password';

    case 'invalid-credential':
      return 'Invalid email or password';
    case 'invalid-verification-code':
      return 'Invalid verification code';
    case 'invalid-verification-id':
      return 'Invalid verification ID';

    case 'email-already-in-use':
      return 'An account already exists with this email';
    case 'weak-password':
      return 'Password is too weak. Use at least 6 characters';

    case 'account-exists-with-different-credential':
      return 'An account already exists with the same email but different sign-in credentials';
    case 'credential-already-in-use':
      return 'This credential is already associated with a different user account';

    case 'network-request-failed':
      return 'Network error. Please check your connection';
    case 'too-many-requests':
      return 'Too many attempts. Please try again later';

    case 'null-user':
      return 'No user is currently signed in';

    case 'missing-android-pkg-name':
      return 'An Android package name must be provided';
    case 'missing-continue-uri':
      return 'A continue URL must be provided';
    case 'missing-ios-bundle-id':
      return 'An iOS Bundle ID must be provided';
    case 'invalid-continue-uri':
      return 'The continue URL provided is invalid';
    case 'unauthorized-continue-uri':
      return 'The continue URL domain is not authorized';

    default:
      return e.message ?? 'Authentication failed. Please try again';
  }
}

String _mapFirebaseMessage(FirebaseException e) {
  switch (e.code) {
    case 'permission-denied':
      return 'You do not have permission to perform this action';
    case 'unavailable':
      return 'Service is currently unavailable';
    case 'unauthenticated':
      return 'You must be authenticated to perform this action';
    case 'not-found':
      return 'The requested resource was not found';
    case 'already-exists':
      return 'The resource already exists';
    case 'resource-exhausted':
      return 'Resource quota exceeded';
    case 'cancelled':
      return 'The operation was cancelled';
    case 'data-loss':
      return 'Data loss or corruption occurred';
    case 'deadline-exceeded':
      return 'Operation deadline exceeded';
    case 'failed-precondition':
      return 'Operation failed due to system state';
    case 'internal':
      return 'Internal server error';
    case 'invalid-argument':
      return 'Invalid argument provided';
    case 'out-of-range':
      return 'Value is out of valid range';
    case 'unimplemented':
      return 'This operation is not implemented';
    case 'unknown':
      return 'An unknown error occurred';
    default:
      return e.message ?? 'An error occurred. Please try again';
  }
}
