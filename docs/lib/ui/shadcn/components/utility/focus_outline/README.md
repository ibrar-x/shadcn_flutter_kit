# Focus Outline (`focus_outline`)

Keyboard focus visualization outline with theming support.

---

## When to use

- Use this when:
  - you need a consistent focus ring around custom widgets.
- Avoid when:
  - default focus styles already meet your requirements.

---

## Install

```bash
flutter_shadcn add focus_outline
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/focus_outline/focus_outline.dart';
```

---

## Minimal example

```dart
FocusOutline(
  focused: isFocused,
  child: const Text('Focusable'),
)
```

---

## API

### Widget

- `FocusOutline`

### Theme

- `FocusOutlineTheme`

---

## Theming

- `FocusOutlineTheme` controls align offsets and border styling.

---

## Accessibility

- Keep focus rings visible for keyboard users.

---

## Do / Don’t

**Do**
- ✅ Use focus outlines on custom interactive widgets.

**Don’t**
- ❌ Hide focus rings without providing alternatives.

---

## Related components

- `subfocus`
- `hover`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
