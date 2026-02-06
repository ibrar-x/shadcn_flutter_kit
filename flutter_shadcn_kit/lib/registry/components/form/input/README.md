# Input (`input`)

Single-line text input with feature hooks, popovers, and controller integration.

---

## When to use

- Use this when:
  - you want shared input features (clear, password toggle, hints, etc.).
  - you need autocomplete feature hooks.
- Avoid when:
  - you only need a plain `TextField` without features.

---

## Install

```bash
flutter_shadcn add input
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/input/input.dart';
```

---

## Minimal example

```dart
TextField(
  features: const [InputFeature.clear()],
)
```

---

## Common patterns

### Pattern: Autocomplete feature

```dart
TextField(
  features: [
    InputFeature.autoComplete(
      querySuggestions: (query) async => ['one', 'two'],
      child: const SizedBox.shrink(),
    ),
  ],
)
```

---

## API

### Constructor

- `InputFeaturePosition` — `leading` / `trailing`.
- `SuggestionBuilder` — `FutureOr<Iterable<String>> Function(String query)`.
- Feature widgets:
  - `InputClearFeature`, `InputPasswordToggleFeature`, `InputHintFeature`
  - `InputAutoCompleteFeature`, `InputSpinnerFeature`
  - `InputCopyFeature`, `InputPasteFeature`, `InputRevalidateFeature`
  - `InputLeadingFeature`, `InputTrailingFeature`

---

## Theming

- Feature icons/styles follow the `TextFieldTheme`.

---

## Accessibility

- Ensure feature icons have tooltips or labels.

---

## Do / Don’t

**Do**
- ✅ Use `InputFeatureVisibility` to avoid clutter.

**Don’t**
- ❌ Overload inputs with too many trailing actions.

---

## Related components

- `text_field`
- `autocomplete`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
