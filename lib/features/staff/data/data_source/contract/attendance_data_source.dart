import 'package:check_point/core/error/results.dart';

abstract class AttendanceDataSource {
  Future<Results<String>> setAttendance(String qrCode);
  Future<Results<String>> getAttendance();
}
