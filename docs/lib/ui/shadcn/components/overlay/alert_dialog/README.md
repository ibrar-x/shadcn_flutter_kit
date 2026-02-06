# AlertDialog

Lightweight modal dialog that draws focus with a blurred backdrop, rounded
surface, and optional header/content/action slots. Designed to pair nicely
with form or destructive confirmations without plumbing manual overlays.

## Usage

```dart
AlertDialog(
  leading: Icon(Icons.warning),
  title: Text('Delete File?'),
  content: Text('This action cannot be undone.'),
  actions: [
    Button.ghost(onPressed: Navigator.of(context).pop, child: Text('Cancel')),
    Button.destructive(onPressed: _delete, child: Text('Delete')),
  ],
);
```

## Details

- `leading` and `trailing` icons are rendered with the large muted icon style.
- `title` and `content` accept any widget but default to themed typography.
- `actions` are aligned to the end and separated by consistent spacing.
- `surfaceBlur`, `surfaceOpacity`, and `barrierColor` can customize the
  backdrop and modal ambiance while retaining the default theme values.
