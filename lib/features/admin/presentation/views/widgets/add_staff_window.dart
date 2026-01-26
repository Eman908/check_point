import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/utils/scaffold_message.dart';
import 'package:check_point/core/utils/validation.dart';
import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddStaffWindow extends StatefulWidget {
  const AddStaffWindow({super.key});

  @override
  State<AddStaffWindow> createState() => _AddStaffWindowState();
}

class _AddStaffWindowState extends State<AddStaffWindow> {
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StaffCubit, StaffState>(
      listener: (context, state) {
        if (state.staff.status == Status.success) {
          context.pop();
          emailController.clear();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(snackBar(message: 'Success', bgColor: Colors.green));
        } else if (state.staff.status == Status.failure) {
          context.pop();
          emailController.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            snackBar(
              message: state.staff.message ?? 'something went wrong',
              bgColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          title: const Text('Add Staff'),
          content: CustomTextFormField(
            controller: emailController,
            hintText: 'Email',
            prefix: Icons.email,
            validator: (value) {
              return Validation.validateEmail(value);
            },
            autofillHints: const [AutofillHints.email],
          ),
          actions: [
            TextButton(
              onPressed: () {
                emailController.clear();
                context.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<StaffCubit>().doAction(
                  AddStaff(email: emailController.text),
                );
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
