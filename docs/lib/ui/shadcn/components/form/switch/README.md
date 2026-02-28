# Switch (`switch`)

Toggle control for boolean values with themed styling.

---

## When to use

- Use this when:
  - you need a binary on/off control.
- Avoid when:
  - you need multi-state input.

---

## Install

```bash
flutter_shadcn add switch
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/switch/switch.dart';
```

---

## Minimal example

```dart
Switch(
  value: enabled,
  onChanged: (value) {},
)
```

---

## API

### Constructor

- `Switch`
  - `value` (`bool`, required)
  - `onChanged` (`ValueChanged<bool>?`)
  - `enabled` (`bool?`)
- `ControlledSwitch` — controller-backed switch.
- `SwitchController` — controller.

### Callbacks

- `onChanged`

---

## Theming

- `SwitchTheme` controls size, colors, and border radius.

---

## Accessibility

- Use descriptive labels for the on/off state.

---

## Do / Don’t

**Do**
- ✅ Use switches for immediate effects.

**Don’t**
- ❌ Use switches for multi-step workflows.

---

## Related components

- `checkbox`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
