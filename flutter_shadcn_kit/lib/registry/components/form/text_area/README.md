# Text Area

Resizable multi-line text input built on top of `TextInputStatefulWidget`.

## Usage

```dart
TextArea(
  placeholder: Text('Enter details...'),
  expandableHeight: true,
  minHeight: 120,
  maxHeight: 320,
)
```

## Notes
- Requires the `text_field` component because it subclasses `TextInputStatefulWidget`.
- Use `expandableHeight`/`expandableWidth` to allow manual resizing.
