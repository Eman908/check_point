import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/firebase/shifts_service.dart';
import 'package:check_point/core/firebase/users_service.dart';
import 'package:check_point/core/models/attendance_model.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class AttendanceService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ShiftsService _shiftsService = getIt<ShiftsService>();
  final UsersService _usersService = getIt<UsersService>();
  CollectionReference<AttendanceModel> collectionReferenceAttendance() {
    return firestore
        .collection(Constants.attendanceCollection)
        .withConverter(
          fromFirestore:
              (snapshot, _) => AttendanceModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  Future<void> setAttendance(String qrCode) async {
    var shift = await _shiftsService.createShiftsCollection().get();
    if (shift.docs.firstWhere((e) => e.data().qrCode == qrCode).exists) {
      AttendanceModel attendanceModel = AttendanceModel(
        managerId: shift.docs.first.data().managerId,
        staffId: FirebaseAuth.instance.currentUser?.uid ?? '',
        date: DateTime.now(),
        status: 'present',
      );
      await collectionReferenceAttendance().doc().set(attendanceModel);
    } else {
      throw Exception('Shift not found');
    }
  }

  Future<void> deleteAttendance() async {
    final firestore = FirebaseFirestore.instance;

    var collection = collectionReferenceAttendance().where(
      'managerId',
      isEqualTo: FirebaseAuth.instance.currentUser?.uid,
    );

    var snapshot = await collection.get();

    WriteBatch batch = firestore.batch();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future getUserAttendance() async {
    var collection =
        await collectionReferenceAttendance()
            .where('staffId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .get();
    if (collection.docs.isEmpty) {
      throw Exception('');
    }
    return collection.docs.first.data();
  }

  Future<List<UserModel>> getAttendance() async {
    var collection =
        await collectionReferenceAttendance()
            .where(
              'managerId',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid,
            )
            .get();

    if (collection.docs.isEmpty) {
      return [];
    }

    final staffIds = collection.docs.map((doc) => doc.data().staffId).toList();

    var usersSnapshot =
        await _usersService
            .getUserCollection()
            .where('userId', whereIn: staffIds)
            .get();

    return usersSnapshot.docs.map((doc) => doc.data()).toList();
  }
}
