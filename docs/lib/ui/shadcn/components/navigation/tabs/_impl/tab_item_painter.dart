part of '../tabs.dart';

class _TabItemPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final bool isFocused;
  final double borderWidth;

  _TabItemPainter({
    required this.borderRadius,
    required this.backgroundColor,
    required this.isFocused,
    required this.borderWidth,
    required this.borderColor,
  });

  @override
  bool shouldRepaint(covariant _TabItemPainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.isFocused != isFocused ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderColor != borderColor;
  }

  Path createPath(Size size, [bool closed = false]) {
    Path path = Path();
    double adjustment = borderWidth;
    path.moveTo(-borderRadius.bottomLeft.x, size.height + adjustment);
    path.quadraticBezierTo(
        0, size.height, 0, size.height - borderRadius.bottomLeft.y);
    path.lineTo(0, borderRadius.topLeft.y);
    path.quadraticBezierTo(0, 0, borderRadius.topLeft.x, 0);
    path.lineTo(size.width - borderRadius.topRight.x, 0);
    path.quadraticBezierTo(size.width, 0, size.width, borderRadius.topRight.y);
    path.lineTo(size.width, size.height - borderRadius.bottomRight.y);
    path.quadraticBezierTo(size.width, size.height,
        size.width + borderRadius.bottomRight.x, size.height + adjustment);
    if (closed) {
      path.close();
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (!isFocused) {
      return;
    }
    Path path = createPath(size, true);
    canvas.drawPath(
      path,
      Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill,
    );

    Path borderPath = createPath(size);

    canvas.drawPath(
      borderPath,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth,
    );
  }
}

