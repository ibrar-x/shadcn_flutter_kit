# Scrollbar

Themeable scrollbar wrapper around `RawScrollbar` with shadcn defaults.

## Usage

```dart
Scrollbar(
  controller: controller,
  thumbVisibility: true,
  child: ListView.builder(
    controller: controller,
    itemCount: 100,
    itemBuilder: (context, index) => Text('Row $index'),
  ),
)
```

## Notes
- Customize via `ScrollbarTheme` for color, thickness, and radius.
