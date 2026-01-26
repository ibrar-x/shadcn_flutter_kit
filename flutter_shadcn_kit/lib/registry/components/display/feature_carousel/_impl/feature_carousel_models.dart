import 'package:flutter/material.dart';

typedef FeatureCarouselIconBuilder = Widget Function(
  BuildContext context,
  Color accentColor,
  double size,
);

class FeatureCarouselItem {
  final String? title;
  final String? description;
  final IconData? icon;
  final FeatureCarouselIconBuilder? iconBuilder;
  final Color? accentColor;

  const FeatureCarouselItem({
    this.title,
    this.description,
    this.icon,
    this.iconBuilder,
    this.accentColor,
  });
}
