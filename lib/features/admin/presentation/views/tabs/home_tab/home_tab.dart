import 'dart:async';
import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/models/shift_model.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/scaffold_message.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/cubit/shift_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/cubit/shift_state.dart';
import 'package:check_point/features/admin/presentation/views/widgets/start_shift_window.dart';
import 'package:check_point/features/admin/presentation/views/widgets/status_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    context.read<ShiftCubit>().doAction(GetShift());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftCubit, ShiftState>(
      builder: (context, state) {
        if (state.createShift.status == Status.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              message: state.createShift.message ?? 'Failed to start shift',
              bgColor: Colors.red,
            ),
          );
        }
        final Stream<QuerySnapshot<ShiftModel>>? shift = state.getShift.data;

        return StreamBuilder(
          stream: shift,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline),
                  const Text('No Active Shifts Yet'),
                  24.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (dialogContext) => BlocProvider.value(
                                value: context.read<ShiftCubit>(),
                                child: const StartShiftWindow(),
                              ),
                        );
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
              ).horizontalPadding(16);
            }

            final shiftData = snapshot.data!.docs.first.data();

            final qrCode = state.qrCode ?? shiftData.qrCode;

            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatusCard(
                    title: shiftData.isActive ? 'Active' : 'Inactive',
                    color: shiftData.isActive ? Colors.green : Colors.red,
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${DateFormat('h:mm a').format(shiftData.startTime)} - ${DateFormat('h:mm a').format(shiftData.endTime)}",
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: QrImageView(data: qrCode, size: 200),
                  ),
                  8.verticalSpace,
                  const Text('QR refreshes every 3 minutes'),
                  16.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        //context.read<ShiftCubit>().doAction(EndShift());
                        final cubit = context.read<ShiftCubit>();
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                title: const Text('End Shift'),
                                content: const Text(
                                  'Are you sure you want to end the shift?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => {context.pop()},
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await cubit.doAction(EndShift());
                                      if (context.mounted) {
                                        context.pop();
                                      }
                                    },
                                    child: const Text('End Shift'),
                                  ),
                                ],
                              ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('End Shift Now'),
                    ),
                  ),
                ],
              ).horizontalPadding(16),
            );
          },
        );
      },
    );
  }
}
