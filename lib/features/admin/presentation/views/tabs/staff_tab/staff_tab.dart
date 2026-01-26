import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_state.dart';
import 'package:check_point/features/admin/presentation/views/widgets/staff_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffTab extends StatefulWidget {
  const StaffTab({super.key});

  @override
  State<StaffTab> createState() => _StaffTabState();
}

class _StaffTabState extends State<StaffTab> {
  @override
  void initState() {
    super.initState();
    context.read<StaffCubit>().doAction(GetManagerStaff());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<StaffCubit, StaffState>(
        builder: (context, state) {
          if (state.getStaff.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.getStaff.status == Status.failure) {
            return Center(
              child: Column(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  Text(
                    state.getStaff.message ?? 'Failed to load staff',
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

          final Stream<QuerySnapshot<UserModel>>? staffStream =
              state.getStaff.data;

          if (staffStream == null) {
            return const Center(child: Text('No data available'));
          }

          return StreamBuilder<QuerySnapshot<UserModel>>(
            stream: staffStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.people_outline, color: Colors.grey),
                      16.verticalSpace,
                      const Text('No staff members found'),
                    ],
                  ),
                );
              }

              final staffList = snapshot.data!.docs;

              return Column(
                children: [
                  const CustomTextFormField(
                    hintText: 'Search',
                    prefix: Icons.search,
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder:
                          (context, index) =>
                              const Divider(color: Colors.black12),
                      itemCount: staffList.length,
                      itemBuilder: (context, index) {
                        final staff = staffList[index].data();

                        return StaffCard(user: staff);
                      },
                    ),
                  ),
                ],
              ).horizontalPadding(16);
            },
          );
        },
      ),
    );
  }
}
