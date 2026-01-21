part of '../toast.dart';

/// Controller that displays toast entries using Overlay.
class ToastController {
  final List<OverlayEntry> _entries = [];
  final Duration defaultDuration;
  final Duration animationDuration;
  ToastController({
    this.defaultDuration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 250),
  });

  void show({
    required BuildContext context,
    required WidgetBuilder builder,
    Duration? duration,
    double? spacing,
  }) {
    final overlay = Overlay.of(context);
    final resolvedDuration = duration ?? defaultDuration;
    late final OverlayEntry entry;
    entry = OverlayEntry(builder: (overlayContext) {
      final toastTheme = ComponentTheme.maybeOf<ToastTheme>(overlayContext);
      final padding = toastTheme?.padding ?? const EdgeInsets.all(16);
      final resolvedSpacing = spacing ?? toastTheme?.margin ?? 8.0;
      final totalOffset = _entries.length * resolvedSpacing;
      return Positioned(
        top: 32 + totalOffset,
        right: 24,
        child: Padding(
          padding: EdgeInsets.zero,
          child: ToastEntry(
            duration: resolvedDuration,
            animationDuration: animationDuration,
            animationCurve: toastTheme?.animationCurve ?? Curves.easeOut,
            onDismissed: () {
              entry.remove();
              _entries.remove(entry);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: toastTheme?.backgroundColor ?? Colors.black87,
                borderRadius: BorderRadius.circular(
                    toastTheme?.borderRadius ?? 12.0),
              ),
              child: Container(
                padding: padding,
                width: toastTheme?.width,
                child: builder(overlayContext),
              ),
            ),
          ),
        ),
      );
    });
    _entries.add(entry);
    overlay.insert(entry);
  }
}
