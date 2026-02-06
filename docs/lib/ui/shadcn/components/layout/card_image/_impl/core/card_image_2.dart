part of '../../card_image.dart';

class CardImage extends StatefulWidget {
  final Widget image;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onPressed;
  final bool? enabled;
  final AbstractButtonStyle? style;
  final Axis? direction;
  final double? hoverScale;
  final double? normalScale;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? gap;

  const CardImage({
    super.key,
    required this.image,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onPressed,
    this.enabled,
    this.style,
    this.direction,
    this.hoverScale,
    this.normalScale,
    this.backgroundColor,
    this.borderColor,
    this.gap,
  });

  @override
  State<CardImage> createState() => _CardImageState();
}
