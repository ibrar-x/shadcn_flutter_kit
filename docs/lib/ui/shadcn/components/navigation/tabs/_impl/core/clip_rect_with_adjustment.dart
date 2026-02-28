part of '../../tabs.dart';

/// _ClipRectWithAdjustment defines a reusable type for this registry module.
class _ClipRectWithAdjustment extends CustomClipper<Rect> {
/// Stores `borderWidth` state/configuration for this implementation.
  final double borderWidth;

  _ClipRectWithAdjustment(this.borderWidth);

  @override
/// Executes `getClip` behavior for this component/composite.
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      0,
      -borderWidth,
      size.width,
      size.height + borderWidth * 2,
    );
  }

  @override
/// Executes `shouldReclip` behavior for this component/composite.
  bool shouldReclip(covariant _ClipRectWithAdjustment oldClipper) {
    return oldClipper.borderWidth != borderWidth;
  }
}
