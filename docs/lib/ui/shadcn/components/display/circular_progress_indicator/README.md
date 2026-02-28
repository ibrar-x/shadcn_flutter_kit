# Circular Progress Indicator (`circular_progress_indicator`)

Determinate/indeterminate spinner with theme overrides and optional animation.

---

## When to use

- Use this when:
  - you need an inline or centered progress indicator.
  - you want determinate or indeterminate progress.
- Avoid when:
  - a linear progress bar is more appropriate.

---

## Install

```bash
flutter_shadcn add circular_progress_indicator
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/circular_progress_indicator/circular_progress_indicator.dart';
```

---

## Minimal example

```dart
CircularProgressIndicator(
  value: 0.6,
)
```

---

## Common patterns

### Pattern: Indeterminate

```dart
const CircularProgressIndicator()
```

---

## API

### Constructor

- `CircularProgressIndicator`
  - `value` (`double?`) — null for indeterminate.
  - `size` (`double?`)
  - `color`, `backgroundColor` (`Color?`)
  - `strokeWidth` (`double?`)
  - `duration` (`Duration`)
  - `animated` (`bool`)
  - `onSurface` (`bool`)

---

## Theming

- `CircularProgressIndicatorTheme` controls size, color, stroke, and background.

---

## Accessibility

- Pair with text labels when used as a status indicator.

---

## Do / Don’t

**Do**
- ✅ Use determinate mode for known progress.

**Don’t**
- ❌ Animate excessively in dense lists.

---

## Related components

- `linear_progress_indicator`
- `progress`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
