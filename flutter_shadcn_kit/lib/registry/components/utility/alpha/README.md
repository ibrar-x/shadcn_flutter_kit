# Alpha (`alpha`)

Checkerboard painter for transparency indicators.

---

## When to use

- Use this when:
  - you need a background to visualize alpha in color pickers.
- Avoid when:
  - transparency is not part of the UI.

---

## Install

```bash
flutter_shadcn add alpha
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/alpha/alpha.dart';
```

---

## Minimal example

```dart
CustomPaint(
  painter: AlphaPainter(),
  size: const Size(120, 40),
)
```

---

## API

### Painter

- `AlphaPainter`
  - `checkboardPrimary`, `checkboardSecondary`, `checkboardSize`

---

## Theming

- Uses fixed colors; wrap with `ColorFiltered` if you need custom tints.

---

## Accessibility

- Pair alpha patterns with numeric opacity labels for clarity.

---

## Do / Don’t

**Do**
- ✅ Use behind translucent previews.

**Don’t**
- ❌ Use as a general background texture.

---

## Related components

- `color_picker`
- `color`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
