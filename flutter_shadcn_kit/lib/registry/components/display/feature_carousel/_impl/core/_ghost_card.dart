part of '../../feature_carousel.dart';

class _GhostCard extends StatelessWidget {
  const _GhostCard({
    required this.cardWidth,
    required this.cardHeight,
    required this.theme,
    required this.animation,
    required this.indexFromFront,
  });

  final double cardWidth;
  final double cardHeight;
  final FeatureCarouselThemeData theme;
  final Animation<double> animation;
  final int indexFromFront;

  @override
  Widget build(BuildContext context) {
    final transform = _ghostTransform(indexFromFront);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final t = theme.transitionCurve.transform(animation.value);
        final opacityShift = (indexFromFront * 0.04) * (0.5 - t);
        return Opacity(
          opacity: (transform.opacity + opacityShift).clamp(0, 1),
          child: Transform.translate(
            offset: Offset(transform.dx, transform.dy),
            child: Transform.rotate(
              angle: transform.rotation,
              child: Transform.scale(scale: transform.scale, child: child),
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: theme.ghostFillColor,
          borderRadius: BorderRadius.circular(theme.ghostRadius),
          border: Border.all(color: theme.ghostBorderColor, width: 1),
        ),
      ),
    );
  }

  _GhostTransform _ghostTransform(int index) {
    switch (index) {
      case 1:
        return const _GhostTransform(
          dx: -28,
          dy: 6,
          rotation: -6 * math.pi / 180,
          scale: 0.98,
          opacity: 0.55,
        );
      case 2:
        return const _GhostTransform(
          dx: 22,
          dy: 10,
          rotation: 6 * math.pi / 180,
          scale: 0.96,
          opacity: 0.40,
        );
      default:
        return const _GhostTransform(
          dx: 0,
          dy: 14,
          rotation: 0,
          scale: 0.94,
          opacity: 0.28,
        );
    }
  }
}
