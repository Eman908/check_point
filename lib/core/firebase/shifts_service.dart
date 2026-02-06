import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<String> setShift(ShiftModel shift) async {
    var collection = createShiftsCollection();

    var isExisted =
        await collection.where('managerId', isEqualTo: shift.managerId).get();

    if (isExisted.docs.isNotEmpty) {
      throw Exception('Shift already exists');
    }
    var docRef = collection.doc();
    await docRef.set(shift);
    return docRef.id;
  }

  Future<String> getShiftId() async {
    var collection = createShiftsCollection();
    var isExisted =
        await collection
            .where(
              'managerId',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? '',
            )
            .get();
    if (isExisted.docs.isEmpty) {
      throw Exception('no docs');
    }
    return isExisted.docs.first.id;
  }

  endShift(String shiftId) async {
    var collection = createShiftsCollection();
    await collection.doc(shiftId).delete();
  }

  Stream<QuerySnapshot<ShiftModel>> getShift() {
    var collection = createShiftsCollection()
        .where('isActive', isEqualTo: true)
        .limit(1);
    var data = collection.snapshots();
    return data;
  }

  Future<void> updateShiftQr(String newQr, String shiftId) async {
    await createShiftsCollection().doc(shiftId).update({'qrCode': newQr});
  }
}
