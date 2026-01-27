part of '../../outlined_container.dart';

class SurfaceBlur extends StatefulWidget {
  /// The child widget to display with blurred background.
  final Widget child;

  /// The amount of blur to apply (sigma value for blur filter).
  final double? surfaceBlur;

  /// Border radius for clipping the blur effect.
  final BorderRadiusGeometry? borderRadius;

  const SurfaceBlur({
    super.key,
    required this.child,
    this.surfaceBlur,
    this.borderRadius,
  });

  @override
  State<SurfaceBlur> createState() => _SurfaceBlurState();
}
