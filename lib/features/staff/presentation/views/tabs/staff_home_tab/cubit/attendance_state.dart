import 'package:check_point/core/base/base_state.dart';

class AttendanceState {
  BaseStatus attendance;
  BaseStatus getAttendance;
  AttendanceState({
    this.attendance = const BaseStatus.initial(),
    this.getAttendance = const BaseStatus.initial(),
  });

  AttendanceState copyWith({
    BaseStatus? attendance,
    BaseStatus? getAttendance,
  }) => AttendanceState(
    attendance: attendance ?? this.attendance,
    getAttendance: getAttendance ?? this.getAttendance,
  );
}

sealed class AttendanceActions {}

final class CheckAttendance extends AttendanceActions {
  final String qrCode;
  CheckAttendance(this.qrCode);
}

final class GetStaffAttendance extends AttendanceActions {}
