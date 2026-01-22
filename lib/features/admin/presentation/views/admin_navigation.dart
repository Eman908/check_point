import 'package:check_point/features/admin/presentation/views/tabs/home_tab.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab.dart';
import 'package:check_point/features/admin/presentation/views/tabs/stuff_tab.dart';
import 'package:flutter/material.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  ValueNotifier<int> indexChangeNotifier = ValueNotifier<int>(0);
  List<Widget> pages = const [HomeTab(), StuffTab(), ProfileTab()];

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
                    onPressed: () {},
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
              BottomNavigationBarItem(icon: Icon(Icons.people), label: "Stuff"),
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
