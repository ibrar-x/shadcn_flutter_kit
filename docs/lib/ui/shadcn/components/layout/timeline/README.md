# Timeline (`timeline`)

Vertical timeline for chronological entries.

---

## When to use

- Use this when:
  - you need a chronological list with visual markers.
- Avoid when:
  - a simple list is enough.

---

## Install

```bash
flutter_shadcn add timeline
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/timeline/timeline.dart';
```

---

## Minimal example

```dart
Timeline(
  data: const [
    TimelineData(time: Text('09:00'), title: Text('Start')),
  ],
)
```

---

## API

### Constructor

- `Timeline`
  - `data` (`List<TimelineData>`, required)
  - `timeConstraints`, `spacing`, `dotSize`, `connectorThickness`, `rowGap`
- `TimelineData` — `time`, `title`, `content`, `color`.
- `TimelineTheme` — theme defaults.

---

## Theming

- `TimelineTheme` controls spacing, dot size, and connector styling.

---

## Accessibility

- Ensure time labels are readable.

---

## Do / Don’t

**Do**
- ✅ Use consistent time formats.

**Don’t**
- ❌ Use timeline for unordered events.

---

## Related components

- `steps`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
