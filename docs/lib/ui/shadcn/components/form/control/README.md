# Control (`control`)

Controller mixins and helpers for form components.

---

## When to use

- Use this when:
  - you need controller-backed form components.
  - you want a consistent controlled/uncontrolled pattern.
- Avoid when:
  - you only need local `setState` without controllers.

---

## Install

```bash
flutter_shadcn add control
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/control/control.dart';
```

---

## Minimal example

```dart
final controller = ComponentValueController<bool>(false);

ControlledComponentAdapter<bool>(
  controller: controller,
  builder: (context, data) {
    return Switch(
      value: data.value,
      onChanged: data.enabled ? data.onChanged : null,
    );
  },
)
```

---

## API

### Constructor

- `ControlledComponentAdapter<T>` — binds a value to UI with controlled/uncontrolled modes.
- `ComponentValueController<T>` — `ValueNotifier`-based controller.
- `ControlledComponentData<T>` — value + onChanged + enabled container.
- `ComponentController<T>` — mixin interface for controllers.
- `ControlledComponent<T>` — mixin for widgets with controller support.

---

## Theming

- No direct theme dependencies.

---

## Accessibility

- Ensure adapters forward `enabled` state to child controls.

---

## Do / Don’t

**Do**
- ✅ Use controllers for cross-field coordination.

**Don’t**
- ❌ Mutate controller values without notifying listeners.

---

## Related components

- `form`
- `validated`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
