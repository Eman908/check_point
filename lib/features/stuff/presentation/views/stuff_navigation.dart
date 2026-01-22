import 'package:check_point/features/stuff/presentation/views/tabs/stuff_home_tab.dart';
import 'package:check_point/features/stuff/presentation/views/tabs/stuff_profile_tab.dart';
import 'package:flutter/material.dart';

class StuffNavigation extends StatefulWidget {
  const StuffNavigation({super.key});

  @override
  State<StuffNavigation> createState() => _StuffNavigationState();
}

class _StuffNavigationState extends State<StuffNavigation> {
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
