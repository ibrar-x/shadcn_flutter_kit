part of '../../outlined_container.dart';

class DashedLinePainter extends CustomPainter {
  final double width;
  final double gap;
  final double thickness;
  final Color color;

  const DashedLinePainter({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..moveTo(0, 0)..lineTo(size.width, 0);
    final pathMetrics = path.computeMetrics();
    final draw = Path();
    for (final pathMetric in pathMetrics) {
      for (double i = 0; i < pathMetric.length; i += gap + width) {
        double start = i;
        double end = i + width;
        if (end > pathMetric.length) {
          end = pathMetric.length;
        }
        draw.addPath(pathMetric.extractPath(start, end), Offset.zero);
      }
    }
    canvas.drawPath(
      draw,
      Paint()
        ..color = color
        ..strokeWidth = thickness
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant DashedLinePainter oldDelegate) {
    return oldDelegate.width != width ||
        oldDelegate.gap != gap ||
        oldDelegate.thickness != thickness ||
        oldDelegate.color != color;
  }
}

