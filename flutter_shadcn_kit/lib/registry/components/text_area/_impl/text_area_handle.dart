part of '../text_area.dart';

class _TextAreaDragHandlePainter extends CustomPainter {
  final Color color;

  _TextAreaDragHandlePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    final start = Offset(size.width, 0);
    final end = Offset(0, size.height);
    final start2 = Offset(size.width, size.height / 2);
    final end2 = Offset(size.width / 2, size.height);
    canvas.drawLine(start, end, paint);
    canvas.drawLine(start2, end2, paint);
  }

  @override
  bool shouldRepaint(covariant _TextAreaDragHandlePainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
