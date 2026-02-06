part of '../../feature_carousel.dart';

class _CtaButton extends StatelessWidget {
  const _CtaButton({
    required this.label,
    required this.theme,
    required this.pressed,
    required this.onPressed,
    required this.onPressedChanged,
  });

  final String label;
  final FeatureCarouselThemeData theme;
  final bool pressed;
  final VoidCallback onPressed;
  final ValueChanged<bool> onPressedChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onPressed,
        onTapDown: (_) => onPressedChanged(true),
        onTapUp: (_) => onPressedChanged(false),
        onTapCancel: () => onPressedChanged(false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 90),
          scale: pressed ? 0.98 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            height: theme.ctaHeight,
            constraints: BoxConstraints(minWidth: theme.ctaMinWidth),
            padding: EdgeInsets.symmetric(horizontal: theme.ctaHorizontalPadding),
            decoration: BoxDecoration(
              color: theme.ctaBackground,
              borderRadius: BorderRadius.circular(theme.ctaHeight / 2),
              border: Border.all(color: theme.ctaBorderColor, width: 1),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.ctaTextColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
