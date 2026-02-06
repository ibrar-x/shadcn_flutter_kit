part of '../../avatar.dart';

class AvatarGroupClipper extends CustomClipper<Path> {
  const AvatarGroupClipper({
    required this.borderRadius,
    required this.alignment,
    required this.previousAvatarSize,
    required this.gap,
  });

  final double borderRadius;
  final Alignment alignment;
  final double previousAvatarSize;
  final double gap;

  @override
  Path getClip(Size size) {
    final widthDiff = size.width - previousAvatarSize;
    final heightDiff = size.height - previousAvatarSize;

    var left = widthDiff / 2;
    var top = heightDiff / 2;
    left += size.width * alignment.x;
    top += size.height * alignment.y;

    final path = Path()..fillType = PathFillType.evenOdd;
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutout = Rect.fromLTWH(
      left - gap,
      top - gap,
      previousAvatarSize + gap * 2,
      previousAvatarSize + gap * 2,
    );

    if (borderRadius > 0) {
      path.addRRect(
        RRect.fromRectAndRadius(
          cutout,
          Radius.circular(borderRadius + gap * 2),
        ),
      );
    } else {
      path.addRect(cutout);
    }
    return path;
  }

  @override
  bool shouldReclip(covariant AvatarGroupClipper oldClipper) {
    return oldClipper.borderRadius != borderRadius ||
        oldClipper.alignment != alignment ||
        oldClipper.previousAvatarSize != previousAvatarSize ||
        oldClipper.gap != gap;
  }
}
