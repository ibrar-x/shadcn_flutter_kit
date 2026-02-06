# Toggle (`toggle`)

Composite export for Toggle and ToggleController.

---

## When to use

- Use this when:
  - you want a lightweight toggle built on the button component.
  - you need a shared toggle controller API.
- Avoid when:
  - a checkbox or switch is a better semantic fit.

---

## Install

```bash
flutter_shadcn add toggle
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/control/toggle/toggle.dart';
```

---

## Minimal example

```dart
Toggle(
  value: true,
  onChanged: (value) {},
  child: const Text('Notifications'),
)
```

---

## API

### Types

- `Toggle`
- `ToggleController`

---

## Theming

- Inherits button theming from the control registry.

---

## Accessibility

- Provide clear labels for on/off state.

---

## Do / Don’t

**Do**
- ✅ Use for binary settings.

**Don’t**
- ❌ Use without visible labels.

---

## Related components

- `button`
- `switch`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
