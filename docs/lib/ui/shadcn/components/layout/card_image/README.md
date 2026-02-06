# CardImage

Image-centric card that pairs a scaled photo container with title, subtitle, and optional leading/trailing widgets inside a clickable surface.

## Features

- Hover-friendly scaling via `WidgetStatesController`.
- Vertical/horizontal layouts with gap control.
- Outlined image container with themable colors.
- Easily plugged into `ComponentTheme<CardImageTheme>` to override spacing or scaling.

## Example

```dart
CardImage(
  image: Image.network('https://example.com/photo.jpg', fit: BoxFit.cover),
  title: Text('Sunset Vista'),
  subtitle: Text('Captured in the hills'),
  direction: Axis.horizontal,
  gap: 16,
  onPressed: () => print('card tapped'),
);
```
