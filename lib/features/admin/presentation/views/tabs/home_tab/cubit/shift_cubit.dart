import 'dart:async';

import 'package:check_point/core/base/base_cubit.dart';
import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/error/results.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/features/admin/domain/repo/user_repo.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/cubit/shift_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class ShiftCubit extends BaseCubit<ShiftState, ShiftActions> {
  ShiftCubit() : super(ShiftState());
  final UserRepo _userRepo = getIt<UserRepo>();
  Timer? _qrTimer;

  String _generateQr() => const Uuid().v4();

  void _startQrTimer() {
    _qrTimer?.cancel();

    _qrTimer = Timer.periodic(const Duration(minutes: 3), (_) {
      safeEmit(state.copyWith(qrCode: _generateQr()));
    });
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
        _startShift();
    }
  }

  void _startShift() {
    final qr = _generateQr();
    _startQrTimer();
    safeEmit(state.copyWith(qrCode: qr));
  }

  _startTime(TimeOfDay? time) {
    if (time != null) {
      safeEmit(state.copyWith(startTime: time));
    }
  }

  _endTime(TimeOfDay? time) {
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
        safeEmit(state.copyWith(createShift: const BaseStatus.success()));
      case Failure<String>():
        safeEmit(
          state.copyWith(
            createShift: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }
}
