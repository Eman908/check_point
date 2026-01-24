import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/utils/app_routes.dart';
import 'package:check_point/core/utils/constants.dart';
import 'package:check_point/core/utils/context_extension.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/scaffold_message.dart';
import 'package:check_point/core/utils/validation.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:check_point/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:check_point/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthCubit cubit;
  final SharedPreferences prefs = getIt<SharedPreferences>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRole = prefs.getString(Constants.userRole);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.loginState.status == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              message: state.loginState.message ?? 'Login Success',
              bgColor: Colors.green,
            ),
          );
          userRole == 'manager'
              ? context.go(AppRoutes.kAdminView)
              : context.go(AppRoutes.kStaffHomeView);
        } else if (state.loginState.status == Status.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              message: state.loginState.message ?? 'Something Went Wrong',
              bgColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        cubit = context.read<AuthCubit>();
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                autofillHints: const [AutofillHints.email],
                validator: (value) {
                  return Validation.validateEmail(value);
                },
                hintText: 'Email',
                prefix: Icons.email,
              ),
              24.verticalSpace,
              CustomTextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: password,
                suffix: InkWell(
                  onTap: () {
                    cubit.doAction(PasswordVisibility());
                  },
                  child: Icon(
                    state.isPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                hintText: 'Password',
                isPassword: state.isPassword,
                prefix: Icons.lock,
                validator: (value) {
                  return Validation.validatePassword(value);
                },
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
                    if (_formKey.currentState!.validate()) {
                      cubit.doAction(AuthLogin(email.text, password.text));
                    }
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      state.loginState.status == Status.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Login'),
                ),
              ),
            ],
          ).horizontalPadding(16),
        );
      },
    );
  }
}
