import 'package:check_point/core/utils/app_routes.dart';
import 'package:flutter/material.dart';

class CheckPoint extends StatelessWidget {
  const CheckPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    );
  }
}
