import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../Core/app_styles.dart';
import '../Provider/splash_provider.dart';
import '../Routes/routes.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the splash delay provider and navigate to the Intro onboarding flow
    ref.listen(splashProvider, (previous, next) {
      next.whenData((_) {
        context.go(AppRoutes.intro);
      });
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.appPrimaryColor,
              AppColors.appThirdColor,
              AppColors.appSecondaryColor,
            ],
          ),
        ),
        child: Center(
          child: Text(
            "Application",
            style: AppTextStyles.whiteW50030,
          ),
        ),
      ),
    );
  }
}
