# Alert (`alert`)

Flexible alert panels with destructive/resilient styling.

---

## When to use

- Use this when:
  - you need inline status or warning blocks.
- Avoid when:
  - a toast or dialog is more appropriate.

---

## Install

```bash
flutter_shadcn add alert
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/alert/alert.dart';
```

---

## Minimal example

```dart
const Alert(
  title: Text('Heads up'),
  content: Text('Something needs your attention.'),
)
```

---

## API

### Constructor

- `Alert`
  - `leading`, `title`, `content`, `trailing`
  - `destructive` (`bool`)
- `Alert.destructive` — destructive styling shortcut.
- `AlertTheme` — padding and surface defaults.

---

## Theming

- `AlertTheme` controls padding, background, and border color.

---

## Accessibility

- Use clear titles and content for screen readers.

---

## Do / Don’t

**Do**
- ✅ Use destructive styling for critical warnings.

**Don’t**
- ❌ Overuse alerts for minor messages.

---

## Related components

- `toast`
- `dialog`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
