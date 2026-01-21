part of '../avatar.dart';

class AvatarGroup extends StatelessWidget {
  const AvatarGroup({
    super.key,
    required this.alignment,
    required this.children,
    this.gap,
    this.clipBehavior,
  });

  final List<AvatarWidget> children;
  final AlignmentGeometry alignment;
  final double? gap;
  final Clip? clipBehavior;

  factory AvatarGroup.toLeft({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: Alignment(offset, 0),
      gap: gap,
      children: children,
    );
  }

  factory AvatarGroup.toRight({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: Alignment(-offset, 0),
      gap: gap,
      children: children,
    );
  }

  factory AvatarGroup.toStart({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: AlignmentDirectional(offset, 0),
      gap: gap,
      children: children,
    );
  }

  factory AvatarGroup.toEnd({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: AlignmentDirectional(-offset, 0),
      gap: gap,
      children: children,
    );
  }

  factory AvatarGroup.toTop({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: Alignment(0, offset),
      gap: gap,
      children: children,
    );
  }

  factory AvatarGroup.toBottom({
    Key? key,
    required List<AvatarWidget> children,
    double? gap,
    double offset = 0.5,
  }) {
    return AvatarGroup(
      key: key,
      alignment: Alignment(0, -offset),
      gap: gap,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Positioned> entries = [];
    double currentX = 0;
    double currentY = 0;
    double currentWidth = 0;
    double currentHeight = 0;
    Rect rect = Rect.zero;
    double currentBorderRadius = 0;
    final resolved = alignment.optionallyResolve(context);

    for (var i = 0; i < children.length; i++) {
      final avatar = children[i];
      final size = avatar.size ?? theme.scaling * 40;
      if (i == 0) {
        entries.add(
          Positioned(
            left: currentX,
            top: currentY,
            child: avatar,
          ),
        );
        rect = Rect.fromLTWH(currentX, currentY, size, size);
        currentWidth = size;
        currentHeight = size;
        currentBorderRadius = avatar.borderRadius ?? theme.radius * size;
        continue;
      }

      final width = size;
      final height = size;
      final widthDiff = currentWidth - width;
      final heightDiff = currentHeight - height;

      final offsetWidth = -currentWidth * resolved.x;
      final offsetHeight = -currentHeight * resolved.y;
      final offsetWidthDiff = widthDiff * resolved.x;
      final offsetHeightDiff = heightDiff * resolved.y;
      final x = (widthDiff / 2) + offsetWidth + currentX + offsetWidthDiff;
      final y =
          (heightDiff / 2) + offsetHeight + currentY + offsetHeightDiff;

      entries.add(
        Positioned(
          left: x,
          top: y,
          width: size,
          height: size,
          child: ClipPath(
            clipper: AvatarGroupClipper(
              borderRadius: currentBorderRadius,
              alignment: resolved,
              previousAvatarSize: currentWidth,
              gap: gap ?? theme.scaling * 4,
            ),
            child: avatar,
          ),
        ),
      );

      currentX = x;
      currentY = y;
      currentWidth = size;
      currentHeight = size;
      currentBorderRadius = avatar.borderRadius ?? theme.radius * size;
      rect = rect.expandToInclude(Rect.fromLTWH(x, y, size, size));
    }

    return SizedBox(
      width: rect.width,
      height: rect.height,
      child: Stack(
        clipBehavior: clipBehavior ?? Clip.none,
        alignment: Alignment.center,
        children: entries
            .map(
              (entry) => Positioned(
                left: entry.left! - rect.left,
                top: entry.top! - rect.top,
                width: entry.width,
                height: entry.height,
                child: entry.child,
              ),
            )
            .toList(),
      ),
    );
  }
}

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
