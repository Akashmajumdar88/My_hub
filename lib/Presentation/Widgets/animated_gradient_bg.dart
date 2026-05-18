import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedGradientBg extends StatefulWidget {
  final Widget child;

  const AnimatedGradientBg({super.key, required this.child});

  @override
  State<AnimatedGradientBg> createState() => _AnimatedGradientBgState();
}

class _AnimatedGradientBgState extends State<AnimatedGradientBg>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;

  @override
  void initState() {
    super.initState();
    // Long continuous animation for subtle, premium micro-movement
    _controller = AnimationController(
      duration: const Duration(seconds: 18),
      vsync: this,
    )..repeat(reverse: true);

    _xAnimation = Tween<double>(begin: -40.0, end: 120.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _yAnimation = Tween<double>(begin: -80.0, end: 80.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Base white-blue vertical linear gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFF4F8FD),
                  Color(0xFFEDF4FC),
                ],
              ),
            ),
          ),
          
          // Glowing Blur Orb 1 (Top-Right / Center)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                right: -60 + _xAnimation.value,
                top: -100 + _yAnimation.value,
                child: Container(
                  width: 440,
                  height: 440,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF9BC5FF).withOpacity(0.55),
                        const Color(0xFFA6BBFF).withOpacity(0.40),
                        const Color(0xFFD5E6FF).withOpacity(0.15),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),

          // Glowing Blur Orb 2 (Left / Lower Center)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                left: -120 - _xAnimation.value * 0.4,
                top: 80 + _yAnimation.value * 0.7,
                child: Container(
                  width: 360,
                  height: 360,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFD5E6FF).withOpacity(0.45),
                        const Color(0xFFA6BBFF).withOpacity(0.20),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),

          // High-performance blur overlay to blend the orbs smoothly
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 65.0, sigmaY: 65.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),

          // Front-facing content with safe area spacing
          SafeArea(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
