import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/cubit/profile_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/cubit/profile_state.dart';
import 'package:check_point/core/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StaffProfileData extends StatefulWidget {
  const StaffProfileData({super.key, required this.cubit});

  final ProfileCubit cubit;

  @override
  State<StaffProfileData> createState() => _StaffProfileDataState();
}

class _StaffProfileDataState extends State<StaffProfileData> {
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.cubit.doAction(GetUserData());
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.getUserDataState.status == Status.loading) {
          return const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            title: Text('Loading...'),
          );
        }

        if (state.getUserDataState.status == Status.failure) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.red,
              child: Icon(Icons.error, color: Colors.white),
            ),
            title: const Text('Error loading user data'),
            subtitle: Text(state.getUserDataState.message ?? 'Unknown error'),
          );
        }

        final userData = state.getUserDataState.data;
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blueGrey,
            child: Text(
              userData?.userName.isNotEmpty == true
                  ? userData!.userName[0].toUpperCase()
                  : 'U',
            ),
          ),
          title: Row(
            spacing: 8,
            children: [
              Text(userData?.userName ?? 'Email'),
              InkWell(
                onTap: () {
                  name.text = userData?.userName ?? '';
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        insetPadding: EdgeInsets.zero,
                        title: const Text('Edit Name'),
                        content: CustomTextFormField(
                          controller: name,
                          hintText: 'User Name',
                          prefix: Icons.person,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              name.clear();
                              context.pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (name.text.trim().isNotEmpty) {
                                await widget.cubit.doAction(
                                  UpdateUserNameAction(name.text.trim()),
                                );
                                name.clear();
                                if (context.mounted) {
                                  context.pop();
                                }
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.edit, size: 20),
              ),
            ],
          ),
          subtitle: Text(userData?.email ?? 'Email'),
        );
      },
    );
  }
}
