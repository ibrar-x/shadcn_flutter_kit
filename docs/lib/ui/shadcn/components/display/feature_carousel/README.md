# Feature Carousel

Animated feature card carousel with optional autoplay, swipe, and CTA support.

## Usage

```dart
final items = [
  FeatureCarouselItem(
    title: 'Add a Color Palette Selector',
    description: 'Allow users to pick specific palettes to refine generation.',
    icon: Icons.auto_awesome_rounded,
    accentColor: const Color(0xFF7EA3FF),
  ),
];

FeatureCardCarousel(
  items: items,
  controller: FeatureCarouselController(
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 4),
  ),
);
```

## Notes

- Use `FeatureCarouselController` to control autoplay, swipe, and CTA behavior.
- Provide a `FeatureCarouselThemeData` to customize colors, spacing, and motion.
