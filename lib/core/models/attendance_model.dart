import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String managerId;
  final String staffId;
  final DateTime date;
  final String status;

  AttendanceModel({
    required this.managerId,
    required this.staffId,
    required this.date,
    required this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      managerId: json['managerId'],
      staffId: json['staffId'],
      date: (json['date'] as Timestamp).toDate(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'managerId': managerId,
    'staffId': staffId,
    'date': Timestamp.fromDate(date), // date,
    'status': status,
  };
}
