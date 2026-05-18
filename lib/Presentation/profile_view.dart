import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../Core/app_styles.dart';
import '../Routes/routes.dart';
import 'Widgets/animated_gradient_bg.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _selectedGender;
  bool _isButtonEnabled = false;

  final List<String> _genders = ["Male", "Female", "Other"];

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_validateInputs);
    _lastNameController.addListener(_validateInputs);
  }

  void _validateInputs() {
    final first = _firstNameController.text.trim();
    final last = _lastNameController.text.trim();
    setState(() {
      _isButtonEnabled = first.isNotEmpty && last.isNotEmpty && _selectedGender != null;
    });
  }

  // Simulator helper: Quick pre-fill when tapping the helper chip
  void _quickFillProfile() {
    setState(() {
      _firstNameController.text = "Molleti";
      _lastNameController.text = "Chaitanya";
      _selectedGender = "Male";
      _validateInputs();
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
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
                SizedBox(height: 16.0.h),

                // Main Screen Heading
                Text(
                  "Tell us about you",
                  style: AppTextStyles.screenHeading,
                ),
                SizedBox(height: 8.0.h),

                // Secondary Subheading
                Text(
                  "Just a few details to set up your profile",
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 15.0.sp,
                  ),
                ),

                SizedBox(height: 36.0.h),

                // Input 1: First Name
                Text(
                  "First Name",
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 8.0.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.fillGrey,
                    borderRadius: BorderRadius.circular(12.0.r),
                    border: Border.all(
                      color: AppColors.borderGrey,
                      width: 1.0.w,
                    ),
                  ),
                  child: TextField(
                    controller: _firstNameController,
                    style: AppTextStyles.bodyMedium.copyWith(fontSize: 16.0.sp),
                    decoration: InputDecoration(
                      hintText: "Enter your first name",
                      hintStyle: AppTextStyles.placeholder,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0.w,
                        vertical: 16.0.h,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(height: 20.0.h),

                // Input 2: Last Name
                Text(
                  "Last Name",
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 8.0.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.fillGrey,
                    borderRadius: BorderRadius.circular(12.0.r),
                    border: Border.all(
                      color: AppColors.borderGrey,
                      width: 1.0.w,
                    ),
                  ),
                  child: TextField(
                    controller: _lastNameController,
                    style: AppTextStyles.bodyMedium.copyWith(fontSize: 16.0.sp),
                    decoration: InputDecoration(
                      hintText: "Enter your last name",
                      hintStyle: AppTextStyles.placeholder,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0.w,
                        vertical: 16.0.h,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(height: 20.0.h),

                // Input 3: Gender Dropdown
                Text(
                  "Gender",
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 8.0.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 2.0.h),
                  decoration: BoxDecoration(
                    color: AppColors.fillGrey,
                    borderRadius: BorderRadius.circular(12.0.r),
                    border: Border.all(
                      color: AppColors.borderGrey,
                      width: 1.0.w,
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedGender,
                    hint: Text(
                      "Select Gender",
                      style: AppTextStyles.placeholder,
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textLight,
                      size: 24.0.r,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: AppTextStyles.bodyMedium.copyWith(fontSize: 16.0.sp),
                    items: _genders.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGender = newValue;
                        _validateInputs();
                      });
                    },
                  ),
                ),

                SizedBox(height: 36.0.h),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 52.0.h,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled
                        ? () {
                            context.push(AppRoutes.welcome);
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

                SizedBox(height: 28.0.h),

                // Terms and Privacy Footer
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "By continuing, you agree to our ",
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12.5.sp,
                          color: AppColors.textLight,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Terms of Use",
                          style: AppTextStyles.linkText.copyWith(
                            fontSize: 12.5.sp,
                          ),
                        ),
                      ),
                      Text(
                        " & ",
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12.5.sp,
                          color: AppColors.textLight,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Privacy Policy",
                          style: AppTextStyles.linkText.copyWith(
                            fontSize: 12.5.sp,
                          ),
                        ),
                      ),
                    ],
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
