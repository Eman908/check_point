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
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      qrCode: json['qrCode'],
      managerId: json['managerId'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
    'qrCode': qrCode,
    'managerId': managerId,
    'isActive': isActive,
    'createdAt': createdAt.toIso8601String(),
  };
}
