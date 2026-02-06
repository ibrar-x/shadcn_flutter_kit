# Swiper

Swipe-triggered overlays for drawers and sheets.

## Usage
```dart
Swiper(
  handler: SwiperHandler.sheet,
  position: OverlayPosition.bottom,
  builder: (context) => const Text('Swipe content'),
  child: const SizedBox.expand(),
)
```
