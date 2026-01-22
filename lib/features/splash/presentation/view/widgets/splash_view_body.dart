import 'package:check_point/core/utils/app_routes.dart';
import 'package:check_point/core/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    initAnimation();
    navigateTransition();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return SlideTransition(
            position: animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  weight: 2,
                  color: context.color.primary,
                  size: 28,
                ),
                Text(
                  "CheckPoint",
                  style: context.textTheme.titleLarge!.copyWith(
                    color: context.color.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Attendance, Verified",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = Tween<Offset>(
      begin: const Offset(0, 10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    animationController.forward();
  }

  void navigateTransition() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        context.go(AppRoutes.kLoginView);
      }
    });
  }
}
