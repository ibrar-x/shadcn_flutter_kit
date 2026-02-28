# Text Field (`text_field`)

Text input with rich features, autocomplete, and actions.

---

## When to use

- Use this when:
  - you need a highly configurable text input.
  - you want input features like clear, copy, paste, hints, and autocomplete.
- Avoid when:
  - a simple `Text` widget is sufficient.

---

## Install

```bash
flutter_shadcn add text_field
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/text_field/text_field.dart';
```

---

## Minimal example

```dart
const TextField()
```

---

## Common patterns

### Pattern: Feature icons

```dart
TextField(
  features: const [
    InputFeature.clear(),
    InputFeature.passwordToggle(),
  ],
)
```

---

## API

### Constructor

- `TextField` — main input widget.
- `TextInputStatefulWidget` — shared base for inputs with features.
- `InputFeature` factories — `clear`, `copy`, `paste`, `hint`, `passwordToggle`, `autoComplete`, `spinner`, `revalidate`.
- `InputFeatureVisibility` — `always`, `focused`, `textNotEmpty`, etc.
- `PasswordPeekMode` — `toggle` or `peek`.

---

## Theming

- `TextFieldTheme` controls borders, padding, and typography.
- `AutoCompleteTheme` controls suggestions popover.

---

## Accessibility

- Ensure labels and hints are provided for screen readers.

---

## Do / Don’t

**Do**
- ✅ Use `InputFeatureVisibility` to reduce visual noise.

**Don’t**
- ❌ Add too many trailing features in narrow layouts.

---

## Related components

- `input`
- `autocomplete`
- `formatted_input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
