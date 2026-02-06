# Tracker (`tracker`)

Horizontal tracker segments with tooltips.

---

## When to use

- Use this when:
  - you need a compact status timeline or SLA tracker.
  - you want tooltips per segment.
- Avoid when:
  - a full chart or list is required.

---

## Install

```bash
flutter_shadcn add tracker
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/tracker/tracker.dart';
```

---

## Minimal example

```dart
Tracker(
  data: const [
    TrackerData(
      level: TrackerLevel.fine,
      tooltip: Text('All good'),
    ),
  ],
)
```

---

## API

### Constructor

- `Tracker`
  - `data` (`List<TrackerData>`, required)
- `TrackerData`
  - `level` (`TrackerLevel`, required)
  - `tooltip` (`Widget`, required)
- `TrackerLevel` — `fine`, `warning`, `critical`, `unknown`

---

## Theming

- `TrackerTheme` controls radius, gap, and segment height.

---

## Accessibility

- Ensure tooltips provide clear status labels.

---

## Do / Don’t

**Do**
- ✅ Keep segment count small for readability.

**Don’t**
- ❌ Use color alone to convey critical status.

---

## Related components

- `tooltip`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
