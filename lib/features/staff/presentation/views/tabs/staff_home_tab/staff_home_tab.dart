import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/utils/context_extension.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/scaffold_message.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/cubit/shift_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/cubit/shift_state.dart';
import 'package:check_point/features/staff/presentation/views/tabs/staff_home_tab/cubit/attendance_cubit.dart';
import 'package:check_point/features/staff/presentation/views/tabs/staff_home_tab/cubit/attendance_state.dart';
import 'package:check_point/features/staff/presentation/views/tabs/staff_home_tab/qr_scanner_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StuffHomeTab extends StatefulWidget {
  const StuffHomeTab({super.key});

  @override
  State<StuffHomeTab> createState() => _StuffHomeTabState();
}

class _StuffHomeTabState extends State<StuffHomeTab> {
  @override
  void initState() {
    super.initState();
    context.read<ShiftCubit>().doAction(GetShift());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftCubit, ShiftState>(
      builder: (context, shiftState) {
        final Stream<QuerySnapshot<ShiftModel>>? shift =
            shiftState.getShift.data;

        return StreamBuilder<QuerySnapshot<ShiftModel>>(
          stream: shift,
          builder: (context, snapshot) {
            final bool hasActiveShift =
                snapshot.hasData && snapshot.data!.docs.isNotEmpty;

            return BlocConsumer<AttendanceCubit, AttendanceState>(
              listener: (context, state) {
                if (state.attendance.status == Status.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(
                      message:
                          state.attendance.message ?? 'something went wrong',
                      bgColor: Colors.red,
                    ),
                  );
                } else if (state.attendance.status == Status.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(
                      message: 'Attendance recorded successfully!',
                      bgColor: Colors.green,
                    ),
                  );
                }
              },
              builder: (context, state) {
                var cubitA = context.read<AttendanceCubit>();

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!hasActiveShift) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        size: 80,
                        color: Colors.orange,
                      ),
                      16.verticalSpace,
                      Text(
                        'No Active Shift',
                        textAlign: TextAlign.center,
                        style: context.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        'Please wait for admin to start a shift',
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ).horizontalPadding(16);
                }

                if (state.attendance.status == Status.success) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 80,
                      ),
                      16.verticalSpace,
                      Text(
                        'Attendance Successful\nFor Today!',
                        textAlign: TextAlign.center,
                        style: context.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      24.verticalSpace,
                    ],
                  ).horizontalPadding(16);
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome back',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('EEEE, MMMM d HH:mm').format(DateTime.now()),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          // Text(
                          //   'Shift: ${DateFormat('h:mm a').format(currentShift.startTime)} - ${DateFormat('h:mm a').format(currentShift.endTime)}',
                          //   style: context.textTheme.bodySmall?.copyWith(
                          //     color: Colors.green,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    24.verticalSpace,
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: FilledButton(
                        onPressed:
                            state.attendance.status == Status.loading
                                ? null
                                : () async {
                                  cubitA.doAction(
                                    CheckAttendance(
                                      '70c589d0-79a3-4aee-98db-8e2648c66d5c',
                                    ),
                                  );
                                  // final result = await Navigator.of(
                                  //   context,
                                  // ).push(
                                  //   MaterialPageRoute(
                                  //     builder:
                                  //         (context) => const QRScannerView(),
                                  //   ),
                                  // );
                                  // if (result != null && mounted) {
                                  //   cubitA.doAction(
                                  //     CheckAttendance(result.toString()),
                                  //   );
                                  // }
                                },
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:
                            state.attendance.status == Status.loading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text('Scan QR'),
                      ),
                    ),
                  ],
                ).horizontalPadding(16);
              },
            );
          },
        );
      },
    );
  }
}
