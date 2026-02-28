# Radio Group (`radio_group`)

Exclusive selection group with radio items and cards.

---

## When to use

- Use this when:
  - you need single-choice selection.
  - you want radio cards or list items.
- Avoid when:
  - multiple selections are allowed (use `multiple_choice`).

---

## Install

```bash
flutter_shadcn add radio_group
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/radio_group/radio_group.dart';
```

---

## Minimal example

```dart
RadioGroup<String>(
  value: selected,
  onChanged: (value) {},
  child: const Column(
    children: [
      RadioItem(value: 'A', child: Text('Option A')),
      RadioItem(value: 'B', child: Text('Option B')),
    ],
  ),
)
```

---

## API

### Constructor

- `RadioGroup<T>`
  - `value` (`T?`)
  - `onChanged` (`ValueChanged<T>?`)
  - `enabled` (`bool?`)
- `RadioItem<T>` — standard radio row.
- `RadioCard<T>` — card-style radio option.
- `ControlledRadioGroup<T>` — controller-backed group.
- `RadioGroupController<T>` — controller.

### Callbacks

- `onChanged`

---

## Theming

- `RadioTheme` and `RadioCardTheme` control sizes, spacing, and colors.

---

## Accessibility

- Ensure each item has a readable label.

---

## Do / Don’t

**Do**
- ✅ Group related options in a single `RadioGroup`.

**Don’t**
- ❌ Use multiple groups for a single decision.

---

## Related components

- `multiple_choice`
- `checkbox`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
