import 'package:flutter/material.dart';

class SummaryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final ValueChanged<bool> onVisibilityChanged;

  SummaryHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    required this.onVisibilityChanged,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = (shrinkOffset / maxExtent).clamp(0.0, 1.0);
    final isVisible = progress < 0.2;
    onVisibilityChanged(isVisible);

    return ClipRect(
      child: Transform.translate(
        offset: Offset(0, -progress * 40), // slide up
        child: Transform.scale(
          scale: 1 - progress * 0.08, // shrink
          alignment: Alignment.topCenter,
          child: Opacity(
            opacity: 1 - progress, // fade out
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
