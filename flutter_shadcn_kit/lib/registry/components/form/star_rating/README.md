# Star Rating (`star_rating`)

Interactive star rating input with theming support.

---

## When to use

- Use this when:
  - you need a simple rating control.
- Avoid when:
  - a numeric input is more appropriate.

---

## Install

```bash
flutter_shadcn add star_rating
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/star_rating/star_rating.dart';
```

---

## Minimal example

```dart
StarRating(
  value: 3.5,
  onChanged: (value) {},
)
```

---

## API

### Constructor

- `StarRating`
  - `value` (`double`, required)
  - `onChanged` (`ValueChanged<double>?`)
  - `step`, `max`, `direction`
  - `activeColor`, `backgroundColor`
  - `starSize`, `starSpacing`, `starPoints`
  - `starPointRounding`, `starValleyRounding`, `starSquash`, `starInnerRadiusRatio`, `starRotation`
- `ControlledStarRating` — controller-backed rating.
- `StarRatingController` — controller.

### Callbacks

- `onChanged`

---

## Theming

- `StarRatingTheme` controls colors, spacing, and sizes.

---

## Accessibility

- Provide text labels for rating values.

---

## Do / Don’t

**Do**
- ✅ Use `step` to control precision.

**Don’t**
- ❌ Allow zero ratings when a rating is required.

---

## Related components

- `slider`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
