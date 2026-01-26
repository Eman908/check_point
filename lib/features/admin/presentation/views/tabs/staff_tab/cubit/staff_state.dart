import 'package:check_point/core/base/base_state.dart';

class StaffState {
  BaseStatus staff;

  StaffState({this.staff = const BaseStatus.initial()});
  StaffState copyWith({BaseStatus? staff}) {
    return StaffState(staff: staff ?? this.staff);
  }
}

sealed class StaffActions {}

final class AddStaff extends StaffActions {
  final String email;

  AddStaff({required this.email});
}
