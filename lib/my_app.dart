import 'package:check_point/core/utils/app_routes.dart';
import 'package:check_point/core/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CheckPoint extends StatelessWidget {
  const CheckPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      routerConfig: AppRoutes.router,
    );
  }
}
