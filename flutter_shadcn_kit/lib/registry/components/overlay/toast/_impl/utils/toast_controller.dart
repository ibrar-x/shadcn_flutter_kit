part of '../../toast.dart';

/// Controller that displays toast entries using Overlay.
class ToastController {
  /// Stores `_entries` state/configuration for this implementation.
  final List<_ToastStackItem> _entries = [];

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
    bool? overlapStackWhenMultiple,
    double? overlapStackOffset,
    bool? pauseAutoDismissWhenMultiple,
    Duration? stackAnimationDuration,
    Curve? stackAnimationCurve,
    int? maxVisibleCount,
    bool? pauseOnHover,
    Set<ToastSwipeDirection>? dismissDirections,
    double? dismissDragThreshold,
    double? top,
    double? right,
    double? bottom,
    double? left,
  }) {
    final overlay = Overlay.of(context);
    final controllerTheme = ComponentTheme.maybeOf<ToastTheme>(context);
    final resolvedMaxVisibleCount =
        (maxVisibleCount ?? controllerTheme?.maxVisibleCount ?? 0).clamp(
          0,
          999,
        );
    if (resolvedMaxVisibleCount > 0) {
      while (_entries.length >= resolvedMaxVisibleCount) {
        final removed = _entries.removeAt(0);
        removed.entry.remove();
      }
    }

    /// Stores `resolvedDuration` state/configuration for this implementation.
    final resolvedDuration = duration ?? defaultDuration;

    /// Stores `entry` state/configuration for this implementation.
    late final _ToastStackItem stackItem;
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
        final resolvedOverlapStackWhenMultiple =
            overlapStackWhenMultiple ??
            toastTheme?.overlapStackWhenMultiple ??
            false;
        final resolvedOverlapStackOffset =
            overlapStackOffset ?? toastTheme?.overlapStackOffset ?? 8.0;
        final resolvedPauseAutoDismissWhenMultiple =
            pauseAutoDismissWhenMultiple ??
            toastTheme?.pauseAutoDismissWhenMultiple ??
            false;
        final resolvedStackAnimationDuration =
            stackAnimationDuration ??
            toastTheme?.stackAnimationDuration ??
            const Duration(milliseconds: 240);
        final resolvedStackAnimationCurve =
            stackAnimationCurve ??
            toastTheme?.stackAnimationCurve ??
            Curves.easeOutCubic;
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

        final itemIndex = _entries.indexOf(stackItem);
        final hasMultiple = _entries.length > 1;
        if (resolvedPauseAutoDismissWhenMultiple && hasMultiple) {
          for (final item in _entries) {
            item.lockAutoDismiss = true;
          }
        }
        final totalOffset = _stackOffsetFor(
          itemIndex,
          resolvedSpacing,
          hasMultiple: hasMultiple,
          overlapStackWhenMultiple: resolvedOverlapStackWhenMultiple,
          overlapStackOffset: resolvedOverlapStackOffset,
        );

        /// Stores `foregroundColor` state/configuration for this implementation.
        final foregroundColor = theme.colorScheme.foreground;
        final isBottomStack = bottom != null;
        final targetShift = isBottomStack ? -totalOffset : totalOffset;
        final targetScale = _stackScaleFor(
          itemIndex,
          hasMultiple: hasMultiple,
          overlapStackWhenMultiple: resolvedOverlapStackWhenMultiple,
        );
        final previousShift = stackItem.shift;
        final previousScale = stackItem.scale;
        if ((previousShift - targetShift).abs() > 0.1 ||
            (previousScale - targetScale).abs() > 0.001) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!_entries.contains(stackItem)) return;
            stackItem
              ..shift = targetShift
              ..scale = targetScale;
          });
        }
        final resolvedTop = top ?? (isBottomStack ? null : 32);
        final resolvedBottom = bottom;
        final resolvedLeft = left;
        final resolvedRight = right ?? (left == null ? 24 : null);
        final autoDismissEnabled =
            !(resolvedPauseAutoDismissWhenMultiple &&
                (hasMultiple || stackItem.lockAutoDismiss));
        final child = TweenAnimationBuilder<double>(
          tween: Tween(begin: previousScale, end: targetScale),
          duration: resolvedStackAnimationDuration,
          curve: resolvedStackAnimationCurve,
          builder: (context, scale, child) {
            return Transform.scale(
              alignment: isBottomStack
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              scale: scale,
              child: child,
            );
          },
          child: ToastEntry(
            duration: resolvedDuration,
            animationDuration: animationDuration,
            animationCurve: toastTheme?.animationCurve ?? Curves.easeOut,
            pauseOnHover: resolvedPauseOnHover,
            autoDismiss: autoDismissEnabled,
            dismissDirections: resolvedDismissDirections,
            dismissDragThreshold: resolvedDismissDragThreshold,
            onDismissed: () {
              entry.remove();
              _entries.remove(stackItem);
              _markAllNeedsBuild();
            },
            child: _ToastSizeObserver(
              onSizeChanged: (size) {
                _onItemHeightChanged(stackItem, size.height);
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
        return Positioned(
          top: resolvedTop,
          right: resolvedRight,
          bottom: resolvedBottom,
          left: resolvedLeft,
          child: Padding(
            padding: EdgeInsets.zero,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: previousShift, end: targetShift),
              duration: resolvedStackAnimationDuration,
              curve: resolvedStackAnimationCurve,
              builder: (context, animatedShift, child) {
                return Transform.translate(
                  offset: Offset(0, animatedShift),
                  child: child,
                );
              },
              child: child,
            ),
          ),
        );
      },
    );
    stackItem = _ToastStackItem(entry: entry);
    _entries.add(stackItem);
    _markAllNeedsBuild();
    overlay.insert(entry);
  }

  double _stackOffsetFor(
    int index,
    double spacing, {
    required bool hasMultiple,
    required bool overlapStackWhenMultiple,
    required double overlapStackOffset,
  }) {
    if (index <= 0) return 0;
    if (hasMultiple && overlapStackWhenMultiple) {
      return index * overlapStackOffset;
    }
    var offset = 0.0;
    for (var i = 0; i < index; i++) {
      offset += _entries[i].height + spacing;
    }
    return offset;
  }

  void _onItemHeightChanged(_ToastStackItem item, double height) {
    final nextHeight = (height.isFinite ? height : 0).clamp(0, 4000).toDouble();
    if ((item.height - nextHeight).abs() < 0.5) return;
    item.height = nextHeight;
    _markAllNeedsBuild();
  }

  double _stackScaleFor(
    int index, {
    required bool hasMultiple,
    required bool overlapStackWhenMultiple,
  }) {
    if (!hasMultiple || !overlapStackWhenMultiple) return 1;
    final layersBehind = (_entries.length - 1 - index).clamp(0, 4);
    return 1 - (layersBehind * 0.025);
  }

  void _markAllNeedsBuild() {
    for (final item in _entries) {
      item.entry.markNeedsBuild();
    }
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

class _ToastStackItem {
  _ToastStackItem({required this.entry});

  final OverlayEntry entry;
  double height = 56;
  double shift = 0;
  double scale = 1;
  bool lockAutoDismiss = false;
}

class _ToastSizeObserver extends SingleChildRenderObjectWidget {
  const _ToastSizeObserver({required this.onSizeChanged, required super.child});

  final ValueChanged<Size> onSizeChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderToastSizeObserver(onSizeChanged);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderToastSizeObserver renderObject,
  ) {
    renderObject.onSizeChanged = onSizeChanged;
  }
}

class _RenderToastSizeObserver extends RenderProxyBox {
  _RenderToastSizeObserver(this.onSizeChanged);

  ValueChanged<Size> onSizeChanged;
  Size? _lastReportedSize;

  @override
  void performLayout() {
    super.performLayout();
    final currentSize = child?.size ?? size;
    if (_lastReportedSize == currentSize) return;
    _lastReportedSize = currentSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSizeChanged(currentSize);
    });
  }
}
