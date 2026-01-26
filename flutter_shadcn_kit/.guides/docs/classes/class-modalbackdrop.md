---
title: "Class: ModalBackdrop"
description: "Reference for ModalBackdrop"
---

```dart
class ModalBackdrop extends StatelessWidget {
  /// Determines if surface clipping should be enabled based on opacity.
  ///
  /// Returns `true` if [surfaceOpacity] is null or less than 1.0,
  /// indicating that clipping is needed for proper visual effects.
  static bool shouldClipSurface(double? surfaceOpacity);
  /// The child widget to display above the backdrop.
  final Widget child;
  /// Border radius for the backdrop cutout around the child.
  final BorderRadiusGeometry? borderRadius;
  /// Padding around the child widget.
  final EdgeInsetsGeometry? padding;
  /// Color of the backdrop barrier.
  final Color? barrierColor;
  /// Animation for fade in/out transitions.
  final Animation<double>? fadeAnimation;
  /// Whether the backdrop should behave as a modal.
  final bool? modal;
  /// Whether to apply surface clipping effects.
  final bool? surfaceClip;
  /// Creates a [ModalBackdrop].
  ///
  /// The [child] parameter is required and represents the content to display
  /// above the backdrop.
  ///
  /// Parameters:
  /// - [child] (Widget, required): content widget displayed above backdrop
  /// - [modal] (bool?, optional): enables modal behavior, defaults to true
  /// - [surfaceClip] (bool?, optional): enables surface clipping, defaults to true
  /// - [borderRadius] (BorderRadiusGeometry?, optional): corner radius for cutout
  /// - [barrierColor] (Color?, optional): backdrop color, defaults to black with 80% opacity
  /// - [padding] (EdgeInsetsGeometry?, optional): padding around child
  /// - [fadeAnimation] (`Animation<double>?`, optional): fade transition animation
  ///
  /// Example:
  /// ```dart
  /// ModalBackdrop(
  ///   barrierColor: Colors.black54,
  ///   fadeAnimation: slideController,
  ///   child: AlertDialog(title: Text('Alert')),
  /// )
  /// ```
  const ModalBackdrop({super.key, this.modal, this.surfaceClip, this.borderRadius, this.barrierColor, this.padding, this.fadeAnimation, required this.child});
  Widget build(BuildContext context);
}
```
