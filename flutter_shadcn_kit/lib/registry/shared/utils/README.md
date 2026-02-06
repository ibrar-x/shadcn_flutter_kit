# Utils (`shared/utils`)

Utility helpers shared across components (layout, animation, geometry, input).

---

## When to use

- Use this when:
  - you need shared helpers for layout, animation, or styling logic.
- Avoid when:
  - a helper is only used by a single component.

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/shared/utils/util.dart';
```

---

## Contents (selected)

- `util.dart` — core utilities, callbacks, repeated animation builder.
- `constants.dart` — shared durations and constants.
- `style_value.dart` — theme + widget value resolution helpers.
- `geometry_extensions.dart`, `color_extensions.dart`, `tween_utils.dart`
- `keyboard_shortcut_utils.dart`, `text_input_utils.dart`
- `resizer.dart`, `resizable_item.dart`, `wrap_utils.dart`

---

## Related modules

- `shared/primitives`
- `shared/theme`
