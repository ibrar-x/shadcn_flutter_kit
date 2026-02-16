part of '../../toast.dart';

/// Controller that displays toast entries using Overlay.
class ToastController {
  /// Stores `_entries` state/configuration for this implementation.
  final List<_ToastStackItem> _entries = [];
  final Map<String, _ToastGroupState> _groups = {};

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
    bool? dismissWholeStackWhenMultiple,
    bool? pauseOnHover,
    Set<ToastSwipeDirection>? dismissDirections,
    double? dismissDragThreshold,
    double? top,
    double? right,
    double? bottom,
    double? left,
  }) {
    final overlay = Overlay.of(context);
    final groupKey = _groupKey(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
    );

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
        final resolvedMaxVisibleCount =
            (maxVisibleCount ?? toastTheme?.maxVisibleCount ?? 0).clamp(0, 999);
        final resolvedDismissWholeStackWhenMultiple =
            dismissWholeStackWhenMultiple ??
            toastTheme?.dismissWholeStackWhenMultiple ??
            false;
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

        final groupEntries = _groupEntries(groupKey);
        final hasMultipleGroup = groupEntries.length > 1;
        if (resolvedPauseAutoDismissWhenMultiple && hasMultipleGroup) {
          for (final item in groupEntries) {
            item.lockAutoDismiss = true;
          }
        }

        final visibleEntries = _visibleEntries(
          groupEntries,
          resolvedMaxVisibleCount,
        );
        final visibleIndex = visibleEntries.indexOf(stackItem);
        final isVisible = visibleIndex != -1;
        if (!isVisible) {
          return const SizedBox.shrink();
        }

        final totalOffset = _stackOffsetForVisible(
          visibleEntries,
          visibleIndex,
          resolvedSpacing,
          overlapStackWhenMultiple: resolvedOverlapStackWhenMultiple,
          overlapStackOffset: resolvedOverlapStackOffset,
        );

        /// Stores `foregroundColor` state/configuration for this implementation.
        final foregroundColor = theme.colorScheme.foreground;
        final isBottomStack = bottom != null;
        final targetShift = isBottomStack ? -totalOffset : totalOffset;
        final targetScale = _stackScaleFor(
          visibleEntries,
          visibleIndex,
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

        final groupState = _groups.putIfAbsent(groupKey, _ToastGroupState.new);
        final groupExpanded = hasMultipleGroup && groupState.expanded;
        final autoDismissEnabled =
            !(resolvedPauseAutoDismissWhenMultiple &&
                (hasMultipleGroup || stackItem.lockAutoDismiss));

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
            onInteractionStart: hasMultipleGroup
                ? () => _setGroupInteraction(groupKey, true)
                : null,
            onInteractionEnd: hasMultipleGroup
                ? () => _setGroupInteraction(groupKey, false)
                : null,
            onTap: hasMultipleGroup
                ? () => _toggleGroupExpanded(groupKey)
                : null,
            dismissDirections: resolvedDismissDirections,
            dismissDragThreshold: resolvedDismissDragThreshold,
            onDismissed: () {
              _handleDismissed(
                stackItem,
                dismissWholeStackWhenMultiple:
                    resolvedDismissWholeStackWhenMultiple,
              );
            },
            child: _ToastSizeObserver(
              onSizeChanged: (size) {
                _onItemHeightChanged(stackItem, size.height);
              },
              child: ToastStackScope(
                data: ToastStackContext(
                  expanded: groupExpanded,
                  hasMultiple: hasMultipleGroup,
                  visibleCount: visibleEntries.length,
                  toggleExpanded: () => _toggleGroupExpanded(groupKey),
                  dismissAll: () => _dismissGroup(groupKey),
                ),
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
    stackItem = _ToastStackItem(entry: entry, groupKey: groupKey);
    _entries.add(stackItem);
    _markAllNeedsBuild();
    overlay.insert(entry);
  }

  void _handleDismissed(
    _ToastStackItem item, {
    required bool dismissWholeStackWhenMultiple,
  }) {
    final groupEntries = _groupEntries(item.groupKey);
    final hadMultiple = groupEntries.length > 1;
    _removeItem(item);
    if (dismissWholeStackWhenMultiple && hadMultiple) {
      _dismissGroup(item.groupKey);
    }
    _cleanupGroup(item.groupKey);
    _markAllNeedsBuild();
  }

  void _removeItem(_ToastStackItem item) {
    if (_entries.remove(item)) {
      item.entry.remove();
    }
  }

  void _dismissGroup(String groupKey) {
    final items = List<_ToastStackItem>.from(_groupEntries(groupKey));
    for (final item in items) {
      _removeItem(item);
    }
    _groups.remove(groupKey);
  }

  List<_ToastStackItem> _groupEntries(String groupKey) {
    return _entries.where((item) => item.groupKey == groupKey).toList();
  }

  List<_ToastStackItem> _visibleEntries(
    List<_ToastStackItem> groupEntries,
    int maxVisibleCount,
  ) {
    if (maxVisibleCount <= 0 || groupEntries.length <= maxVisibleCount) {
      return groupEntries;
    }
    return groupEntries.sublist(groupEntries.length - maxVisibleCount);
  }

  double _stackOffsetForVisible(
    List<_ToastStackItem> visibleEntries,
    int visibleIndex,
    double spacing, {
    required bool overlapStackWhenMultiple,
    required double overlapStackOffset,
  }) {
    if (visibleIndex <= 0) return 0;
    if (overlapStackWhenMultiple && visibleEntries.length > 1) {
      return visibleIndex * overlapStackOffset;
    }
    var offset = 0.0;
    for (var i = 0; i < visibleIndex; i++) {
      offset += visibleEntries[i].height + spacing;
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
    List<_ToastStackItem> visibleEntries,
    int visibleIndex, {
    required bool overlapStackWhenMultiple,
  }) {
    if (!overlapStackWhenMultiple || visibleEntries.length <= 1) return 1;
    final layersBehind = (visibleEntries.length - 1 - visibleIndex).clamp(0, 4);
    return 1 - (layersBehind * 0.025);
  }

  void _setGroupInteraction(String groupKey, bool active) {
    final state = _groups.putIfAbsent(groupKey, _ToastGroupState.new);
    final previousExpanded = state.expanded;
    if (active) {
      state.activeInteractions++;
    } else {
      state.activeInteractions = (state.activeInteractions - 1).clamp(0, 999);
    }
    if (previousExpanded != state.expanded) {
      _markGroupNeedsBuild(groupKey);
    }
  }

  void _toggleGroupExpanded(String groupKey) {
    final state = _groups.putIfAbsent(groupKey, _ToastGroupState.new);
    state.pinnedExpanded = !state.pinnedExpanded;
    _markGroupNeedsBuild(groupKey);
  }

  void _markGroupNeedsBuild(String groupKey) {
    for (final item in _entries) {
      if (item.groupKey == groupKey) {
        item.entry.markNeedsBuild();
      }
    }
  }

  void _cleanupGroup(String groupKey) {
    if (_groupEntries(groupKey).isEmpty) {
      _groups.remove(groupKey);
    }
  }

  void _markAllNeedsBuild() {
    for (final item in _entries) {
      item.entry.markNeedsBuild();
    }
  }

  String _groupKey({
    required double? top,
    required double? right,
    required double? bottom,
    required double? left,
  }) {
    String encode(double? value) =>
        value == null ? 'n' : value.toStringAsFixed(1);
    return 't:${encode(top)}|r:${encode(right)}|b:${encode(bottom)}|l:${encode(left)}';
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

class _ToastGroupState {
  bool pinnedExpanded = false;
  int activeInteractions = 0;

  bool get expanded => pinnedExpanded || activeInteractions > 0;
}

class _ToastStackItem {
  _ToastStackItem({required this.entry, required this.groupKey});

  final OverlayEntry entry;
  final String groupKey;
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
