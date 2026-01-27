part of '../../feature_carousel.dart';

class FeatureCardCarousel extends StatefulWidget {
  const FeatureCardCarousel({
    super.key,
    required this.items,
    this.height,
    this.width,
    this.controller,
    this.theme,
    this.cardBuilder,
    this.titleBuilder,
    this.descriptionBuilder,
    this.ctaBuilder,
    this.backgroundBuilder,
  });

  final List<FeatureCarouselItem> items;
  final double? height;
  final double? width;
  final FeatureCarouselController? controller;
  final FeatureCarouselThemeData? theme;
  final Widget Function(
    BuildContext context,
    FeatureCarouselItem item,
    int index,
    FeatureCarouselThemeData theme,
  )? cardBuilder;
  final Widget Function(
    BuildContext context,
    FeatureCarouselItem item,
    int index,
  )? titleBuilder;
  final Widget Function(
    BuildContext context,
    FeatureCarouselItem item,
    int index,
  )? descriptionBuilder;
  final Widget Function(
    BuildContext context,
    FeatureCarouselItem item,
    int index,
    VoidCallback onAction,
  )? ctaBuilder;
  final Widget Function(
    BuildContext context,
    FeatureCarouselThemeData theme,
  )? backgroundBuilder;

  @override
  State<FeatureCardCarousel> createState() => _FeatureCardCarouselState();
}
