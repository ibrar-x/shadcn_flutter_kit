part of '../avatar.dart';

abstract class AvatarWidget extends Widget {
  const AvatarWidget({super.key});

  double? get size;
  double? get borderRadius;
}

class _AvatarWidget extends StatelessWidget implements AvatarWidget {
  @override
  final double? size;
  @override
  final double? borderRadius;
  final Widget child;

  const _AvatarWidget({
    required this.child,
    this.size,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
