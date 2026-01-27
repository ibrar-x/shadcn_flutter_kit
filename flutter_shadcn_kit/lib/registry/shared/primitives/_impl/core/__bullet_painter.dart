part of '../../text.dart';


class _BulletPainter extends CustomPainter {
  final Color? color;
  final int depth;

  _BulletPainter({required this.color, required this.depth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? const Color(0xFF000000)
      ..style = PaintingStyle.fill;
    if (depth % 3 == 0) {
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), size.width / 2, paint);
    } else if (depth % 3 == 1) {
      canvas.drawRect(Offset(0, 0) & size, paint);
    } else {
      final path = Path();
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BulletPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.depth != depth;
  }
}
