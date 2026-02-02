import 'package:check_point/core/base/base_cubit.dart';
import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:check_point/features/admin/domain/repo/user_repo.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/cubit/shift_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

@injectable
class ShiftCubit extends BaseCubit<ShiftState, ShiftActions> {
  ShiftCubit() : super(ShiftState());
  final UserRepo _userRepo = getIt<UserRepo>();
  final SharedPreferences _preferences = getIt<SharedPreferences>();
  Timer? _qrTimer;

  String _generateQr() => const Uuid().v4();

  void _startQrTimer(String shiftId) {
    _qrTimer?.cancel();

    final initialQr = _generateQr();
    safeEmit(state.copyWith(qrCode: initialQr));

    _userRepo.updateShiftQrCode(initialQr, shiftId);

    _qrTimer = Timer.periodic(const Duration(hours: 15), (_) async {
      final newQr = _generateQr();

      safeEmit(state.copyWith(qrCode: newQr));

      await _userRepo.updateShiftQrCode(newQr, shiftId);
    });
  }

  void stopQrTimer() {
    _qrTimer?.cancel();
    _qrTimer = null;
  }

  @override
  Future<void> close() {
    _qrTimer?.cancel();

    return super.close();
  }

  @override
  Future<void> doAction(ShiftActions action) async {
    switch (action) {
      case AddShift():
        _createShift(action.shiftModel);
      case GetShift():
        _getShift();
      case StartTimeUpdate():
        _startTime(action.time);
      case EndTimeUpdate():
        _endTime(action.time);
      case QrCodeUpdate():
        _updateQrCode();
      case StopShift():
        _stopShift();
      case EndShift():
        _endShift();
      case GetAttendance():
        _getAttendance();
    }
  }

  Future<void> _getAttendance() async {
    var response = await _userRepo.getAttendance();
    switch (response) {
      case Success<List<UserModel>>():
        safeEmit(
          state.copyWith(
            getAttendance: BaseStatus.success(data: response.data),
          ),
        );
      case Failure<List<UserModel>>():
        safeEmit(
          state.copyWith(
            getAttendance: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }

  _endShift() async {
    final String shiftIdd = _preferences.getString(Constants.shiftId) ?? '';
    if (shiftIdd.isEmpty) return;
    await _userRepo.endShift(shiftIdd);
    _stopShift();
    _preferences.remove(Constants.shiftId);
  }

  void _updateQrCode() {
    final qr = _generateQr();
    safeEmit(state.copyWith(qrCode: qr));

    if (state.shiftId != null) {
      _userRepo.updateShiftQrCode(qr, state.shiftId!);
    }
  }

  void _startTime(TimeOfDay? time) {
    if (time != null) {
      safeEmit(state.copyWith(startTime: time));
    }
  }

  void _endTime(TimeOfDay? time) {
    if (time != null) {
      safeEmit(state.copyWith(endTime: time));
    }
  }

  Future<void> _getShift() async {
    safeEmit(state.copyWith(getShift: const BaseStatus.loading()));
    var response = await _userRepo.getShift();
    switch (response) {
      case Success<Stream<QuerySnapshot<ShiftModel>>>():
        safeEmit(
          state.copyWith(getShift: BaseStatus.success(data: response.data)),
        );
      case Failure<Stream<QuerySnapshot<ShiftModel>>>():
        safeEmit(
          state.copyWith(
            getShift: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }

  Future<void> _createShift(ShiftModel shift) async {
    safeEmit(state.copyWith(createShift: const BaseStatus.loading()));
    var response = await _userRepo.startShift(shift);
    switch (response) {
      case Success<String>():
        final shiftId = response.data ?? '';
        safeEmit(state.copyWith(shiftId: shiftId));
        _startQrTimer(shiftId);
        _preferences.setString(Constants.shiftId, shiftId);
        safeEmit(
          state.copyWith(createShift: BaseStatus.success(data: response.data)),
        );

      case Failure<String>():
        safeEmit(
          state.copyWith(
            createShift: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }

  Future<void> _stopShift() async {
    stopQrTimer();
    safeEmit(state.copyWith(shiftId: null, qrCode: null));
  }
}
