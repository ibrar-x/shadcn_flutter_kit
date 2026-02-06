# Progress (`progress`)

Normalized linear progress bar with theme overrides.

---

## When to use

- Use this when:
  - you want a themed linear progress bar.
  - you need to normalize progress between custom min/max values.
- Avoid when:
  - you need a circular indicator.

---

## Install

```bash
flutter_shadcn add progress
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/progress/progress.dart';
```

---

## Minimal example

```dart
Progress(
  progress: 40,
  min: 0,
  max: 100,
)
```

---

## API

### Constructor

- `Progress`
  - `progress` (`double?`)
  - `min` (`double`, default: `0.0`)
  - `max` (`double`, default: `1.0`)
  - `color`, `backgroundColor` (`Color?`)

---

## Theming

- `ProgressTheme` controls color, background, height, and radius.

---

## Accessibility

- Provide a text label when progress value is meaningful.

---

## Do / Don’t

**Do**
- ✅ Keep `progress` within `min` and `max`.

**Don’t**
- ❌ Pass values outside of the min/max range.

---

## Related components

- `linear_progress_indicator`
- `circular_progress_indicator`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
