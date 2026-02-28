# AlertDialog (`alert_dialog`)

Modal alert dialog with customizable header, content, and actions.

---

## When to use

- Use this when:
  - you need a focused confirmation or alert surface.
  - you want a styled modal without wiring overlays manually.
- Avoid when:
  - you need a full-screen dialog or custom route transitions.

---

## Install

```bash
flutter_shadcn add alert_dialog
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/alert_dialog/alert_dialog.dart';
```

---

## Minimal example

```dart
AlertDialog(
  title: const Text('Delete file?'),
  content: const Text('This action cannot be undone.'),
  actions: [
    TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    ),
    TextButton(
      onPressed: _delete,
      child: const Text('Delete'),
    ),
  ],
)
```

---

## API

### Constructor

- `AlertDialog`
  - `leading`, `trailing`
  - `title`, `content`, `actions`
  - `surfaceBlur`, `surfaceOpacity`, `barrierColor`, `padding`

---

## Theming

- Uses `Theme.of(context)` surface tokens (radius, surface blur/opacity, colors).

---

## Accessibility

- Provide clear titles and actionable button labels.

---

## Do / Don’t

**Do**
- ✅ Keep dialog content concise and scannable.

**Don’t**
- ❌ Nest multiple modals or alerts.

---

## Related components

- `dialog`
- `drawer`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
