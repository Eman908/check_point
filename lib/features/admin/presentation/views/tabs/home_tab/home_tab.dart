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
    // TODO: implement initState
    super.initState();
    context.read<ShiftCubit>().doAction(GetShift());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShiftCubit, ShiftState>(
      builder: (context, state) {
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
                          builder: (context) => const StartShiftWindow(),
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
            final staffData = snapshot.data!.docs.first.data();
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatusCard(
                    title: staffData.isActive ? 'Active' : 'Inactive',
                    color: staffData.isActive ? Colors.green : Colors.red,
                  ),
                  16.verticalSpace,
                  Text(
                    "${DateFormat('h:mm a').format(staffData.startTime)} - ${DateFormat('h:mm a').format(staffData.endTime)}",
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: QrImageView(data: staffData.qrCode),
                  ),
                  const Text('QR expires in 02:30'),
                ],
              ),
            );
          },
        );
      },
      listener: (BuildContext context, ShiftState state) {
        if (state.createShift.status == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              message: state.createShift.message ?? 'Success',
              bgColor: Colors.green,
            ),
          );
          context.pop();
        } else if (state.createShift.status == Status.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              message: state.createShift.message ?? 'something went wrong',
              bgColor: Colors.red,
            ),
          );
          context.pop();
        }
      },
    );
  }
}



///-----------------Start Shift Ui

// SafeArea(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text('Active Shift'),
//           const Text("09:00 - 12:00"),
//           16.verticalSpace,
//           Container(color: Colors.red, width: double.infinity, height: 100),
//           16.verticalSpace,
//           const Text('QR expires in 02:30'),
//           16.verticalSpace,
//           const Divider(),
//           Row(
//             children: [
//               const Text('Confirmed Employees'),
//               const Spacer(),
//               IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
//             ],
//           ),
//           Expanded(
//             child: ListView.separated(
//               physics: const BouncingScrollPhysics(),
//               separatorBuilder:
//                   (context, index) => const Divider(color: Colors.black12),
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return const ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   leading: CircleAvatar(backgroundColor: Colors.black),
//                   title: Text('UserName'),
//                   subtitle: Text('Checked in 09:23'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ).horizontalPadding(16),
//     );





///-----------------No Shifts Yet

// Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Icon(Icons.error_outline),
//         const Text('No Active Shifts Yet'),
//         24.verticalSpace,
//         SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: FilledButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => const StartShiftWindow(),
//               );
//             },
//             style: FilledButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text('Start Shift'),
//           ),
//         ),
//       ],
//     ).horizontalPadding(16);