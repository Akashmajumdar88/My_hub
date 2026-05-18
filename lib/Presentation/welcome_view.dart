import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../Core/app_styles.dart';
import '../Routes/routes.dart';
import 'Widgets/animated_gradient_bg.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBg(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 20.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0.h),
              
              // Main Screen Heading
              Text(
                "Welcome to MyHub",
                style: AppTextStyles.screenHeading,
              ),
              SizedBox(height: 8.0.h),
              
              // Subheading
              Text(
                "Your personal AI assistant is ready",
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 15.0.sp,
                ),
              ),
              
              const Spacer(flex: 2),
              
              // Interactive Floating Card Graphic Illustration
              const Center(
                child: FloatingCardIllustration(),
              ),
              
              const Spacer(flex: 2),
              
              // Informative Prompt text
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Text(
                    "Get started by choosing a service or ask AI anything",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 15.5.sp,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              
              const Spacer(flex: 1),
              
              // Launch Let's Go Button
              SizedBox(
                width: double.infinity,
                height: 52.0.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the Main Dashboard / Home Screen
                    context.go(AppRoutes.dashboard);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appPrimaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0.r),
                    ),
                  ),
                  child: Text(
                    "Let's Go",
                    style: AppTextStyles.buttonText,
                  ),
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

// Highly stylized central drawing graphic with floating micro-animations
class FloatingCardIllustration extends StatefulWidget {
  const FloatingCardIllustration({super.key});

  @override
  State<FloatingCardIllustration> createState() => _FloatingCardIllustrationState();
}

class _FloatingCardIllustrationState extends State<FloatingCardIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _hoverAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return SizedBox(
          height: 240.0.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Matte Charcoal/Black Card (floating in direction A)
              Transform.translate(
                offset: Offset(-35.0.w, _hoverAnimation.value.h),
                child: Transform.rotate(
                  angle: -0.06,
                  child: Container(
                    width: 140.0.w,
                    height: 180.0.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E24),
                      borderRadius: BorderRadius.circular(20.0.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 15.0.r,
                          offset: Offset(0, 8.0.h),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24.0.w,
                              height: 24.0.h,
                              decoration: const BoxDecoration(
                                color: Colors.white24,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.auto_awesome,
                                size: 14.0.r,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(width: 80.0.w, height: 8.0.h, color: Colors.white24),
                        SizedBox(height: 6.0.h),
                        Container(width: 60.0.w, height: 8.0.h, color: Colors.white24),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Active Blue Card (floating in opposite direction B)
              Transform.translate(
                offset: Offset(35.0.w, -_hoverAnimation.value.h),
                child: Transform.rotate(
                  angle: 0.06,
                  child: Container(
                    width: 145.0.w,
                    height: 185.0.h,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimaryColor,
                      borderRadius: BorderRadius.circular(20.0.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.appPrimaryColor.withOpacity(0.3),
                          blurRadius: 20.0.r,
                          offset: Offset(0, 10.0.h),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 26.0.w,
                              height: 26.0.h,
                              decoration: const BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 14.0.r,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "Ask AI...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.0.h),
                        Container(width: 70.0.w, height: 6.0.h, color: Colors.white60),
                        SizedBox(height: 4.0.h),
                        Container(width: 50.0.w, height: 6.0.h, color: Colors.white60),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
