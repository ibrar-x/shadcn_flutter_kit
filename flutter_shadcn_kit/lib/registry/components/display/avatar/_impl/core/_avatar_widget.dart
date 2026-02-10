part of '../../avatar.dart';

class _AvatarWidget extends StatelessWidget implements AvatarWidget {
  @override
  final double? size;
  @override
  final double? borderRadius;
  final Widget child;

  const _AvatarWidget({required this.child, this.size, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
