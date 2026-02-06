# App Bar (`app_bar`)

Composite export for AppBar with outline-styled building blocks.

---

## When to use

- Use this when:
  - you want a compact import for app bar + outline button styling.
- Avoid when:
  - you need a fully custom toolbar layout.

---

## Install

```bash
flutter_shadcn add app_bar
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/layout/app_bar/app_bar.dart';
```

---

## Minimal example

```dart
AppBar(
  title: const Text('Title'),
  trailing: [
    OutlineButton(
      onPressed: () {},
      child: const Text('Action'),
    ),
  ],
)
```

---

## API

### Types

- `AppBar`
- `OutlinedContainer`
- `OutlineButton`
- `ButtonDensity`

---

## Theming

- Uses app bar and button theming from the layout/control registries.

---

## Accessibility

- Ensure actionable items are focusable and labeled.

---

## Do / Don’t

**Do**
- ✅ Keep trailing actions concise.

**Don’t**
- ❌ Overload the app bar with too many controls.

---

## Related components

- `scaffold`
- `button`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
