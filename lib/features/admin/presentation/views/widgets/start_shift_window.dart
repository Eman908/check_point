import 'package:check_point/core/utils/app_colors.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:flutter/material.dart';

class StartShiftWindow extends StatelessWidget {
  const StartShiftWindow({super.key});

  @override
  Widget build(BuildContext context) {
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
              IconButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                icon: const Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.kRed,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text('End Time'),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                icon: const Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.kRed,
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
              onPressed: () {},
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
  }
}
