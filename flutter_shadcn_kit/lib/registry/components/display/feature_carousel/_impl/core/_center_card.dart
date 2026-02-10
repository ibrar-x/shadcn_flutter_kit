part of '../../feature_carousel.dart';

class _CenterCard extends StatelessWidget {
  const _CenterCard({
    super.key,
    required this.item,
    required this.width,
    required this.height,
    required this.theme,
  });

  final FeatureCarouselItem item;
  final double width;
  final double height;
  final FeatureCarouselThemeData theme;

  @override
  Widget build(BuildContext context) {
    final accent = item.accentColor ?? theme.accentColor;
    final iconSize = width * 0.28;
    final iconWidget = item.iconBuilder != null
        ? item.iconBuilder!(context, accent, iconSize)
        : (item.icon != null
              ? Icon(item.icon, size: iconSize, color: accent)
              : const SizedBox.shrink());

    return Semantics(
      label: 'Feature preview: ${item.title ?? 'item'}',
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.cardFillColor,
          borderRadius: BorderRadius.circular(theme.cardRadius),
          border: Border.all(color: theme.cardBorderColor, width: 1.2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x8C000000),
              blurRadius: 28,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: iconSize + 12,
                height: iconSize + 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 18,
                    ),
                  ],
                ),
              ),
              iconWidget,
            ],
          ),
        ),
      ),
    );
  }
}
