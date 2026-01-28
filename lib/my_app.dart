import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/utils/app_routes.dart';
import 'package:check_point/core/utils/app_theme.dart';
import 'package:check_point/features/admin/presentation/views/tabs/home_tab/cubit/shift_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/profile_tab/cubit/profile_cubit.dart';
import 'package:check_point/features/admin/presentation/views/tabs/staff_tab/cubit/staff_cubit.dart';
import 'package:check_point/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckPoint extends StatelessWidget {
  const CheckPoint({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthCubit>()),
        BlocProvider.value(value: getIt<ProfileCubit>()),
        BlocProvider.value(value: getIt<StaffCubit>()),
        BlocProvider.value(value: getIt<ShiftCubit>()),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
