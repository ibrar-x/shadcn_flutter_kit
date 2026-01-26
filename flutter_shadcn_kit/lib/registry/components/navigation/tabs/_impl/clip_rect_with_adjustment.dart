part of '../tabs.dart';

class _ClipRectWithAdjustment extends CustomClipper<Rect> {
  final double borderWidth;

  _ClipRectWithAdjustment(this.borderWidth);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      0,
      -borderWidth,
      size.width,
      size.height + borderWidth * 2,
    );
  }

  @override
  bool shouldReclip(covariant _ClipRectWithAdjustment oldClipper) {
    return oldClipper.borderWidth != borderWidth;
  }
}
