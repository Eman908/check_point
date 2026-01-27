import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/utils/app_routes.dart';
import 'package:check_point/core/utils/context_extension.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/cubit/profile_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/cubit/profile_state.dart';
import 'package:check_point/features/admin/presentation/views/widgets/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserData(cubit: cubit),
            const Divider(),
            8.verticalSpace,
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Attendance History"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                context.push(AppRoutes.kChangePasswordView);
              },
              contentPadding: EdgeInsets.zero,
              title: const Text("Change Password"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            8.verticalSpace,

            const Divider(),
            TextButton(
              onPressed: () {},
              child: Text(
                "Delete Account",
                style: TextStyle(color: context.color.error),
              ),
            ),
            8.verticalSpace,
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () {
                  cubit.doAction(Logout());
                  if (context.mounted) context.go(AppRoutes.kLoginView);
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                    state.logoutState.status == Status.loading
                        ? const CircularProgressIndicator()
                        : const Text("Logout"),
              ),
            ),
          ],
        );
      },
    ).horizontalPadding(16);
  }
}
