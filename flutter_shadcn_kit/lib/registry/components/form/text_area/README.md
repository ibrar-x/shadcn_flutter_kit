# Text Area (`text_area`)

Resizable multi-line text input built on text field primitives.

---

## When to use

- Use this when:
  - you need multi-line input with optional resizing.
- Avoid when:
  - a single-line input is enough.

---

## Install

```bash
flutter_shadcn add text_area
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/text_area/text_area.dart';
```

---

## Minimal example

```dart
const TextArea()
```

---

## API

### Constructor

- `TextArea`
  - `expandableHeight`, `expandableWidth`
  - `initialHeight`, `initialWidth`
  - `minWidth`, `minHeight`, `maxWidth`, `maxHeight`
  - `onHeightChanged`, `onWidthChanged`
  - Inherits `TextInputStatefulWidget` properties.

---

## Theming

- Uses `TextFieldTheme` defaults.

---

## Accessibility

- Provide labels and hints for multi-line inputs.

---

## Do / Don’t

**Do**
- ✅ Set min/max sizes for predictable layouts.

**Don’t**
- ❌ Allow infinite growth without layout constraints.

---

## Related components

- `text_field`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
