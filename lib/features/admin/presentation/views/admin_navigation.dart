import 'package:flutter/material.dart';

class AdminNavigation extends StatelessWidget {
  const AdminNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("This is ADMIN")),
      bottomNavigationBar: BottomNavigationBar(items: const [
        
      ],),
    );
  }
}
