# Checkbox (`checkbox`)

Animated checkbox with tri-state support and controllers.

---

## When to use

- Use this when:
  - you need boolean or tri-state input.
  - you want custom theming and animations.
- Avoid when:
  - you need radio-style single selection (use `radio_group`).

---

## Install

```bash
flutter_shadcn add checkbox
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/checkbox/checkbox.dart';
```

---

## Minimal example

```dart
Checkbox(
  state: CheckboxState.unchecked,
  onChanged: (next) {},
)
```

---

## Common patterns

### Pattern: Tri-state

```dart
Checkbox(
  state: CheckboxState.indeterminate,
  tristate: true,
  onChanged: (next) {},
)
```

---

## API

### Constructor

- `Checkbox`
  - `state` (`CheckboxState`, required)
  - `onChanged` (`ValueChanged<CheckboxState>?`)
  - `tristate` (`bool`)
  - `leading`, `trailing` (`Widget?`)
  - `size`, `gap`, `backgroundColor`, `activeColor`, `borderColor`, `borderRadius`
- `ControlledCheckbox` — controller-backed checkbox.
- `CheckboxController` — `ValueNotifier<CheckboxState>` controller.
- `CheckboxState` — `checked`, `unchecked`, `indeterminate`.

### Callbacks

- `onChanged`

---

## Theming

- `CheckboxTheme` controls size, colors, border, and animation settings.

---

## Accessibility

- Provide labels with `leading`/`trailing` text widgets.

---

## Do / Don’t

**Do**
- ✅ Use `tristate` when indeterminate state is meaningful.

**Don’t**
- ❌ Hide validation errors for required checkboxes.

---

## Related components

- `form`
- `radio_group`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
