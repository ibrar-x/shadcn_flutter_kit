# Carousel (`carousel`)

Interactive carousel with sliding/fading transitions and autoplay controls.

---

## When to use

- Use this when:
  - you need a swipeable carousel with autoplay.
  - you want custom transitions and dot indicators.
- Avoid when:
  - a simple `PageView` is enough.

---

## Install

```bash
flutter_shadcn add carousel
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/carousel/carousel.dart';
```

---

## Minimal example

```dart
Carousel(
  itemCount: 5,
  transition: const SlidingCarouselTransition(),
  itemBuilder: (context, index) => Text('Slide $index'),
)
```

---

## Common patterns

### Pattern: Controller-driven navigation

```dart
final controller = CarouselController();

Carousel(
  controller: controller,
  itemCount: 3,
  transition: const FadingCarouselTransition(),
  itemBuilder: (context, index) => Text('Card $index'),
)
```

### Pattern: Dot indicator

```dart
CarouselDotIndicator(
  controller: controller,
  itemCount: 3,
)
```

---

## API

### Constructor

- `Carousel`
  - `itemBuilder` (`Widget Function(BuildContext, int)`, required)
  - `transition` (`CarouselTransition`, required)
  - `itemCount` (`int?`)
  - `controller` (`CarouselController?`)
  - `autoplaySpeed` / `pauseOnHover` / `wrap` / `draggable`
- `CarouselController` — imperative control for index and animation.
- `SlidingCarouselTransition`, `FadingCarouselTransition` — built-in transitions.
- `CarouselDotIndicator` — indicator that follows a controller.

### Callbacks

- `onIndexChanged` (Carousel)

---

## Theming

- `CarouselTheme` provides theme defaults for spacing and indicators.

---

## Accessibility

- Provide meaningful labels for slides.
- Ensure focusable content within each item.

---

## Do / Don’t

**Do**
- ✅ Provide `itemCount` when `wrap` is `false`.

**Don’t**
- ❌ Autoplay content users must read for long durations without a pause option.

---

## Related components

- `dot_indicator`
- `feature_carousel`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
