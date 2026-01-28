import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:flutter/material.dart';

class ShiftState {
  BaseStatus createShift;
  BaseStatus getShift;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final String? qrCode;
  ShiftState({
    this.createShift = const BaseStatus.initial(),
    this.getShift = const BaseStatus.initial(),
    this.startTime,
    this.endTime,
    this.qrCode,
  });

  ShiftState copyWith({
    BaseStatus? createShift,
    BaseStatus? getShift,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? qrCode,
  }) {
    return ShiftState(
      createShift: createShift ?? this.createShift,
      getShift: getShift ?? this.getShift,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      qrCode: qrCode ?? this.qrCode,
    );
  }
}

sealed class ShiftActions {}

final class AddShift extends ShiftActions {
  final ShiftModel shiftModel;
  AddShift(this.shiftModel);
}

final class GetShift extends ShiftActions {}

final class StartTimeUpdate extends ShiftActions {
  final TimeOfDay? time;
  StartTimeUpdate(this.time);
}

final class EndTimeUpdate extends ShiftActions {
  final TimeOfDay? time;
  EndTimeUpdate(this.time);
}

final class QrCodeUpdate extends ShiftActions {}
