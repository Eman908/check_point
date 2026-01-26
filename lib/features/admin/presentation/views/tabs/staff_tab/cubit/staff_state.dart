import 'package:check_point/core/base/base_state.dart';

class StaffState {
  BaseStatus staff;
  BaseStatus getStaff;
  StaffState({
    this.staff = const BaseStatus.initial(),
    this.getStaff = const BaseStatus.initial(),
  });
  StaffState copyWith({BaseStatus? staff, BaseStatus? getStaff}) {
    return StaffState(
      staff: staff ?? this.staff,
      getStaff: getStaff ?? this.getStaff,
    );
  }
}

sealed class StaffActions {}

final class AddStaff extends StaffActions {
  final String email;

  AddStaff({required this.email});
}

final class GetManagerStaff extends StaffActions {}
