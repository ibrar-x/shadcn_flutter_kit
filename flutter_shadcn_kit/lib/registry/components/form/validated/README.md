# Validated (`validated`)

Validation wrapper that exposes form error state.

---

## When to use

- Use this when:
  - you want custom validation UI around a widget.
- Avoid when:
  - standard `FormField` error rendering is enough.

---

## Install

```bash
flutter_shadcn add validated
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/validated/validated.dart';
```

---

## Minimal example

```dart
Validated<String>(
  validator: (value) => value == null || value.isEmpty
      ? ValidationResult.error('Required')
      : null,
  builder: (context, error, child) {
    return Column(
      children: [
        child!,
        if (error != null) Text(error.message),
      ],
    );
  },
  child: const TextField(),
)
```

---

## API

### Constructor

- `Validated<T>`
  - `validator` (`Validator<T>`, required)
  - `builder` (`ValidatedBuilder`, required)
  - `child` (`Widget?`)

---

## Theming

- No direct theme dependencies; style inside `builder`.

---

## Accessibility

- Ensure error messages are announced and visible.

---

## Do / Don’t

**Do**
- ✅ Provide consistent error layouts.

**Don’t**
- ❌ Swallow validation errors silently.

---

## Related components

- `form`
- `form_field`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
