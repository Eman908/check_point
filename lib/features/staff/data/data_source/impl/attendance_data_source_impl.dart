import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/error/safe_call.dart';
import 'package:check_point/core/firebase/attendance_service.dart';
import 'package:check_point/features/staff/data/data_source/contract/attendance_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AttendanceDataSource)
class AttendanceDataSourceImpl implements AttendanceDataSource {
  final AttendanceService _attendanceService = getIt();
  @override
  Future<Results<String>> setAttendance(String qrCode) async {
    return safeCall(() async {
      await _attendanceService.setAttendance(qrCode);
      return Success();
    });
  }

  @override
  Future<Results<String>> getAttendance() async {
    return safeCall(() async {
      await _attendanceService.getUserAttendance();
      return Success();
    });
  }
}
