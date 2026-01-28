import 'package:check_point/core/firebase/auth_service.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShiftsService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference<ShiftModel> createShiftsCollection() {
    return firestore
        .collection(Constants.shiftsCollection)
        .withConverter(
          fromFirestore: (snapshot, _) => ShiftModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  Future<void> setShift(ShiftModel shift) async {
    var collection = createShiftsCollection();
    var isExisted =
        await collection
            .where('qrCode', isEqualTo: shift.qrCode)
            .where('managerId', isEqualTo: shift.managerId)
            .get();
    if (isExisted.docs.isNotEmpty) {
      throw Exception('Shift already exists');
    }
    await collection.doc().set(shift);
  }

  Stream<QuerySnapshot<ShiftModel>> getShift() {
    var collection = createShiftsCollection().where(
      'managerId',
      isEqualTo: AuthService.firebaseAuth.currentUser!.uid,
    );
    var data = collection.snapshots();
    return data;
  }
}
