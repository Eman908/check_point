import 'package:check_point/core/base/base_state.dart';

class AttendanceState {
  BaseStatus attendance;

  AttendanceState({this.attendance = const BaseStatus.initial()});

  AttendanceState copyWith({BaseStatus? attendance}) =>
      AttendanceState(attendance: attendance ?? this.attendance);
}

sealed class AttendanceActions {}

final class CheckAttendance extends AttendanceActions {
  final String qrCode;
  CheckAttendance(this.qrCode);
}
