import 'package:check_point/core/base/base_state.dart';
import 'package:check_point/core/models/user_model.dart';
import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/utils/white_space_extension.dart';
import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_state.dart';
import 'package:check_point/features/admin/presentation/views/widgets/staff_card.dart';
import 'package:check_point/features/admin/presentation/views/widgets/staff_tab_error_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffTab extends StatefulWidget {
  const StaffTab({super.key});

  @override
  State<StaffTab> createState() => _StaffTabState();
}

class _StaffTabState extends State<StaffTab> {
  TextEditingController search = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<StaffCubit>().doAction(GetManagerStaff());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    search.dispose();
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
            return StaffTabErrorWidget(message: state.getStaff.message);
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
              final filteredList =
                  staffList
                      .where(
                        (e) =>
                            e.data().userName.toLowerCase().contains(
                              search.text.toLowerCase(),
                            ) ||
                            e.data().email.toLowerCase().contains(
                              search.text.toLowerCase(),
                            ),
                      )
                      .toList();
              return Column(
                children: [
                  CustomTextFormField(
                    hintText: 'Search',
                    controller: search,
                    onChanged: (value) {
                      search.text = value;

                      setState(() {});
                    },
                    prefix: Icons.search,
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder:
                          (context, index) =>
                              const Divider(color: Colors.black12),
                      itemCount:
                          search.text.isNotEmpty
                              ? filteredList.length
                              : staffList.length,
                      itemBuilder: (context, index) {
                        final staff = staffList[index].data();
                        final filteredStaff = filteredList[index].data();
                        return StaffCard(
                          user: search.text.isNotEmpty ? filteredStaff : staff,
                        );
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
