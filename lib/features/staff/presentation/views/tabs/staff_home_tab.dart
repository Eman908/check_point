import 'package:check_point/core/utils/context_extension.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:flutter/material.dart';

class StuffHomeTab extends StatelessWidget {
  const StuffHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome back, Eman',
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text('Tuesday, May 24 05:23'),
        24.verticalSpace,
        SizedBox(
          height: 50,
          width: double.infinity,
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Scan QR'),
          ),
        ),
      ],
    ).horizontalPadding(16);
  }
}
