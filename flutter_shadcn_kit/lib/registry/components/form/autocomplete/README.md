# Autocomplete (`autocomplete`)

Autocomplete overlay for text inputs with keyboard navigation and theming.

---

## When to use

- Use this when:
  - you need suggestion popovers for text input.
  - you want append/replace behaviors for suggestions.
- Avoid when:
  - you need a full search or command palette (use `command`).

---

## Install

```bash
flutter_shadcn add autocomplete
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/autocomplete/autocomplete.dart';
```

---

## Minimal example

```dart
AutoComplete(
  suggestions: const ['Apple', 'Banana', 'Cherry'],
  child: TextField(),
)
```

---

## Common patterns

### Pattern: Replace word mode

```dart
AutoComplete(
  suggestions: const ['hello_world', 'hello_flutter'],
  mode: AutoCompleteMode.replaceWord,
  child: TextField(),
)
```

---

## API

### Constructor

- `AutoComplete`
  - `suggestions` (`List<String>`, required)
  - `child` (`Widget`, required)
  - `mode` (`AutoCompleteMode?`)
  - `popoverConstraints`, `popoverWidthConstraint`
  - `popoverAnchorAlignment`, `popoverAlignment`
  - `completer` (`AutoCompleteCompleter`)
- `AutoCompleteMode` — `append`, `replaceWord`, `replaceAll`
- `AutoCompleteTheme` — popover sizing and alignment defaults

---

## Theming

- `AutoCompleteTheme` controls popover constraints and alignment.

---

## Accessibility

- Ensure suggestions are readable and keyboard navigable.

---

## Do / Don’t

**Do**
- ✅ Provide concise suggestions.

**Don’t**
- ❌ Trigger the popup for very short queries without filtering.

---

## Related components

- `text_field`
- `input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
