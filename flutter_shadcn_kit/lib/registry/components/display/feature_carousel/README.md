# Feature Carousel (`feature_carousel`)

Animated feature card carousel with autoplay, swipe, and CTA support. (WIP)

---

## When to use

- Use this when:
  - you want a hero-style feature carousel with CTA.
  - you need autoplay and keyboard navigation built in.
- Avoid when:
  - a simple slider or list is sufficient.

---

## Install

```bash
flutter_shadcn add feature_carousel
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/feature_carousel/feature_carousel.dart';
```

---

## Minimal example

```dart
FeatureCardCarousel(
  items: const [
    FeatureCarouselItem(title: 'Fast', description: 'Quick setup'),
    FeatureCarouselItem(title: 'Flexible', description: 'Composable APIs'),
  ],
)
```

---

## Common patterns

### Pattern: Controller settings

```dart
final controller = FeatureCarouselController(
  autoPlay: true,
  showCta: true,
  primaryActionLabel: 'Get started',
);

FeatureCardCarousel(
  controller: controller,
  items: const [
    FeatureCarouselItem(title: 'Secure'),
  ],
)
```

---

## API

### Constructor

- `FeatureCardCarousel`
  - `items` (`List<FeatureCarouselItem>`, required)
  - `controller` (`FeatureCarouselController?`)
  - `height`, `width` (`double?`)
  - `theme` (`FeatureCarouselThemeData?`)
  - `cardBuilder`, `titleBuilder`, `descriptionBuilder`, `ctaBuilder`, `backgroundBuilder`
- `FeatureCarouselItem`
  - `title`, `description` (`String?`)
  - `icon` (`IconData?`)
  - `iconBuilder` (`FeatureCarouselIconBuilder?`)
  - `accentColor` (`Color?`)
- `FeatureCarouselController` — autoplay, navigation, CTA configuration.
- `FeatureCarouselAnimationStyle` — animation styles for transitions.

### Callbacks

- `onPrimaryAction` (FeatureCarouselController)
- `onIndexChanged` (FeatureCarouselController)

---

## Theming

- `FeatureCarouselThemeData` controls colors, spacing, and card styling.

---

## Accessibility

- Provide clear text labels for CTA buttons.
- Ensure the carousel is keyboard navigable when enabled.

---

## Do / Don’t

**Do**
- ✅ Provide short, scannable titles and descriptions.

**Don’t**
- ❌ Autoplay content without a way to pause if it contains critical info.

---

## Related components

- `carousel`
- `button`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
