import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color appPrimaryColor = Color(0xFF2470B8);     // Active Blue
  static const Color appSecondaryColor = Color(0xFF9BC5FF);   // Soft Light Blue
  static const Color appThirdColor = Color(0xFFA6BBFF);       // Soft Purple-Blue
  static const Color bgColor = Color(0xFFFFFFFF);             // Pure White
  static const Color textPrimary = Color(0xFF000000);         // Heading Black
  static const Color textSecondary = Color(0xFF424242);       // Subheading/Body grey
  static const Color textLight = Color(0xFF8E8E93);           // Light grey details
  static const Color disabledColor = Color(0xFFD5E6FF);       // Disabled Button Blue
  static const Color borderGrey = Color(0xFFE0E0E0);          // Input Border Grey
  static const Color fillGrey = Color(0xFFF7F9FC);            // Text field fill
}

class AppTextStyles {
  // Screen 1 Hero Heading
  static TextStyle get heroTitle => TextStyle(
    fontSize: 45.0.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.15,
    letterSpacing: -1.0,
  );

  // Screens 2-5 Heading
  static TextStyle get screenHeading => TextStyle(
    fontSize: 34.0.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.5,
  );

  // Splash Screen white title
  static TextStyle get whiteW50030 => TextStyle(
    fontSize: 30.0.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // Feature List items (Screen 1)
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 24.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // Form input values and text field labels
  static TextStyle get bodyMedium => TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // Form field placeholders/hints
  static TextStyle get placeholder => TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );

  // Button labels
  static TextStyle get buttonText => TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: 0.2,
  );

  // Helper texts, labels, and small footnotes
  static TextStyle get caption => TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get linkText => TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.appPrimaryColor,
  );
}
