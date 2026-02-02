import 'package:check_point/core/di/di.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/home_tab.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/profile_tab.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/staff_tab.dart';
import 'package:check_point/features/admin/presentation/views/widgets/add_staff_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  ValueNotifier<int> indexChangeNotifier = ValueNotifier<int>(0);
  List<Widget> pages = [
    const HomeTab(),
    BlocProvider.value(value: getIt<StaffCubit>(), child: const StaffTab()),
    const ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, value, child) {
        return Scaffold(
          body: pages[indexChangeNotifier.value],
          floatingActionButton:
              indexChangeNotifier.value == 1
                  ? FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddStaffWindow(),
                      );
                    },
                    shape: const CircleBorder(),
                    child: const Icon(Icons.add),
                  )
                  : null,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              indexChangeNotifier.value = value;
            },
            currentIndex: indexChangeNotifier.value,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: "Staff"),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
