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
    bool? pauseOnHover,
    Set<ToastSwipeDirection>? dismissDirections,
    double? dismissDragThreshold,
    double? top,
    double? right,
    double? bottom,
    double? left,
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
        final resolvedPauseOnHover =
            pauseOnHover ?? toastTheme?.pauseOnHover ?? false;
        final resolvedDismissDirections =
            dismissDirections ??
            toastTheme?.dismissDirections ??
            _autoDismissDirections(
              top: top,
              right: right,
              bottom: bottom,
              left: left,
            );
        final resolvedDismissDragThreshold =
            dismissDragThreshold ?? toastTheme?.dismissDragThreshold ?? 72.0;

        /// Stores `totalOffset` state/configuration for this implementation.
        final totalOffset = _entries.length * resolvedSpacing;

        /// Stores `foregroundColor` state/configuration for this implementation.
        final foregroundColor = theme.colorScheme.foreground;
        final isBottomStack = bottom != null;
        final resolvedTop = top != null
            ? top + totalOffset
            : (isBottomStack ? null : 32 + totalOffset);
        final resolvedBottom = bottom != null ? bottom + totalOffset : null;
        final resolvedLeft = left;
        final resolvedRight = right ?? (left == null ? 24 : null);
        return Positioned(
          top: resolvedTop,
          right: resolvedRight,
          bottom: resolvedBottom,
          left: resolvedLeft,
          child: Padding(
            padding: EdgeInsets.zero,
            child: ToastEntry(
              duration: resolvedDuration,
              animationDuration: animationDuration,
              animationCurve: toastTheme?.animationCurve ?? Curves.easeOut,
              pauseOnHover: resolvedPauseOnHover,
              dismissDirections: resolvedDismissDirections,
              dismissDragThreshold: resolvedDismissDragThreshold,
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

  Set<ToastSwipeDirection> _autoDismissDirections({
    required double? top,
    required double? right,
    required double? bottom,
    required double? left,
  }) {
    final directions = <ToastSwipeDirection>{};
    if (top != null) directions.add(ToastSwipeDirection.up);
    if (bottom != null) directions.add(ToastSwipeDirection.down);
    if (left != null && right == null) directions.add(ToastSwipeDirection.left);
    if (right != null && left == null) {
      directions.add(ToastSwipeDirection.right);
    }
    if (directions.isEmpty) {
      directions.addAll(const {
        ToastSwipeDirection.up,
        ToastSwipeDirection.down,
        ToastSwipeDirection.left,
        ToastSwipeDirection.right,
      });
    }
    return directions;
  }
}
