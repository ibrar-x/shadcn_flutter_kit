---
title: "Class: ShadcnLayer"
description: "Lightweight wrapper that injects an [OverlayManagerLayer] only when missing."
---

```dart
/// Lightweight wrapper that injects an [OverlayManagerLayer] only when missing.
class ShadcnLayer extends StatelessWidget {
  const ShadcnLayer({super.key, required this.child, this.theme, this.popoverHandler = OverlayHandler.popover, this.tooltipHandler = OverlayHandler.popover, this.menuHandler = OverlayHandler.popover});
  final Widget child;
  final ThemeData? theme;
  final OverlayHandler popoverHandler;
  final OverlayHandler tooltipHandler;
  final OverlayHandler menuHandler;
  Widget build(BuildContext context);
}
```
