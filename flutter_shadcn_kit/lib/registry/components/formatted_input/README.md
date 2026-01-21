# Formatted Input

Low-level helpers that turn structured `InputPart` lists into writable formatters.

- `InputPart` defines static text, editable digits, or custom widget segments that can be mapped to formatted object values.
- `FormattedValue`, `FormattedInputController`, and `FormattedInput` provide the plumbing to keep multiple parts synchronized, notify a controller, and expose validation helpers.
- `FormattedObjectInput` extends the base control with `BiDirectionalConvert` so callers can map between an object (like `DateTime`/`Duration`) and the natural parts.

```dart
FormattedObjectInput<DateTime>(
  converter: dateConverter,
  parts: [
    InputPart.editable(length: 2, width: 40),
    InputPart.static('/'),
    InputPart.editable(length: 2, width: 40),
  ],
  popupBuilder: (context, controller) => CalendarView(controller: controller),
)
```
