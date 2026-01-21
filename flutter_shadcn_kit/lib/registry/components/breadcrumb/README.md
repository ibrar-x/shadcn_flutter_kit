# Breadcrumb

Horizontal breadcrumb navigation with configurable separators, scrolling overflow handling, and theme tokens.

## Usage

1. Wrap the breadcrumb items in widgets and pass them to `Breadcrumb(children: [...])`.
2. Customize the separator (arrow or slash) or supply your own widget.
3. Use `ComponentTheme<BreadcrumbTheme>` to override `separator` or `padding` globally.

Example:
```dart
Breadcrumb(
  separator: Breadcrumb.slashSeparator,
  children: [
    TextButton(onPressed: goHome, child: const Text('Home')),
    TextButton(onPressed: goCategory, child: const Text('Catalog')),
    const Text('Electronics'),
  ],
)
```
