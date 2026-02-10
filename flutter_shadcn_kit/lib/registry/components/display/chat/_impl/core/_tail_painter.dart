part of '../../chat.dart';

class _TailPainter extends CustomPainter {
  final Color color;
  final BorderRadius radius;
  final Size tailSize;
  final AxisDirection position;
  final AxisAlignment tailAlignment;
  final double tailRadius;
  const _TailPainter({
    required this.color,
    required this.radius,
    required this.tailSize,
    required this.position,
    required this.tailAlignment,
    required this.tailRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    // create tail shape
    Axis axis = switch (position) {
      AxisDirection.up => Axis.vertical,
      AxisDirection.down => Axis.vertical,
      AxisDirection.left => Axis.horizontal,
      AxisDirection.right => Axis.horizontal,
    };

    double horizontalOffset =
        tailAlignment.alongValue(axis, size.width) -
        tailAlignment.alongValue(axis, tailSize.width);
    double verticalOffset =
        tailAlignment.alongValue(axis, size.height) -
        tailAlignment.alongValue(axis, tailSize.height);
    double alignVal = tailAlignment.resolveValue(axis);
    double t = (alignVal + 1) / 2;

    Offset base1, base2, tip;

    // Get corner radius - the bubble extends beyond the painter bounds
    double cornerRadius = switch (position) {
      AxisDirection.up => max(radius.topLeft.y, radius.topRight.y),
      AxisDirection.down => max(radius.bottomLeft.y, radius.bottomRight.y),
      AxisDirection.left => max(radius.topLeft.x, radius.bottomLeft.x),
      AxisDirection.right => max(radius.topRight.x, radius.bottomRight.x),
    };

    // Calculate initial base positions at the edge
    Offset initialBase1, initialBase2;
    switch (position) {
      case AxisDirection.up:
        initialBase1 = Offset(horizontalOffset, 0);
        initialBase2 = Offset(horizontalOffset + tailSize.width, 0);
        tip = Offset(horizontalOffset + t * tailSize.width, -tailSize.height);
        break;
      case AxisDirection.down:
        initialBase1 = Offset(horizontalOffset, size.height);
        initialBase2 = Offset(horizontalOffset + tailSize.width, size.height);
        tip = Offset(
          horizontalOffset + t * tailSize.width,
          size.height + tailSize.height,
        );
        break;
      case AxisDirection.left:
        initialBase1 = Offset(0, verticalOffset);
        initialBase2 = Offset(0, verticalOffset + tailSize.height);
        tip = Offset(-tailSize.width, verticalOffset + t * tailSize.height);
        break;
      case AxisDirection.right:
        initialBase1 = Offset(size.width, verticalOffset);
        initialBase2 = Offset(size.width, verticalOffset + tailSize.height);
        tip = Offset(
          size.width + tailSize.width,
          verticalOffset + t * tailSize.height,
        );
        break;
    }

    // Extend base points along the tail-to-base vectors by cornerRadius
    Offset v1 = initialBase1 - tip;
    Offset v2 = initialBase2 - tip;
    double d1 = v1.distance;
    double d2 = v2.distance;

    // Move base1 and base2 outward along their respective vectors
    base1 = d1 == 0 ? initialBase1 : tip + v1 * ((d1 + cornerRadius) / d1);
    base2 = d2 == 0 ? initialBase2 : tip + v2 * ((d2 + cornerRadius) / d2);

    // Recalculate vectors for the rounded tip
    v1 = base1 - tip;
    v2 = base2 - tip;
    d1 = v1.distance;
    d2 = v2.distance;

    Offset pathBeforeTail = d1 == 0
        ? tip
        : tip + v1 * (min(d1, tailRadius) / d1);
    Offset pathAfterTail = d2 == 0
        ? tip
        : tip + v2 * (min(d2, tailRadius) / d2);

    path.moveTo(base1.dx, base1.dy);
    path.lineTo(pathBeforeTail.dx, pathBeforeTail.dy);
    path.quadraticBezierTo(tip.dx, tip.dy, pathAfterTail.dx, pathAfterTail.dy);
    path.lineTo(base2.dx, base2.dy);
    path.close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _TailPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.tailSize != tailSize ||
        oldDelegate.position != position ||
        oldDelegate.tailAlignment != tailAlignment;
  }
}
