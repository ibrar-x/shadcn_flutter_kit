# File Input (`file_input`)

Utilities for mapping file extensions to icon widgets.

---

## When to use

- Use this when:
  - you need consistent file-type icons.
- Avoid when:
  - you already have a custom icon pipeline.

---

## Install

```bash
flutter_shadcn add file_input
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/file_input/file_input.dart';
```

---

## Minimal example

```dart
FileIconProvider.builder(
  builder: (ext) => const Icon(Icons.insert_drive_file),
  child: Builder(
    builder: (context) => FileIconProvider.buildIcon(context, 'pdf'),
  ),
)
```

---

## API

### Constructor

- `FileIconProvider`
  - `FileIconProvider.builder(builder: ..., child: ...)`
  - `FileIconProvider(icons: ..., child: ...)`
- `FileIconBuilder` — `Widget Function(String extension)`

---

## Theming

- Icons inherit theme colors through `Icon` widgets.

---

## Accessibility

- Provide semantic labels for file icons where appropriate.

---

## Do / Don’t

**Do**
- ✅ Use a shared provider to keep file icons consistent.

**Don’t**
- ❌ Hardcode icons per list item if a provider can be reused.

---

## Related components

- `file_picker`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
