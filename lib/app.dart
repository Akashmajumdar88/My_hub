import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Routes/routes.dart';

class MyHubApp extends StatelessWidget {
  const MyHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'MyHub',
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.router,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2470B8),
              primary: const Color(0xFF2470B8),
              surface: Colors.white,
            ),
            // Inter is specified in Figma as the main font family
            fontFamily: 'Inter',
          ),
        );
      },
    );
  }
}
