import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../Core/app_styles.dart';
import '../Routes/routes.dart';
import 'Widgets/animated_gradient_bg.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  static const int _otpLength = 6;
  final List<TextEditingController> _controllers = List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(_otpLength, (_) => FocusNode());
  
  bool _isVerifyEnabled = false;
  
  // Timer State for resend OTP
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    for (int i = 0; i < _otpLength; i++) {
      _controllers[i].addListener(_onOtpChanged);
    }
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 30;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
          _timer?.cancel();
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _onOtpChanged() {
    int filledCount = 0;
    for (var controller in _controllers) {
      if (controller.text.isNotEmpty) filledCount++;
    }
    setState(() {
      _isVerifyEnabled = filledCount == _otpLength;
    });
  }

  // Pre-fill helper to simulate the prototype pre-fill click
  void _quickFillOtp() {
    const sampleOtp = "640325";
    for (int i = 0; i < _otpLength; i++) {
      _controllers[i].text = sampleOtp[i];
    }
    // Set focus to the last node
    _focusNodes[_otpLength - 1].requestFocus();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBg(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.0.h),

                // Header Text
                Text(
                  "Verify your number",
                  style: AppTextStyles.screenHeading,
                ),
                SizedBox(height: 8.0.h),

                // Subtitle previewing user phone details
                Text(
                  "We've sent a 6-digit code to +91 **** 1234",
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 15.0.sp,
                  ),
                ),

                SizedBox(height: 48.0.h),

                // Labeled Section
                Text(
                  "Enter 6-digit code",
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 12.0.h),

                // 6 Responsive Square Boxes in a Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(_otpLength, (index) {
                    return SizedBox(
                      width: 48.0.w,
                      height: 52.0.h,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.fillGrey,
                          borderRadius: BorderRadius.circular(10.0.r),
                          border: Border.all(
                            color: _focusNodes[index].hasFocus
                                ? AppColors.appPrimaryColor
                                : AppColors.borderGrey,
                            width: _focusNodes[index].hasFocus ? 1.8.w : 1.0.w,
                          ),
                        ),
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              // Move to next box
                              if (index < _otpLength - 1) {
                                _focusNodes[index + 1].requestFocus();
                              } else {
                                _focusNodes[index].unfocus();
                              }
                            } else {
                              // Backspace clicked and empty: move backward
                              if (index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 12.0.h),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Text(
                    "Enter the code you received via SMS",
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),

                SizedBox(height: 16.0.h),

                SizedBox(height: 40.0.h),

                // Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 52.0.h,
                  child: ElevatedButton(
                    onPressed: _isVerifyEnabled
                        ? () {
                            context.push(AppRoutes.profile);
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
                      "Verify",
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),

                SizedBox(height: 32.0.h),

                // Resend OTP Countdown timer in Footer
                Center(
                  child: _canResend
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't get the code? ",
                              style: AppTextStyles.caption,
                            ),
                            GestureDetector(
                              onTap: _startTimer,
                              child: Text(
                                "Resend OTP",
                                style: AppTextStyles.linkText,
                              ),
                            ),
                          ],
                        )
                      : RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTextStyles.caption,
                            children: [
                              const TextSpan(text: "Didn't get the code? "),
                              TextSpan(
                                text: "Resend OTP",
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textLight,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: " (after ${_secondsRemaining}s)",
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
