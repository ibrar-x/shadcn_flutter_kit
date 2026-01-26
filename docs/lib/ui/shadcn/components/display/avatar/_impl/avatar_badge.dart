part of '../avatar.dart';

class AvatarBadge extends StatelessWidget implements AvatarWidget {
  const AvatarBadge({
    super.key,
    this.child,
    this.size,
    this.borderRadius,
    this.color,
  });

  final Widget? child;
  @override
  final double? size;
  @override
  final double? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedSize = size ?? theme.scaling * 12;
    return Container(
      width: resolvedSize,
      height: resolvedSize,
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.primary,
        borderRadius:
            BorderRadius.circular(borderRadius ?? theme.radius * resolvedSize),
      ),
      child: child,
    );
  }
}
