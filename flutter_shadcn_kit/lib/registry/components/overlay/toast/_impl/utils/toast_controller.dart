part of '../../toast.dart';

/// Controller that displays toast entries using Overlay.
class ToastController {
/// Stores `_entries` state/configuration for this implementation.
  final List<OverlayEntry> _entries = [];
/// Stores `defaultDuration` state/configuration for this implementation.
  final Duration defaultDuration;
/// Stores `animationDuration` state/configuration for this implementation.
  final Duration animationDuration;
/// Creates a `ToastController` instance.
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
/// Stores `resolvedDuration` state/configuration for this implementation.
    final resolvedDuration = duration ?? defaultDuration;
/// Stores `entry` state/configuration for this implementation.
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (overlayContext) {
        final theme = Theme.of(overlayContext);
        final toastTheme = ComponentTheme.maybeOf<ToastTheme>(overlayContext);
        final padding =
            toastTheme?.padding ??
            EdgeInsets.all(theme.density.baseContentPadding);
/// Stores `resolvedSpacing` state/configuration for this implementation.
        final resolvedSpacing = spacing ?? toastTheme?.margin ?? 8.0;
/// Stores `totalOffset` state/configuration for this implementation.
        final totalOffset = _entries.length * resolvedSpacing;
/// Stores `foregroundColor` state/configuration for this implementation.
        final foregroundColor = theme.colorScheme.foreground;
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
              child: DefaultTextStyle.merge(
                style: TextStyle(color: foregroundColor),
                child: IconTheme.merge(
                  data: IconThemeData(color: foregroundColor),
                  child: Container(
                    padding: padding,
                    width: toastTheme?.width,
                    child: builder(overlayContext),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    _entries.add(entry);
    overlay.insert(entry);
  }
}
