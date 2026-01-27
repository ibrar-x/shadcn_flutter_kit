part of '../../eye_dropper.dart';

class _ScreenshotResult {
  final List<Color> colors;
  final Size size;
  final ImageProvider? image;

  _ScreenshotResult(this.colors, this.size, this.image);

  Color operator [](Offset position) {
    int index =
        (position.dy.floor() * size.width + position.dx.floor()).toInt();
    return colors[index];
  }
}
