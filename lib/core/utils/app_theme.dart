import 'package:check_point/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.kRed,
      onPrimary: AppColors.kWhite,
      secondary: AppColors.kRed,
      onSecondary: AppColors.kWhite,
      error: AppColors.kRed,
      onError: AppColors.kWhite,
      surface: AppColors.kWhite,
      onSurface: AppColors.kBlack,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.kBlack),
      titleMedium: TextStyle(color: AppColors.kBlack),
      titleSmall: TextStyle(color: AppColors.kBlack),
      bodyLarge: TextStyle(color: AppColors.kBlack),
      bodyMedium: TextStyle(color: AppColors.kBlack),
      bodySmall: TextStyle(color: AppColors.kBlack),
      labelLarge: TextStyle(color: AppColors.kBlack),
      labelMedium: TextStyle(color: AppColors.kBlack),
      labelSmall: TextStyle(color: AppColors.kBlack),
    ),
  );
}
