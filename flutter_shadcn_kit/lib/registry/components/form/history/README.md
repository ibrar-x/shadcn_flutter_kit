# Color History (`history`)

Grid + storage helpers that track recently used colors for reuse.

---

## When to use

- Use this when:
  - you need a shared color history across pickers.
- Avoid when:
  - history isn’t relevant for the workflow.

---

## Install

```bash
flutter_shadcn add history
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/history/history.dart';
```

---

## Minimal example

```dart
RecentColorsScope(
  child: Builder(
    builder: (context) {
      final storage = ColorHistoryStorage.of(context);
      return ColorHistoryGrid(storage: storage);
    },
  ),
)
```

---

## API

### Constructor

- `ColorHistoryGrid`
  - `storage` (`ColorHistoryStorage`, required)
  - `onColorPicked` (`ValueChanged<Color>?`)
  - `crossAxisCount`, `spacing`, `selectedColor`, `maxTotalColors`
- `RecentColorsScope`
  - `initialRecentColors`, `maxRecentColors`, `onRecentColorsChanged`
- `ColorHistoryStorage` — storage interface for recent colors.

---

## Theming

- Uses shared theme colors for selection borders.

---

## Accessibility

- Provide labels for selected colors where possible.

---

## Do / Don’t

**Do**
- ✅ Use `RecentColorsScope` at the app or feature level.

**Don’t**
- ❌ Store large color histories without limits.

---

## Related components

- `color_picker`
- `color_input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
