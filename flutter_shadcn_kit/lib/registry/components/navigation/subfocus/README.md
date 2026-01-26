# Subfocus

Hierarchical focus management for keyboard navigation.

## Usage
```dart
SubFocusScope(
  autofocus: true,
  builder: (context, scope) => Column(
    children: [
      SubFocus(builder: (context, state) => Text('Item 1')),
      SubFocus(builder: (context, state) => Text('Item 2')),
    ],
  ),
)
```
