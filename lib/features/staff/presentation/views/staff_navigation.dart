import 'package:check_point/features/staff/presentation/views/tabs/staff_home_tab.dart';
import 'package:check_point/features/staff/presentation/views/tabs/staff_profile_tab.dart';
import 'package:flutter/material.dart';

class StaffNavigation extends StatefulWidget {
  const StaffNavigation({super.key});

  @override
  State<StaffNavigation> createState() => _StaffNavigationState();
}

class _StaffNavigationState extends State<StaffNavigation> {
  ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);
  List<Widget> pages = const [StuffHomeTab(), StuffProfileTab()];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, value, child) {
        return Scaffold(
          body: pages[indexChangeNotifier.value],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              indexChangeNotifier.value = value;
            },
            currentIndex: indexChangeNotifier.value,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
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
