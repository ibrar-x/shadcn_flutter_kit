# Subfocus (`subfocus`)

Hierarchical focus scope for keyboard navigation.

---

## When to use

- Use this when:
  - you need custom keyboard focus traversal in complex lists/menus.
- Avoid when:
  - default `FocusScope` is sufficient.

---

## Install

```bash
flutter_shadcn add subfocus
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/subfocus/subfocus.dart';
```

---

## Minimal example

```dart
SubFocusScope(
  autofocus: true,
  builder: (context, state) {
    return Column(
      children: const [
        SubFocus(child: Text('Item 1')),
        SubFocus(child: Text('Item 2')),
      ],
    );
  },
)
```

---

## API

### Constructor

- `SubFocusScope`
  - `builder` (`SubFocusScopeBuilder?`)
  - `autofocus` (`bool`)
- `SubFocus` — focusable child widget.
- `SubFocusScopeState` — focus management interface.

---

## Theming

- No theme dependencies.

---

## Accessibility

- Ensure focus states are visually clear.

---

## Do / Don’t

**Do**
- ✅ Use for keyboard-driven lists or menus.

**Don’t**
- ❌ Nest multiple scopes without clear traversal behavior.

---

## Related components

- `tree`
- `menu`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
