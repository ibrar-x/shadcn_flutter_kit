# Divider

Horizontal and vertical dividers that animate when content includes a label.

## Usage

```dart
Column(
  children: [
    Text('Section 1'),
    const Divider(),
    Divider(
      child: const Text('OR'),
      thickness: 2,
      indent: 16,
      endIndent: 16,
    ),
    Text('Section 2'),
  ],
);

Row(
  children: [
    const VerticalDivider(),
    Expanded(child: Text('Content')),
  ],
);
```

## Theming

Wrap widgets with `ComponentTheme<DividerTheme>` to override `color`,
`thickness`, `indent`, `endIndent`, or `padding` defaults across the app.
