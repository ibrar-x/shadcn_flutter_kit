# Dropzone (`dropzone`)

Dropzone surface for file uploads.

---

## When to use

- Use this when:
  - you need a drag-and-drop upload surface.
  - you want consistent styling for upload states.
- Avoid when:
  - you only need a file picker button.

---

## Install

```bash
flutter_shadcn add dropzone
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/dropzone/dropzone.dart';
```

---

## Minimal example

```dart
FileDropzone(
  onPressed: () {},
)
```

---

## API

### Constructor

- `FileDropzone`
  - `state` (`DropzoneState`)
  - `enabled`, `hotDropEnabled`, `hotDropping`, `isFocused`
  - `hint`, `icon`, `actionLabel`, `onPressed`
  - `backgroundColor`, `borderRadius`, `padding`, `minHeight`
  - `content`, `showDefaultContent`
- `DropzoneState` — `idle`, `dragging`, `uploading`, `success`, `error`, `disabled`

---

## Theming

- Uses shared theme colors for borders and emphasis.

---

## Accessibility

- Provide a visible button label (`actionLabel`).

---

## Do / Don’t

**Do**
- ✅ Reflect upload status via `state`.

**Don’t**
- ❌ Hide the browse action if drag-and-drop isn’t available.

---

## Related components

- `file_picker`
- `file_input`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
