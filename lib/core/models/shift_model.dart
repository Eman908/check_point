import 'package:cloud_firestore/cloud_firestore.dart';

class ShiftModel {
  final DateTime startTime;
  final DateTime endTime;
  final String qrCode;
  final String managerId;
  final bool isActive;
  final DateTime createdAt;

  ShiftModel({
    required this.startTime,
    required this.endTime,
    required this.qrCode,
    required this.managerId,
    required this.createdAt,
    this.isActive = false,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      startTime: (json['startTime'] as Timestamp).toDate(),
      endTime: (json['endTime'] as Timestamp).toDate(),
      qrCode: json['qrCode'],
      managerId: json['managerId'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'startTime': Timestamp.fromDate(startTime),
    'endTime': Timestamp.fromDate(endTime),
    'qrCode': qrCode,
    'managerId': managerId,
    'isActive': isActive,
    'createdAt': createdAt.toIso8601String(),
  };
}
