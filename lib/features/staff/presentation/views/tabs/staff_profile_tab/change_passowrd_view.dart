import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/scaffold_message.dart';
import 'package:check_point/core/utils/validation.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/cubit/profile_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.changePasswordState.status == Status.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(
                message:
                    state.changePasswordState.message ?? 'Something Went Wrong',
                bgColor: Colors.red,
              ),
            );
          } else if (state.changePasswordState.status == Status.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(
                message:
                    state.changePasswordState.message ??
                    'Password Updated Successfully',
                bgColor: Colors.green,
              ),
            );
            context.pop();
          }
        },
        builder: (context, state) {
          var cubit = context.read<ProfileCubit>();
          return Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: oldPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  suffix: InkWell(
                    onTap: () {
                      cubit.doAction(ChangePasswordVisibility());
                    },
                    child: Icon(
                      state.isPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  isPassword: state.isPassword,
                  validator: (value) {
                    return Validation.validatePassword(value);
                  },
                  hintText: 'Old Password',
                  prefix: Icons.lock,
                ),
                CustomTextFormField(
                  controller: newPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  suffix: InkWell(
                    onTap: () {
                      cubit.doAction(ChangePasswordVisibility());
                    },
                    child: Icon(
                      state.isPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  hintText: 'New Password',
                  isPassword: state.isPassword,
                  validator: (value) {
                    return Validation.validatePassword(value);
                  },
                  prefix: Icons.lock,
                ),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  suffix: InkWell(
                    onTap: () {
                      cubit.doAction(ChangePasswordVisibility());
                    },
                    child: Icon(
                      state.isPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  hintText: 'Confirm Password',
                  isPassword: state.isPassword,

                  validator: (value) {
                    return Validation.validatePasswordConfirmation(
                      newPasswordController.text,
                      value,
                    );
                  },
                  prefix: Icons.lock,
                ),
                16.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.doAction(
                          ChangePasswordAction(
                            oldPasswordController.text,
                            newPasswordController.text,
                          ),
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        state.changePasswordState.status == Status.loading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text('Update Password'),
                  ),
                ),
              ],
            ),
          );
        },
      ).horizontalPadding(16),
    );
  }
}
