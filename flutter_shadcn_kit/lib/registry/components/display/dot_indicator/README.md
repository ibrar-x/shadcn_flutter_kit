# Dot Indicator (`dot_indicator`)

Animated dot indicator for carousels/steppers with optional tap behavior.

---

## When to use

- Use this when:
  - you need a compact pager indicator.
  - you want clickable dot navigation.
- Avoid when:
  - text labels are required for navigation.

---

## Install

```bash
flutter_shadcn add dot_indicator
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/dot_indicator/dot_indicator.dart';
```

---

## Minimal example

```dart
DotIndicator(
  index: 0,
  length: 5,
)
```

---

## Common patterns

### Pattern: Clickable dots

```dart
DotIndicator(
  index: currentIndex,
  length: 5,
  onChanged: (next) => setState(() => currentIndex = next),
)
```

---

## API

### Constructor

- `DotIndicator`
  - `index` (`int`, required)
  - `length` (`int`, required)
  - `onChanged` (`ValueChanged<int>?`)
  - `direction` (`Axis`)
  - `spacing` (`double?`)
  - `padding` (`EdgeInsetsGeometry?`)
  - `dotBuilder` (`DotBuilder?`)

### Callbacks

- `onChanged`

---

## Theming

- `DotIndicatorTheme` controls spacing, padding, and default dot builder.

---

## Accessibility

- Provide additional labels when dots represent critical steps.

---

## Do / Don’t

**Do**
- ✅ Keep `length` in sync with content pages.

**Don’t**
- ❌ Use dots as the only navigation for long lists.

---

## Related components

- `carousel`
- `stepper`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
