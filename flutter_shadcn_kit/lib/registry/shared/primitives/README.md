# Primitives (`shared/primitives`)

Foundational widgets and overlay primitives shared across components.

---

## When to use

- Use this when:
  - a component needs a shared primitive like overlay, hover, or outlined container.
- Avoid when:
  - the logic is specific to a single component.

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/shared/primitives/overlay.dart';
```

---

## Contents (selected)

- `animated_value_builder.dart`
- `basic.dart`
- `clickable.dart`
- `fade_scroll.dart`
- `focus_outline.dart`
- `form_control.dart`
- `form_value_supplier.dart`
- `hidden.dart`
- `hover.dart`
- `icon_extensions.dart`
- `menu_group.dart`
- `outlined_container.dart`
- `overlay.dart` / `popover.dart`
- `phone_number.dart`
- `sheet_overlay.dart`
- `slider_value.dart`
- `subfocus.dart`
- `text.dart`

---

## Notes

- Many components re-export these primitives; import directly only when needed.

---

## Related modules

- `shared/theme`
- `shared/utils`
