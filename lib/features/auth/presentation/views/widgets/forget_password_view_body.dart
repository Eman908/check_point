import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/scaffold_message.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:check_point/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:check_point/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});
  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  TextEditingController email = TextEditingController();
  late AuthCubit cubit;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        cubit = context.read<AuthCubit>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              hintText: 'Email',
              autofillHints: const [AutofillHints.email],

              prefix: Icons.email,
            ),
            24.verticalSpace,

            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () {
                  cubit.doAction(AuthForgetPassword(email.text));
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Send Reset Email'),
              ),
            ),
          ],
        );
      },
      listener: (BuildContext context, AuthState state) {
        if (state.resetPasswordState.status == Status.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              message: state.loginState.message ?? 'Something Went Wrong',
              bgColor: Colors.red,
            ),
          );
        } else if (state.resetPasswordState.status == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              seconds: 4,
              message: state.loginState.message ?? 'Login Success',
              bgColor: Colors.green,
            ),
          );
          context.pop();
        }
      },
    ).horizontalPadding(16);
  }
}
