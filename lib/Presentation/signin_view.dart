import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../Core/app_styles.dart';
import '../Routes/routes.dart';
import 'Widgets/animated_gradient_bg.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validateInput);
  }

  void _validateInput() {
    final text = _phoneController.text.trim();
    // Validate that there is a reasonable phone number length (at least 10 digits)
    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');
    setState(() {
      _isButtonEnabled = digitsOnly.length >= 10;
    });
  }

  // Simulator helper: Quick pre-fill when tapping the field container
  void _quickFill() {
    if (_phoneController.text.isEmpty) {
      _phoneController.text = "+91 63008 81234";
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBg(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 950),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            // Stagger 1: Back Button (Interval 0.0 to 0.4)
            final backVal = Curves.easeOut.transform(
              (value / 0.4).clamp(0.0, 1.0),
            );
            
            // Stagger 2: Title and Subtitle (Interval 0.1 to 0.7)
            final titleVal = Curves.easeOutCubic.transform(
              ((value - 0.1) / 0.6).clamp(0.0, 1.0),
            );
            
            // Stagger 3: Input Field & Tips (Interval 0.2 to 0.8)
            final inputVal = Curves.easeOutCubic.transform(
              ((value - 0.2) / 0.6).clamp(0.0, 1.0),
            );
            
            // Stagger 4: Continue Button & Footer (Interval 0.3 to 0.9)
            final buttonVal = Curves.easeOutCubic.transform(
              ((value - 0.3) / 0.6).clamp(0.0, 1.0),
            );

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.0.h),

                    // Main Screen Heading
                    Opacity(
                      opacity: titleVal,
                      child: Transform.translate(
                        offset: Offset(0, 20.0.h * (1 - titleVal)),
                        child: Text(
                          "Sign in to continue",
                          style: AppTextStyles.screenHeading,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0.h),

                    // Secondary Subheading
                    Opacity(
                      opacity: titleVal,
                      child: Transform.translate(
                        offset: Offset(0, 20.0.h * (1 - titleVal)),
                        child: Text(
                          "Enter your mobile number to proceed",
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 15.0.sp,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 48.0.h),

                    // Labeled Input container
                    Opacity(
                      opacity: inputVal,
                      child: Transform.translate(
                        offset: Offset(0, 25.0.h * (1 - inputVal)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mobile Number",
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 8.0.h),

                            // Mobile Number Text Input Field
                            GestureDetector(
                              onTap: _quickFill,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.fillGrey,
                                  borderRadius: BorderRadius.circular(12.0.r),
                                  border: Border.all(
                                    color: AppColors.borderGrey,
                                    width: 1.0.w,
                                  ),
                                ),
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontSize: 17.0.sp,
                                    letterSpacing: 0.5.w,
                                  ),
                                  onTap: _quickFill,
                                  decoration: InputDecoration(
                                    hintText: "e.g. +91 9012XXXXXX",
                                    hintStyle: AppTextStyles.placeholder,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0.w,
                                      vertical: 16.0.h,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 12.0.h),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30.0.h),

                    // Continue Button & Footer
                    Opacity(
                      opacity: buttonVal,
                      child: Transform.translate(
                        offset: Offset(0, 20.0.h * (1 - buttonVal)),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 52.0.h,
                              child: ElevatedButton(
                                onPressed: _isButtonEnabled
                                    ? () {
                                        context.push(AppRoutes.otp);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appPrimaryColor,
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: AppColors.disabledColor,
                                  disabledForegroundColor: Colors.white.withOpacity(0.8),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0.r),
                                  ),
                                ),
                                child: Text(
                                  "Continue",
                                  style: AppTextStyles.buttonText,
                                ),
                              ),
                            ),

                            SizedBox(height: 32.0.h),
                            // Security / Private note in footer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  size: 16.0.r,
                                  color: AppColors.textLight,
                                ),
                                SizedBox(width: 8.0.w),
                                Expanded(
                                  child: Text(
                                    "Your number stays private and is never shared",
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textLight,
                                      fontSize: 12.5.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
