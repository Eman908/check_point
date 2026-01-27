import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/firebase/auth_service.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class UsersService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthService authService = getIt<AuthService>();
  CollectionReference<UserModel> getUserCollection() {
    return firestore
        .collection(Constants.userCollection)
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  Future<void> setUser(UserModel user) async {
    var userCollection = getUserCollection().doc(user.userId);
    var data = await userCollection.get();
    if (data.exists) {
      return;
    }
    userCollection.set(user);
  }

  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    var userCollection = getUserCollection().doc(userId);

    var doc = await userCollection.get();
    if (!doc.exists) {
      throw Exception('User document not found');
    }

    await userCollection.update(data);
  }

  Future<void> updateState() async {
    var collection = getUserCollection();
    final currentUser = AuthService.firebaseAuth.currentUser;

    if (currentUser != null) {
      final userId = currentUser.uid;
      await collection.doc(userId).update({'status': 'active'});
    }
  }

  ///manager id
  ///check if this is the current email
  Future<void> addStaff({
    required String email,
    required String managerId,
  }) async {
    UserCredential credential = await AuthService.firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: 'Temp@123456');

    final uid = credential.user!.uid;
    UserModel user = UserModel(
      userName: '',
      userId: uid,
      email: email,
      role: 'staff',
      managerId: managerId,
      status: 'invited',
    );
    await setUser(user);
    await AuthService.firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Stream<QuerySnapshot<UserModel>> getStaffList(String managerId) {
    var staffList =
        getUserCollection()
            .where('managerId', isEqualTo: managerId)
            .snapshots();
    return staffList;
  }

  Future<UserModel?> getUserData() async {
    String userId = AuthService.firebaseAuth.currentUser!.uid;
    var userCollection = getUserCollection().doc(userId);
    var data = await userCollection.get();
    return data.data();
  }
}
