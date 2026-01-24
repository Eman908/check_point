import 'package:check_point/core/firebase/auth_service.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class UsersService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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

  Future<UserModel?> getUserData() async {
    String userId = AuthService.firebaseAuth.currentUser!.uid;
    var userCollection = getUserCollection().doc(userId);
    var data = await userCollection.get();
    return data.data();
  }
}
