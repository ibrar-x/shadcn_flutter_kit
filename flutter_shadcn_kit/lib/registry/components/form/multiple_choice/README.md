# Multiple Choice (`multiple_choice`)

Choice widgets with single or multiple selection and form integration.

---

## When to use

- Use this when:
  - you need single-select or multi-select options.
  - you want form-aware selection state.
- Avoid when:
  - a dropdown is a better UX for long lists.

---

## Install

```bash
flutter_shadcn add multiple_choice
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/multiple_choice/multiple_choice.dart';
```

---

## Minimal example

```dart
MultipleChoice<String>(
  value: selected,
  onChanged: (value) {},
  child: Wrap(
    children: const [
      Choice(value: 'A', child: Text('A')),
      Choice(value: 'B', child: Text('B')),
    ],
  ),
)
```

---

## API

### Constructor

- `MultipleChoice<T>` — single selection.
- `MultipleAnswer<T>` — multiple selection.
- `Choice<T>` — selectable child widget.
- `ControlledMultipleChoice<T>` / `ControlledMultipleAnswer<T>` — controller-backed.
- `MultipleChoiceController<T>` / `MultipleAnswerController<T>` — controllers.

### Callbacks

- `onChanged`

---

## Theming

- `MultipleChoiceTheme` controls spacing and selection styles.

---

## Accessibility

- Provide clear selected states for keyboard navigation.

---

## Do / Don’t

**Do**
- ✅ Use `allowUnselect` for optional choices.

**Don’t**
- ❌ Mix single and multiple choice in the same group.

---

## Related components

- `radio_group`
- `chip_input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
