part of '../../avatar.dart';

/// Internal helper class used by the avatar component implementation.
class _AvatarWidget extends StatelessWidget implements AvatarWidget {
  /// Layout/size setting that affects avatar rendering.
  @override
  final double? size;

  /// Layout/size setting that affects avatar rendering.
  @override
  final double? borderRadius;

  /// Child content displayed inside the avatar widget.
  final Widget child;

  const _AvatarWidget({required this.child, this.size, this.borderRadius});

  /// Builds the widget tree for avatar.
  @override
  Widget build(BuildContext context) {
    return child;
  }
}
