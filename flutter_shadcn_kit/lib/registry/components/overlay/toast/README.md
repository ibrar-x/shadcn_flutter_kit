# Toast (`toast`)

Overlay toast notifications with configurable timing.

---

## When to use

- Use this when:
  - you need transient feedback that does not block interaction.
  - you want stacked toasts with consistent styling.
- Avoid when:
  - user input is required (use dialog or inline errors).

---

## Install

```bash
flutter_shadcn add toast
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/toast/toast.dart';
```

---

## Minimal example

```dart
final controller = ToastController();

controller.show(
  context: context,
  builder: (context) => const Text('Saved'),
);
```

---

## API

### Types

- `ToastController`
- `ToastEntry`
- `ToastTheme`

---

## Theming

- `ToastTheme` controls padding, width, background color, and animation curve.

---

## Accessibility

- Keep toast messages short and easy to scan.

---

## Do / Don’t

**Do**
- ✅ Use for non-blocking success or info feedback.

**Don’t**
- ❌ Use for errors that require explicit action.

---

## Related components

- `dialog`
- `error_system`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
