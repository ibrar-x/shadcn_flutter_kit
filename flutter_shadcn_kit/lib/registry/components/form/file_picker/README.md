# File Upload (`file_picker`)

Dropzone and list UI for selecting and managing uploaded files.

---

## When to use

- Use this when:
  - you need drag-and-drop uploads with file list management.
  - you want built-in validation for size/types.
- Avoid when:
  - a simple file picker button is enough.

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

## Minimal example

```dart
FileUpload(
  onFilesSelected: (files) {},
)
```

---

## API

### Constructor

- `FileUpload`
  - `onFilesSelected`, `onFilesChanged`, `onProgress`, `onComplete`, `onError`
  - `uploadFn` (`UploadFn?`)
  - `files` (`List<FileLike>?`), `controller` (`FileUploadController?`)
  - `allowMultiple`, `maxFiles`, `maxFileSizeBytes`, `allowedExtensions`, `allowedMimeTypes`
  - `enableDragDrop`, `enableDropzoneClick`, `enableActionButton`
  - `title`, `subtitle`, `hint`, `actionLabel`, `icon`
  - `showFileList`, `itemsLayout`, `itemsGridColumns`, `itemsMaxHeight`
- `FileUploadController` — manages files and upload state.
- `FileLike` — file abstraction for picker items.
- `FileUploadError` — validation/upload error model.

---

## Theming

- `FileUploadDropzoneTheme` controls dropzone styling.

---

## Accessibility

- Provide clear labels for upload actions and errors.

---

## Do / Don’t

**Do**
- ✅ Use `allowedExtensions` or `allowedMimeTypes` to validate inputs.

**Don’t**
- ❌ Allow unlimited files without UI feedback.

---

## Related components

- `dropzone`
- `file_input`
- `linear_progress_indicator`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
