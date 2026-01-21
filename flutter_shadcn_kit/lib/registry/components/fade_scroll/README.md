# FadeScroll

Displays fade effects at the edges of a scrollable area using ThemeData tokens.

## Usage

```dart
ScrollController controller = ScrollController();
FadeScroll(
  controller: controller,
  child: ListView(..., controller: controller),
);
```

Use `ComponentTheme<FadeScrollTheme>` to override `startOffset`, `endOffset`, or the gradient colors.
