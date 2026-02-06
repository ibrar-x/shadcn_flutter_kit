# Sheet (`sheet`)

Composite export for sheet workflows built on drawer + form.

---

## When to use

- Use this when:
  - you need a sheet-style overlay that hosts forms.
  - you want a single import for sheet + form helpers.
- Avoid when:
  - a dialog or popover is a better fit.

---

## Install

```bash
flutter_shadcn add sheet
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/overlay/sheet/sheet.dart';
```

---

## Minimal example

```dart
await openSheet(
  context: context,
  position: OverlayPosition.bottom,
  builder: (context) => Form(
    controller: FormController(),
    child: const Text('Sheet content'),
  ),
)
```

---

## API

### Types and helpers

- `openSheet`
- `closeSheet`
- `OverlayPosition` (from `drawer`)
- `AlertDialog`
- `PrimaryButton`, `TextButton`
- `Form`, `FormController`, `FormField<T>`, `FormTableLayout`, `FormErrorBuilder`

---

## Theming

- Uses drawer and form theming from the registry.

---

## Accessibility

- Provide clear close actions and focus management.

---

## Do / Don’t

**Do**
- ✅ Keep sheet content short and task-focused.

**Don’t**
- ❌ Use for long, scrolling detail pages.

---

## Related components

- `drawer`
- `form`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
