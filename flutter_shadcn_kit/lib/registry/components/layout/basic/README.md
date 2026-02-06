# Basic (`basic`)

Flexible row layout for leading/title/content/trailing sections.

---

## When to use

- Use this when:
  - you need a consistent row layout with title/subtitle/content.
- Avoid when:
  - a plain `Row` is simpler.

---

## Install

```bash
flutter_shadcn add basic
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/basic/basic.dart';
```

---

## Minimal example

```dart
Basic(
  leading: const Icon(Icons.person),
  title: const Text('Jane Doe'),
  subtitle: const Text('Product Designer'),
)
```

---

## API

### Constructor

- `Basic` — styled layout with title/subtitle/content.
- `BasicLayout` — layout without text styling.
- `Label` — label row with leading/trailing widgets.
- `BasicTheme` — alignment, spacing, and padding defaults.

---

## Theming

- `BasicTheme` controls alignment, spacing, and padding.

---

## Accessibility

- Ensure titles and subtitles are readable and concise.

---

## Do / Don’t

**Do**
- ✅ Use `BasicLayout` when you need custom text styles.

**Don’t**
- ❌ Overload the row with too many widgets.

---

## Related components

- `card`
- `alert`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
