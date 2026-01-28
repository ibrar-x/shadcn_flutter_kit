part of '../../outlined_container.dart';


class _SurfaceBlurState extends State<SurfaceBlur> {
  final GlobalKey _mainContainerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (widget.surfaceBlur == null || widget.surfaceBlur! <= 0) {
      return KeyedSubtree(key: _mainContainerKey, child: widget.child);
    }
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.surfaceBlur!,
                sigmaY: widget.surfaceBlur!,
              ),
              child: const SizedBox(),
            ),
          ),
        ),
        KeyedSubtree(key: _mainContainerKey, child: widget.child),
      ],
    );
  }
}

/// Theme configuration for [OutlinedContainer] appearance.
