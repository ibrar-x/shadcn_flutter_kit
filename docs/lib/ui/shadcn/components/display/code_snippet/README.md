# Code Snippet (`code_snippet`)

Stylized code container with action slot and theme overrides.

---

## When to use

- Use this when:
  - you want a styled code block with optional actions.
  - you need consistent padding and borders for code display.
- Avoid when:
  - plain `Text` with monospaced style is sufficient.

---

## Install

```bash
flutter_shadcn add code_snippet
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/code_snippet/code_snippet.dart';
```

---

## Minimal example

```dart
CodeSnippet(
  code: const Text('flutter run'),
)
```

---

## Common patterns

### Pattern: Action buttons

```dart
CodeSnippet(
  actions: [
    IconButton.primary(icon: const Icon(Icons.copy), onPressed: () {}),
  ],
  code: const Text('dart format .'),
)
```

---

## API

### Constructor

- `CodeSnippet`
  - `code` (`Widget`, required)
  - `actions` (`List<Widget>`)
  - `constraints` (`BoxConstraints?`)

---

## Theming

- `CodeSnippetTheme` controls background, border, radius, and padding.

---

## Accessibility

- Use readable font sizes for code text.
- Provide labels for action icons.

---

## Do / Don’t

**Do**
- ✅ Keep code lines short for readability.

**Don’t**
- ❌ Place large, scroll-heavy code blocks without constraints.

---

## Related components

- `text`
- `button`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
