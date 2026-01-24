import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/features/admin/presentation/views/widgets/start_shift_window.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Text('Shift Ended'),
          const Text("09:00 - 12:00"),
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
      ).horizontalPadding(16),
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