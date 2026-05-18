import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../Core/app_styles.dart';
import '../Routes/routes.dart';
import 'Widgets/animated_gradient_bg.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> with SingleTickerProviderStateMixin {
  late AnimationController _transitionController;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _buttonWidthAnimation;
  late Animation<double> _buttonTextOpacityAnimation;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    // Text elements will fade out quickly at the beginning
    _textOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );

    // Button text will fade out quickly
    _buttonTextOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
      ),
    );

    // Button width collapses in a beautiful ease-out cubic curve
    _buttonWidthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.15, 0.8, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _transitionController.dispose();
    super.dispose();
  }

  void _startTransition() {
    if (_isNavigating) return;
    setState(() {
      _isNavigating = true;
    });

    _transitionController.forward().then((_) {
      if (mounted) {
        context.push(AppRoutes.signin).then((_) {
          if (mounted) {
            // Reset the animation state when returning from the Sign In view
            setState(() {
              _isNavigating = false;
            });
            _transitionController.reset();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBg(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 3),
              
              // Animated Title: "Experience the Next Gen"
              AnimatedBuilder(
                animation: _transitionController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textOpacityAnimation.value,
                    child: child,
                  );
                },
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 30.h * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    "Experience\nthe Next Gen",
                    style: AppTextStyles.heroTitle,
                  ),
                ),
              ),
              
              SizedBox(height: 10.0.h),
              
              // Animated Sub-elements Stack
              AnimatedBuilder(
                animation: _transitionController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textOpacityAnimation.value,
                    child: child,
                  );
                },
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 40.h * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Search smarter",
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 4.0.h),
                      Text(
                        "Order faster",
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 4.0.h),
                      Text(
                        "Book anything with AI",
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 40.h),
              
              // Animated "Let's Go" Button that morphs on click
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (context, entryValue, child) {
                  return Transform.translate(
                    offset: Offset(0, 20.h * (1 - entryValue)),
                    child: Opacity(
                      opacity: entryValue,
                      child: child,
                    ),
                  );
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth;
                    return AnimatedBuilder(
                      animation: _transitionController,
                      builder: (context, child) {
                        // Smoothly interpolate between maxWidth and 52.0 (circle dot)
                        final currentWidth = Tween<double>(
                          begin: maxWidth,
                          end: 52.0.h,
                        ).transform(_buttonWidthAnimation.value);

                        return Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: currentWidth,
                            height: 52.0.h,
                            child: ElevatedButton(
                              onPressed: _isNavigating ? null : _startTransition,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appPrimaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0.r),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: _buttonWidthAnimation.value > 0.6
                                  ? const SizedBox.shrink()
                                  : Opacity(
                                      opacity: _buttonTextOpacityAnimation.value,
                                      child: Text(
                                        "Let's Go",
                                        style: AppTextStyles.buttonText,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 12.0.h),
            ],
          ),
        ),
      ),
    );
  }
}
