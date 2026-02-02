import 'package:check_point/core/base/base_cubit.dart';
import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/features/staff/domain/repo/attendance_repo.dart';
import 'package:check_point/features/staff/presentation/views/tabs/staff_home_tab/cubit/attendance_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AttendanceCubit extends BaseCubit<AttendanceState, AttendanceActions> {
  AttendanceCubit() : super(AttendanceState());
  final AttendanceRepo _attendanceRepo = getIt<AttendanceRepo>();
  @override
  Future<void> doAction(AttendanceActions action) async {
    switch (action) {
      case CheckAttendance():
        _checkAttendance(action.qrCode);
    }
  }

  Future<void> _checkAttendance(String qrCode) async {
    safeEmit(state.copyWith(attendance: const BaseStatus.loading()));
    var response = await _attendanceRepo.attendance(qrCode);
    switch (response) {
      case Success<String>():
        safeEmit(state.copyWith(attendance: const BaseStatus.success()));
      case Failure<String>():
        safeEmit(
          state.copyWith(
            attendance: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }
}
