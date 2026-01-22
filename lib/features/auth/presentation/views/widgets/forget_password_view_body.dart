import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomTextFormField(
          hintText: 'New Password',
          prefix: Icons.lock,
          isPassword: true,
        ),
        24.verticalSpace,
        const CustomTextFormField(
          hintText: 'Confirm Password',
          isPassword: true,
          prefix: Icons.lock,
        ),
        24.verticalSpace,

        SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Reset'),
          ),
        ),
      ],
    ).horizontalPadding(16);
  }
}
