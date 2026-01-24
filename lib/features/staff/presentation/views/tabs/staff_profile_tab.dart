import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:flutter/material.dart';

class StuffProfileTab extends StatelessWidget {
  const StuffProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(radius: 24),
          title: Text("Username"),
          subtitle: Text("Email"),
        ),
        const Divider(),
        8.verticalSpace,
        const ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text("Attendance History"),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text("Change Password"),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        8.verticalSpace,

        const Divider(),
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
            child: const Text("Logout"),
          ),
        ),
      ],
    ).horizontalPadding(16);
  }
}
