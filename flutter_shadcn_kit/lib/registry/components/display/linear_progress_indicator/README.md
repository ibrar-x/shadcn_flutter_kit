# Linear Progress Indicator (`linear_progress_indicator`)

Determinate/indeterminate progress bar with optional spark effects and theming.

---

## When to use

- Use this when:
  - you need a linear progress display.
  - you want determinate or indeterminate modes with theming.
- Avoid when:
  - you need a circular indicator.

---

## Install

```bash
flutter_shadcn add linear_progress_indicator
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/linear_progress_indicator/linear_progress_indicator.dart';
```

---

## Minimal example

```dart
LinearProgressIndicator(
  value: 0.4,
)
```

---

## Common patterns

### Pattern: Indeterminate

```dart
const LinearProgressIndicator()
```

### Pattern: Sparks

```dart
LinearProgressIndicator(
  value: 0.8,
  showSparks: true,
)
```

---

## API

### Constructor

- `LinearProgressIndicator`
  - `value` (`double?`) — null for indeterminate.
  - `color`, `backgroundColor` (`Color?`)
  - `minHeight` (`double?`)
  - `borderRadius` (`BorderRadiusGeometry?`)
  - `showSparks` (`bool?`)
  - `disableAnimation` (`bool?`)

---

## Theming

- `LinearProgressIndicatorTheme` controls colors, height, radius, and sparks.

---

## Accessibility

- Use accompanying text or labels for status.

---

## Do / Don’t

**Do**
- ✅ Use determinate mode when progress is known.

**Don’t**
- ❌ Keep indeterminate indicators running without feedback.

---

## Related components

- `circular_progress_indicator`
- `progress`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
