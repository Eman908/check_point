import 'package:check_point/core/utils/app_routes.dart';
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "CheckPoint",
                  style: TextStyle(
                    color: Color(0xffB20000),
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                  ),
                ),
                Icon(
                  Icons.location_on_outlined,
                  weight: 2,
                  color: Colors.blueAccent,
                  size: 28,
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
      duration: const Duration(seconds: 2),
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
