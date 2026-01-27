import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffTabErrorWidget extends StatelessWidget {
  const StaffTabErrorWidget({super.key, required this.message});
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red),
          Text(
            message ?? 'Failed to load staff',
            style: const TextStyle(color: Colors.red),
          ),

          ElevatedButton(
            onPressed: () {
              context.read<StaffCubit>().doAction(GetManagerStaff());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
