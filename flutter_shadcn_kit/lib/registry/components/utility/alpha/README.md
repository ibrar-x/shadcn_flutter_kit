# Alpha

Painter for the classic transparency checkerboard. Use it as a backdrop when
rendering translucent colors so the alpha channel remains visible regardless
of the host background.

## Usage

```dart
const SizedBox(
  width: 200,
  height: 32,
  child: CustomPaint(
    painter: AlphaPainter(),
  ),
);
```
