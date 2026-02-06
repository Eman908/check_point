import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/features/staff/data/data_source/contract/attendance_data_source.dart';
import 'package:check_point/features/staff/domain/repo/attendance_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AttendanceRepo)
class AttendanceRepoImpl implements AttendanceRepo {
  final AttendanceDataSource _attendanceDataSource =
      getIt<AttendanceDataSource>();

  @override
  Future<Results<String>> attendance(String qrCode) async {
    var response = await _attendanceDataSource.setAttendance(qrCode);
    switch (response) {
      case Success<String>():
        return Success();
      case Failure<String>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<String>> getAttendance() async {
    var response = await _attendanceDataSource.getAttendance();
    switch (response) {
      case Success<String>():
        return Success();
      case Failure<String>():
        return Failure(message: response.message);
    }
  }
}
