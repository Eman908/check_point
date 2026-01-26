import 'package:check_point/core/base/base_cubit.dart';
import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/features/admin/domain/repo/user_repo.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      case GetManagerStaff():
        _getStaffList();
    }
  }

  Future<void> _getStaffList() async {
    safeEmit(state.copyWith(getStaff: const BaseStatus.loading()));
    var response = await _userRepo.getStaffList();
    switch (response) {
      case Success<Stream<QuerySnapshot<UserModel>>>():
        safeEmit(
          state.copyWith(getStaff: BaseStatus.success(data: response.data)),
        );
      case Failure<Stream<QuerySnapshot<UserModel>>>():
        safeEmit(
          state.copyWith(
            getStaff: BaseStatus.failure(message: response.message),
          ),
        );
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
