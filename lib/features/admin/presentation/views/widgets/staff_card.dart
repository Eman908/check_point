import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/features/admin/presentation/views/widgets/status_card.dart';
import 'package:flutter/material.dart';

class StaffCard extends StatelessWidget {
  const StaffCard({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: Text(user.userName.isNotEmpty ? user.userName[0] : 'U'),
        ),
        16.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.userName.isEmpty ? 'User Name Not Set Yet' : user.userName,
            ),
            Text(user.email),
          ],
        ),
        const Spacer(),
        StatusCard(
          title: user.status ?? '',
          color: user.status == 'invited' ? Colors.red : Colors.green,
        ),
      ],
    ).verticalPadding(8);
  }
}
