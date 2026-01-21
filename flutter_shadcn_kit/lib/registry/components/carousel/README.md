# Carousel

Interactive carousel with sliding/fading transitions, autoplay, drag control, and dot indicators.

## Usage

```dart
final controller = CarouselController();

Carousel(
  controller: controller,
  itemCount: items.length,
  transition: const CarouselTransition.sliding(gap: 12),
  itemBuilder: (context, index) => items[index],
);
```

### Dot Indicator

```dart
CarouselDotIndicator(
  itemCount: items.length,
  controller: controller,
);
```

Use `ComponentTheme<CarouselTheme>` to adjust alignment, direction, wrap, and autoplay behavior.
