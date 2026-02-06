# Chip Input (`chip_input`)

Inline text input that converts typed tokens into chip widgets with removable buttons and autocomplete hooks.

---

## When to use

- Use this when:
  - you need tag or recipient inputs.
  - you want chips embedded inside a text field.
- Avoid when:
  - a simple multi-select list is enough.

---

## Install

```bash
flutter_shadcn add chip_input
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/chip_input/chip_input.dart';
```

---

## Minimal example

```dart
ChipInput<String>(
  chipBuilder: (context, chip) => Chip(child: Text(chip)),
  onChipSubmitted: (text) => text.isEmpty ? null : text,
)
```

---

## Common patterns

### Pattern: Initial chips

```dart
ChipInput<String>(
  initialChips: const ['Design', 'Flutter'],
  chipBuilder: (context, chip) => Chip(child: Text(chip)),
  onChipSubmitted: (text) => text,
)
```

---

## API

### Constructor

- `ChipInput<T>`
  - `chipBuilder` (`ChipWidgetBuilder<T>`, required)
  - `onChipSubmitted` (`ChipSubmissionCallback<T>`, required)
  - `onChipsChanged` (`ValueChanged<List<T>>?`)
  - `initialChips` (`List<T>?`)
  - `useChips` (`bool?`)
  - `autoInsertSuggestion` (`bool`)
- `ChipEditingController<T>` — controller for chip text and values.

### Callbacks

- `onChipsChanged`

---

## Theming

- `ChipInputTheme` controls spacing, chip styling, and text field defaults.

---

## Accessibility

- Ensure chips are keyboard focusable if they are removable.

---

## Do / Don’t

**Do**
- ✅ Validate tokens in `onChipSubmitted`.

**Don’t**
- ❌ Accept empty tokens as chips.

---

## Related components

- `chip`
- `text_field`
- `autocomplete`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
