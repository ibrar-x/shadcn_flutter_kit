# Choices (`choices`)

Composite export for multiple choice helpers.

---

## When to use

- Use this when:
  - you need single- or multi-select choice groups.
  - you want a shorthand alias for `MultipleChoice`.
- Avoid when:
  - a radio group or select is a better fit.

---

## Install

```bash
flutter_shadcn add choices
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/form/choices/choices.dart';
```

---

## Minimal example

```dart
Choices<String>(
  value: 'A',
  onChanged: (value) {},
  child: const Text('Provide choice items here'),
)
```

---

## API

### Types

- `Choices<T>` (alias of `MultipleChoice<T>`)
- Re-exports `multiple_choice` APIs.

---

## Theming

- Uses `MultipleChoiceTheme` from the form registry.

---

## Accessibility

- Ensure selectable items have clear labels.

---

## Do / Don’t

**Do**
- ✅ Keep choices short and descriptive.

**Don’t**
- ❌ Use for very large option sets.

---

## Related components

- `multiple_choice`
- `radio_group`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
