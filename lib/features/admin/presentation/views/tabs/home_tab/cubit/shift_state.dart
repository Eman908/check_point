import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:flutter/material.dart';

class ShiftState {
  BaseStatus createShift;
  BaseStatus getShift;
  BaseStatus getAttendance;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final String? qrCode;
  final String? shiftId;

  ShiftState({
    this.createShift = const BaseStatus.initial(),
    this.getShift = const BaseStatus.initial(),
    this.getAttendance = const BaseStatus.initial(),
    this.startTime,
    this.endTime,
    this.qrCode,
    this.shiftId,
  });

  ShiftState copyWith({
    BaseStatus? createShift,
    BaseStatus? getAttendance,
    BaseStatus? getShift,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? qrCode,
    String? shiftId,
  }) {
    return ShiftState(
      createShift: createShift ?? this.createShift,
      getShift: getShift ?? this.getShift,
      startTime: startTime ?? this.startTime,
      getAttendance: getAttendance ?? this.getAttendance,
      endTime: endTime ?? this.endTime,
      qrCode: qrCode ?? this.qrCode,
      shiftId: shiftId ?? this.shiftId,
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

final class StopShift extends ShiftActions {}

final class EndShift extends ShiftActions {}

final class GetAttendance extends ShiftActions {}
