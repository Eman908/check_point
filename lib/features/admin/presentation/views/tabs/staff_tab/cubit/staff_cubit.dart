import 'package:check_point/core/base/base_cubit.dart';
import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/features/admin/domain/repo/user_repo.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StaffCubit extends BaseCubit<StaffState, StaffActions> {
  StaffCubit() : super(StaffState());
  final UserRepo _userRepo = getIt<UserRepo>();
  @override
  Future<void> doAction(StaffActions action) async {
    switch (action) {
      case AddStaff():
        _addStaff(email: action.email);
    }
  }

  Future<void> _addStaff({required String email}) async {
    safeEmit(state.copyWith(staff: const BaseStatus.loading()));
    var response = await _userRepo.addStaff(email: email);
    switch (response) {
      case Success<String>():
        safeEmit(state.copyWith(staff: const BaseStatus.success()));
      case Failure<String>():
        safeEmit(
          state.copyWith(staff: BaseStatus.failure(message: response.message)),
        );
    }
  }
}
