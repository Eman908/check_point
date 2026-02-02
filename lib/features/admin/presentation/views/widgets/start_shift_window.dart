import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/utils/app_colors.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/cubit/shift_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/cubit/shift_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StartShiftWindow extends StatelessWidget {
  const StartShiftWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftCubit, ShiftState>(
      builder: (context, state) {
        var cubit = context.read<ShiftCubit>();

        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          title: const Text('Start Shift'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text('Start Time'),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        cubit.doAction(StartTimeUpdate(time));
                      }
                    },
                    child:
                        cubit.state.startTime == null
                            ? const Icon(
                              Icons.watch_later_outlined,
                              color: AppColors.kRed,
                            )
                            : Text(
                              DateFormat('h:mm a').format(
                                DateTime(
                                  0,
                                  0,
                                  0,
                                  cubit.state.startTime!.hour,
                                  cubit.state.startTime!.minute,
                                ),
                              ),
                            ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Text('End Time'),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        cubit.doAction(EndTimeUpdate(time));
                      }
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child:
                        cubit.state.endTime == null
                            ? const Icon(
                              Icons.watch_later_outlined,
                              color: AppColors.kRed,
                            )
                            : Text(
                              DateFormat('h:mm a').format(
                                DateTime(
                                  0,
                                  0,
                                  0,
                                  cubit.state.endTime!.hour,
                                  cubit.state.endTime!.minute,
                                ),
                              ),
                            ),
                  ),
                ],
              ),
              const Divider(),

              const Text('QR refresh every 3:00 minutes'),
              8.verticalSpace,
              SizedBox(
                width: double.infinity,

                child: FilledButton(
                  onPressed: () {
                    if (cubit.state.startTime == null ||
                        cubit.state.endTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select both start and end times',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    cubit.doAction(QrCodeUpdate());

                    // ✅ CORRECT: Use current date with selected times
                    final now = DateTime.now();

                    final startDateTime = DateTime(
                      now.year, // ✅ Current year
                      now.month, // ✅ Current month
                      now.day, // ✅ Current day
                      cubit.state.startTime!.hour,
                      cubit.state.startTime!.minute,
                    );

                    DateTime endDateTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      cubit.state.endTime!.hour,
                      cubit.state.endTime!.minute,
                    );

                    if (endDateTime.isBefore(startDateTime)) {
                      endDateTime = endDateTime.add(const Duration(days: 1));
                    }

                    ShiftModel shiftModel = ShiftModel(
                      startTime: startDateTime,
                      endTime: endDateTime,
                      qrCode: cubit.state.qrCode ?? '',
                      isActive: true,
                      managerId: FirebaseAuth.instance.currentUser?.uid ?? '',
                      createdAt: DateTime.now(),
                    );

                    context.read<ShiftCubit>().doAction(AddShift(shiftModel));
                    context.pop();
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Start Shift'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
