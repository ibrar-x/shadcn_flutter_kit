---
title: "Class: OverlayManagerAsTooltipOverlayHandler"
description: "Overlay handler that delegates tooltip display to an OverlayManager."
---

```dart
/// Overlay handler that delegates tooltip display to an OverlayManager.
class OverlayManagerAsTooltipOverlayHandler extends OverlayHandler {
  final OverlayManager overlayManager;
  const OverlayManagerAsTooltipOverlayHandler({required this.overlayManager});
  OverlayCompleter<T?> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool barrierDismissable = true, bool modal = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
