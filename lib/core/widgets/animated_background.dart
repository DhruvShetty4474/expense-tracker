import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late final AnimationController _c1;
  late final AnimationController _c2;
  late final AnimationController _c3;

  @override
  void initState() {
    super.initState();
    _c1 = AnimationController(vsync: this, duration: const Duration(seconds: 9))
      ..repeat(reverse: true);
    _c2 = AnimationController(vsync: this, duration: const Duration(seconds: 13))
      ..repeat(reverse: true);
    _c3 = AnimationController(vsync: this, duration: const Duration(seconds: 17))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c1.dispose();
    _c2.dispose();
    _c3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.sizeOf(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: AppColors.amoledBackground),
        AnimatedBuilder(
          animation: _c1,
          builder: (_, __) => Positioned(
            top: -120 + 80 * _c1.value,
            left: -80 + 50 * _c1.value,
            child: _Blob(size: s.width * 0.8, color: AppColors.accentPurple.withValues(alpha: 0.25)),
          ),
        ),
        AnimatedBuilder(
          animation: _c2,
          builder: (_, __) => Positioned(
            bottom: -100 + 70 * _c2.value,
            right: -60 + 40 * (1 - _c2.value),
            child: _Blob(size: s.width * 0.7, color: AppColors.accentCyan.withValues(alpha: 0.15)),
          ),
        ),
        AnimatedBuilder(
          animation: _c3,
          builder: (_, __) => Positioned(
            top: s.height * 0.35 + 60 * sin(_c3.value * pi),
            left: s.width * 0.15 + 30 * _c3.value,
            child: _Blob(size: s.width * 0.5, color: AppColors.accentPurple.withValues(alpha: 0.09)),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  final double size;
  final Color color;
  const _Blob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, Colors.transparent]),
        ),
      );
}
