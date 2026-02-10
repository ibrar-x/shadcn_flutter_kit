part of '../../feature_carousel.dart';

class _NavArrow extends StatelessWidget {
  const _NavArrow({
    required this.direction,
    required this.size,
    required this.radius,
    required this.background,
    required this.iconColor,
    required this.pressed,
    required this.hovered,
    required this.onPressed,
    required this.onPressedChanged,
    required this.onHoverChanged,
  });

  final _CarouselDirection direction;
  final double size;
  final double radius;
  final Color background;
  final Color iconColor;
  final bool pressed;
  final bool hovered;
  final VoidCallback onPressed;
  final ValueChanged<bool> onPressedChanged;
  final ValueChanged<bool> onHoverChanged;

  @override
  Widget build(BuildContext context) {
    final icon = direction == _CarouselDirection.left
        ? Icons.chevron_left
        : Icons.chevron_right;

    return Semantics(
      button: true,
      label: direction == _CarouselDirection.left ? 'Previous' : 'Next',
      child: MouseRegion(
        onEnter: (_) => onHoverChanged(true),
        onExit: (_) => onHoverChanged(false),
        child: GestureDetector(
          onTap: onPressed,
          onTapDown: (_) => onPressedChanged(true),
          onTapUp: (_) => onPressedChanged(false),
          onTapCancel: () => onPressedChanged(false),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 90),
            scale: pressed ? 0.96 : 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: hovered
                    ? background.withValues(alpha: 0.16)
                    : background,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Icon(
                icon,
                color: hovered ? iconColor.withValues(alpha: 0.75) : iconColor,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
