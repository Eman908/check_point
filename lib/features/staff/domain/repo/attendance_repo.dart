import 'package:check_point/core/error/results.dart';

abstract class AttendanceRepo {
  Future<Results<String>> attendance(String qrCode);
  Future<Results<String>> getAttendance();
}
