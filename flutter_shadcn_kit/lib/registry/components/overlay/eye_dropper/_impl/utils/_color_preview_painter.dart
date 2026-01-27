part of '../../eye_dropper.dart';

class _ColorPreviewPainter extends CustomPainter {
  final List<Color> colors;
  final Size size;
  final Color borderColor;
  final double borderWidth;
  final Color selectedBorderColor;
  final double selectedBorderWidth;
  final Color backgroundColor;

  _ColorPreviewPainter(
    this.colors,
    this.size,
    this.borderColor,
    this.borderWidth,
    this.selectedBorderColor,
    this.selectedBorderWidth,
    this.backgroundColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    // clip it to circle
    final clipPath = Path()
      ..addOval(Rect.fromLTWH(
          0, 0, size.width.floorToDouble(), size.height.floorToDouble()));
    canvas.clipPath(clipPath);
    final paint = Paint();

    // draw the background as background color
    paint.color = backgroundColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(
            0, 0, size.width.floorToDouble(), size.height.floorToDouble()),
        paint);

    // draw the color cells
    final cellSize = Size(size.width.floor() / this.size.width.floor(),
        size.height.floor() / this.size.height.floor());
    for (int y = 0; y < this.size.height.floor(); y++) {
      for (int x = 0; x < this.size.width.floor(); x++) {
        final color = colors[y * this.size.width.floor() + x];
        paint.color = color;
        paint.style = PaintingStyle.fill;
        canvas.drawRect(
          Rect.fromLTWH(
              (x * cellSize.width).floorToDouble(),
              (y * cellSize.height).floorToDouble(),
              cellSize.width.floorToDouble(),
              cellSize.height.floorToDouble()),
          paint,
        );
        paint.color = borderColor;
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = borderWidth;
        // draw a border
        canvas.drawRect(
          Rect.fromLTWH(
                  (x * cellSize.width).floorToDouble(),
                  (y * cellSize.height).floorToDouble(),
                  cellSize.width.floorToDouble(),
                  cellSize.height.floorToDouble())
              .inflate(paint.strokeWidth / 2),
          paint,
        );
      }
    }
    // draw a rect for the selected color at center
    paint.color = selectedBorderColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = selectedBorderWidth;
    final centerX = size.width ~/ 2;
    final centerY = size.height ~/ 2;
    final cellX = centerX ~/ cellSize.width;
    final cellY = centerY ~/ cellSize.height;
    canvas.drawRect(
      Rect.fromLTWH(
        (cellX * cellSize.width).floorToDouble(),
        (cellY * cellSize.height).floorToDouble(),
        cellSize.width.floorToDouble(),
        cellSize.height.floorToDouble(),
      ),
      paint,
    );
    // add circle border, and make sure it is not clipped
    paint.color = borderColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = borderWidth;
    canvas.drawOval(
        Rect.fromLTWH(
            0, 0, size.width.floorToDouble(), size.height.floorToDouble()),
        paint);
  }

  @override
  bool shouldRepaint(covariant _ColorPreviewPainter oldDelegate) {
    return !listEquals(oldDelegate.colors, colors) ||
        oldDelegate.size != size ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.selectedBorderColor != selectedBorderColor ||
        oldDelegate.selectedBorderWidth != selectedBorderWidth;
  }
}

/// Provides access to eye dropper functionality in the widget tree.
///
/// [EyeDropperLayerScope] is an abstract interface that allows widgets to
/// request color picking functionality from an ancestor [EyeDropperLayer].
/// Use the static methods to find the scope in the widget tree.
