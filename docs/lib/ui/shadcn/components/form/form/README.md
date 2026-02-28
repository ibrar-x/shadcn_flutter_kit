# Form (`form`)

Composable form state, validation, and submit helpers.

---

## When to use

- Use this when:
  - you need centralized form validation and submission.
  - you want reusable validators and error builders.
- Avoid when:
  - a single input doesn’t require validation.

---

## Install

```bash
flutter_shadcn add form
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/form/form.dart';
```

---

## Minimal example

```dart
final key = FormKey<String>('email');

Form(
  controller: FormController(),
  child: FormField(
    key: key,
    label: const Text('Email'),
    child: TextField(),
  ),
)
```

---

## Common patterns

### Pattern: Submit button

```dart
SubmitButton(
  child: const Text('Submit'),
  loading: const Text('Validating...'),
  error: const Text('Fix errors'),
)
```

---

## API

### Constructor

- `Form` — root form container.
- `FormController` — manages values, validation, and submission.
- `FormKey<T>` — typed keys for form fields.
- `FormEntry<T>` — attaches validation to an input.
- `FormField<T>` — labeled field wrapper with errors.
- `FormInline<T>` — inline label+field layout.
- `SubmitButton` — submit button with validation state.
- `Validator<T>` and `ValidationResult` — validation helpers.

### Callbacks

- `onSubmitted` (Form)
- `onChanged` (FormEntry/FormField)

---

## Theming

- Uses shared text and focus outline themes for error states.

---

## Accessibility

- Ensure error messages are visible and announced by screen readers.

---

## Do / Don’t

**Do**
- ✅ Use `FormKey<T>` for typed value access.

**Don’t**
- ❌ Mix multiple form controllers in the same subtree.

---

## Related components

- `form_field`
- `validated`
- `text_field`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
