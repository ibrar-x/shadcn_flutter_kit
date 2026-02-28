# Selectable Text (`selectable`)

Selectable text with themed cursor and selection behavior.

---

## When to use

- Use this when:
  - you need selectable, copyable text.
  - you want theming control for cursor and selection.
- Avoid when:
  - the text should be editable (use `TextField`).

---

## Install

```bash
flutter_shadcn add selectable
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/selectable/selectable.dart';
```

---

## Minimal example

```dart
const SelectableText('Copy this text')
```

---

## Common patterns

### Pattern: Rich text

```dart
SelectableText.rich(
  const TextSpan(
    children: [
      TextSpan(text: 'Bold ', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: 'and normal'),
    ],
  ),
)
```

---

## API

### Constructor

- `SelectableText`
  - `data` (`String`, required)
  - `style`, `textAlign`, `textDirection`, `textScaler`
  - `cursorWidth`, `cursorHeight`, `cursorRadius`, `cursorColor`
  - `selectionHeightStyle`, `selectionWidthStyle`
  - `enableInteractiveSelection`, `useNativeContextMenu`
- `SelectableText.rich`
  - `textSpan` (`TextSpan`, required)

### Callbacks

- `onTap`
- `onSelectionChanged`

---

## Theming

- `SelectableTextTheme` controls cursor sizing and selection visuals.

---

## Accessibility

- Keep text selectable only when it adds value to users.

---

## Do / Don’t

**Do**
- ✅ Use `SelectableText.rich` for mixed styles.

**Don’t**
- ❌ Disable selection for content users may need to copy.

---

## Related components

- `text`
- `form/text_field`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
