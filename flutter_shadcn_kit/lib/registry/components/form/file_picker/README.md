# File Upload (`file_picker`)

UI-only file upload surfaces with pluggable file picking.

---

## When to use

- Use this when:
  - you want upload/dropzone UI without coupling to a specific picker plugin.
  - you need one of three dedicated surfaces via `FileUpload` factory constructors:
    - drag + drop
    - tile picker (no drag)
    - mobile trigger (icon/button)
- Avoid when:
  - you only need basic native picker calls and no upload/list UI.

---

## Install

```bash
flutter_shadcn add file_picker
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/form/file_picker/file_picker.dart';
```

---

## Picker integration

This component is UI-only. Provide your own `pickFiles` callback and wire it to any package.

```dart
Future<List<FileLike>> onPick(FileUploadPickRequest request) async {
  // Bridge request.allowMultiple / request.allowedExtensions / request.allowedMimeTypes
  // to any picker package and return FileLike objects.
  return [];
}
```

---

## Variants (factory constructors)

### 1) Drag & Drop

```dart
FileUpload.dragDrop(
  pickFiles: onPick,
  title: const Text('Upload files'),
  hint: const Text('Drag files here or click to pick.'),
)
```

Notes:
- No browse action button is rendered in drag-drop mode.
- Dropzone click can still trigger your `pickFiles` callback.

### 2) Tile Picker (No Drag and Drop)

```dart
FileUpload.tile(
  pickFiles: onPick,
  title: const Text('Attach files'),
  actionLabel: 'Add files',
)
```

### 3) Mobile Trigger (Icon/Button)

```dart
FileUpload.mobile(
  pickFiles: onPick,
  compactOptions: const [
    FileUploadPickOption.pickFiles,
    FileUploadPickOption.pickImages,
  ],
  popover: true,
)
```

---

## Upload support

All three variants support uploads with `uploadFn` and `FileUploadController`.

---

## API

- `FileUpload.dragDrop`
- `FileUpload.tile`
- `FileUpload.mobile` (`popover: false|true`)
- `pickFiles` (`FileUploadPickFiles?`)
- `uploadFn` (`UploadFn?`)
- `files` (`List<FileLike>?`), `controller` (`FileUploadController?`)
- `allowMultiple`, `maxFiles`, `maxFileSizeBytes`, `allowedExtensions`, `allowedMimeTypes`
- `onFilesSelected`, `onFilesChanged`, `onProgress`, `onComplete`, `onError`

---

## Theming

- `FileUploadDropzoneTheme` controls drag-drop surface styling.

---

## Related components

- `dropzone`
- `file_input`
- `linear_progress_indicator`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
