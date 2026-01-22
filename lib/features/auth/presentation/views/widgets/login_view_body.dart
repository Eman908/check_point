import 'package:check_point/core/utils/app_routes.dart';
import 'package:check_point/core/utils/context_extension.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const CustomTextFormField(hintText: 'Email', prefix: Icons.email),
        24.verticalSpace,
        const CustomTextFormField(
          hintText: 'Password',
          isPassword: true,
          prefix: Icons.lock,
        ),
        TextButton(
          onPressed: () {
            context.push(AppRoutes.kForgetPasswordView);
          },
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: Text(
            'Forget Password ?',
            style: context.textTheme.bodyMedium!.copyWith(
              color: Colors.black54,
            ),
          ),
        ),
        24.verticalSpace,
        SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton(
            onPressed: () {
              context.go(AppRoutes.kAdminView);
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Login'),
          ),
        ),
      ],
    ).horizontalPadding(16);
  }
}
