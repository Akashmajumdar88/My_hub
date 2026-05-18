import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Presentation/intro_view.dart';
import '../Presentation/signin_view.dart';
import '../Presentation/otp_view.dart';
import '../Presentation/profile_view.dart';
import '../Presentation/welcome_view.dart';
import '../Presentation/dashboard_view.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  // Route Paths
  static const String intro = "/";
  static const String signin = "/signin";
  static const String otp = "/otp";
  static const String profile = "/profile";
  static const String welcome = "/welcome";
  static const String dashboard = "/dashboard";

  // GoRouter Setup
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: intro,
    routes: [
      GoRoute(
        path: intro,
        name: 'intro',
        pageBuilder: (context, state) =>
            _buildFadeTransition(context, state, const IntroView()),
      ),
      GoRoute(
        path: signin,
        name: 'signin',
        pageBuilder: (context, state) =>
            _buildFadeTransition(context, state, const SignInView()),
      ),
      GoRoute(
        path: otp,
        name: 'otp',
        pageBuilder: (context, state) =>
            _buildFadeTransition(context, state, const OtpView()),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        pageBuilder: (context, state) =>
            _buildFadeTransition(context, state, const ProfileView()),
      ),
      GoRoute(
        path: welcome,
        name: 'welcome',
        pageBuilder: (context, state) =>
            _buildFadeTransition(context, state, const WelcomeView()),
      ),
      GoRoute(
        path: dashboard,
        name: 'dashboard',
        pageBuilder: (context, state) =>
            _buildFadeTransition(context, state, const DashboardView()),
      ),
    ],
  );

  // Smooth Fade Transition builder for premium UI/UX
  static CustomTransitionPage _buildFadeTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}