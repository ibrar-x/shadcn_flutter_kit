# Color Utils (`color`)

Helper utilities for converting and transforming colors across RGB/HSV/HSL spaces.

---

## When to use

- Use this when:
  - you need color conversions or gradient utilities.
  - you build color pickers or derived color systems.
- Avoid when:
  - you only need simple `Color` usage.

---

## Install

```bash
flutter_shadcn add color
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/color/color.dart';
```

---

## Minimal example

```dart
final hex = colorToHex(const Color(0xFF3366FF));
```

---

## Common patterns

### Pattern: Derived color edits

```dart
final base = ColorDerivative.fromColor(const Color(0xFF3366FF));
final lighter = base.changeToHSL(base.toHSLColor().withLightness(0.7));
final color = lighter.toColor();
```

---

## API

### Functions

- `colorToHex`

### Types

- `ColorDerivative`
- `ColorGradient`
- `LinearColorGradient`, `RadialColorGradient`, `SweepColorGradient`
- `ColorStop`
- `GradientAngleGeometry`, `GradientAngle`, `DirectionalGradientAngle`

---

## Theming

- No theme hooks; these utilities are pure helpers.

---

## Accessibility

- Use color conversions alongside contrast checks for readable UI.

---

## Do / Don’t

**Do**
- ✅ Keep color conversions in shared utilities.

**Don’t**
- ❌ Recompute gradients on every frame without caching.

---

## Related components

- `color_picker`
- `alpha`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
