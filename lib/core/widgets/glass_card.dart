import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blurSigma;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = 20,
    this.blurSigma = 12,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.07)
            : Colors.white.withValues(alpha: 0.6));
    final border = borderColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.8));

    final card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: border, width: 1),
            ),
            child: child,
          ),
        ),
      ),
    );

    if (margin != null) {
      return Padding(padding: margin!, child: card);
    }
    return card;
  }
}
