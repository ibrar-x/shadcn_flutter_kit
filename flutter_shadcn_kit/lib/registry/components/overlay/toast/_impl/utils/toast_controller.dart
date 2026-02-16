part of '../../toast.dart';

const Duration _kCollapseHoverCooldown = Duration(milliseconds: 900);

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
        final isBottomStack = bottom != null;
        final resolvedTop = top ?? (isBottomStack ? null : 32);
        final resolvedBottom = bottom;
        final resolvedLeft = left;
        final resolvedRight = right ?? (left == null ? 24 : null);

        final groupState = _groups.putIfAbsent(groupKey, _ToastGroupState.new);
        final groupEntries = _groupEntries(groupKey);
        groupState
          ..anchorTop = resolvedTop
          ..anchorRight = resolvedRight
          ..anchorBottom = resolvedBottom
          ..anchorLeft = resolvedLeft
          ..panelWidth = _groupMaxWidth(groupEntries);
        final hasMultipleGroup = groupEntries.length > 1;
        final groupExpanded =
            hasMultipleGroup &&
            (groupState.expanded || groupState.holdExpandedDuringDismiss);
        final overlapForLayout =
            resolvedOverlapStackWhenMultiple && !groupExpanded;
        if (resolvedPauseAutoDismissWhenMultiple && hasMultipleGroup) {
          for (final item in groupEntries) {
            item.lockAutoDismiss = true;
          }
        }
        _syncGroupBackdrop(
          groupKey,
          overlay,
          groupExpanded && hasMultipleGroup,
        );

        late final List<_ToastStackItem> visibleEntries;
        late final int visibleIndex;
        late final bool isVisible;
        late final double totalOffset;
        late final double targetScale;
        if (groupExpanded) {
          visibleEntries = _orderedEntries(groupEntries);
          visibleIndex = visibleEntries.indexOf(stackItem);
          if (visibleIndex == -1) {
            return const SizedBox.shrink();
          }
          final viewportExtent = _expandedViewportExtent(
            overlayContext,
            top: resolvedTop,
            bottom: resolvedBottom,
          );
          groupState
            ..viewportExtent = viewportExtent
            ..itemSpacing = resolvedSpacing;
          var logicalOffset = 0.0;
          for (var i = 0; i < visibleIndex; i++) {
            logicalOffset += visibleEntries[i].height + resolvedSpacing;
          }
          var totalContentHeight = 0.0;
          for (var i = 0; i < visibleEntries.length; i++) {
            totalContentHeight += visibleEntries[i].height;
            if (i < visibleEntries.length - 1) {
              totalContentHeight += resolvedSpacing;
            }
          }
          final maxScroll = (totalContentHeight - viewportExtent)
              .clamp(0.0, 100000.0)
              .toDouble();
          groupState.maxScroll = maxScroll;
          if (groupState.scrollTargetOffset > maxScroll) {
            groupState.scrollTargetOffset = maxScroll;
          }
          if (groupState.scrollOffset > maxScroll) {
            groupState.scrollOffset = maxScroll;
          }
          final visibleTop = logicalOffset - groupState.scrollOffset;
          final visibleBottom = visibleTop + stackItem.height;
          isVisible = visibleBottom >= -8 && visibleTop <= viewportExtent + 8;
          totalOffset = visibleTop;
          targetScale = 1;
        } else {
          visibleEntries = _visibleEntries(
            groupEntries,
            resolvedMaxVisibleCount,
          );
          visibleIndex = visibleEntries.indexOf(stackItem);
          isVisible = visibleIndex != -1;
          if (isVisible) {
            totalOffset = _stackOffsetForVisible(
              visibleEntries,
              visibleIndex,
              resolvedSpacing,
              overlapStackWhenMultiple: overlapForLayout,
              overlapStackOffset: resolvedOverlapStackOffset,
            );
            targetScale = _stackScaleFor(
              visibleEntries,
              visibleIndex,
              overlapStackWhenMultiple: overlapForLayout,
            );
          } else {
            totalOffset = 0;
            targetScale = 1;
          }
          groupState
            ..scrollOffset = 0
            ..scrollTargetOffset = 0
            ..maxScroll = 0
            ..viewportExtent = 0;
        }
        if (!isVisible) {
          return const SizedBox.shrink();
        }

        /// Stores `foregroundColor` state/configuration for this implementation.
        final foregroundColor = theme.colorScheme.foreground;
        final targetShift = isBottomStack ? -totalOffset : totalOffset;
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
            onTap: hasMultipleGroup && !groupExpanded
                ? () => _toggleGroupExpanded(groupKey)
                : null,
            dismissSignal: stackItem.dismissSignal,
            onPointerScroll: groupExpanded
                ? (delta) => _scrollGroup(groupKey, delta)
                : null,
            onDismissRequest: () {
              final shouldDismissWholeStack =
                  resolvedDismissWholeStackWhenMultiple &&
                  hasMultipleGroup &&
                  !groupExpanded;
              if (!shouldDismissWholeStack) return false;
              _dismissGroupAnimated(groupKey, visibleEntries: visibleEntries);
              return true;
            },
            dismissDirections: groupExpanded
                ? const {
                    ToastSwipeDirection.up,
                    ToastSwipeDirection.down,
                    ToastSwipeDirection.left,
                    ToastSwipeDirection.right,
                  }
                : resolvedDismissDirections,
            dismissDragThreshold: resolvedDismissDragThreshold,
            onDismissed: () {
              if (stackItem.pendingGroupDismiss) {
                _removeItem(stackItem);
                _cleanupGroup(groupKey);
                _markAllNeedsBuild();
                return;
              }
              _removeItem(stackItem);
              _cleanupGroup(groupKey);
              _markAllNeedsBuild();
            },
            child: _ToastSizeObserver(
              onSizeChanged: (size) {
                _onItemSizeChanged(stackItem, size);
              },
              child: ToastStackScope(
                data: ToastStackContext(
                  expanded: groupExpanded,
                  hasMultiple: hasMultipleGroup,
                  visibleCount: visibleEntries.length,
                  isPrimary: visibleIndex == 0,
                  toggleExpanded: () => _toggleGroupExpanded(groupKey),
                  setExpanded: (expanded) => _setGroupExpanded(
                    groupKey,
                    expanded,
                    clearInteractions: !expanded,
                  ),
                  dismissAll: () => _dismissGroupAnimated(
                    groupKey,
                    visibleEntries: visibleEntries,
                  ),
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

  void _removeItem(_ToastStackItem item) {
    if (_entries.remove(item)) {
      item.entry.remove();
    }
  }

  void _dismissGroupAnimated(
    String groupKey, {
    List<_ToastStackItem>? visibleEntries,
  }) {
    final state = _groups.putIfAbsent(groupKey, _ToastGroupState.new);
    if (state.dismissing) return;
    final shouldHoldExpanded =
        state.viewportExtent > 0 && visibleEntries != null;
    state
      ..dismissing = true
      ..pinnedExpanded = shouldHoldExpanded
      ..holdExpandedDuringDismiss = shouldHoldExpanded
      ..activeInteractions = 0;
    _stopScrollAnimation(state);
    if (!shouldHoldExpanded) {
      _removeBackdrop(state);
    }

    final items = List<_ToastStackItem>.from(_groupEntries(groupKey));
    if (items.isEmpty) {
      _groups.remove(groupKey);
      return;
    }

    if (visibleEntries == null) {
      for (final item in items) {
        _removeItem(item);
      }
      _stopScrollAnimation(state);
      _removeBackdrop(state);
      _groups.remove(groupKey);
      _markAllNeedsBuild();
      return;
    }

    List<_ToastStackItem> animatedItems;
    if (state.viewportExtent > 0) {
      animatedItems = _expandedViewportItems(
        items,
        state.scrollOffset,
        state.viewportExtent,
        state.itemSpacing,
      );
    } else {
      animatedItems = items
          .where((item) => visibleEntries.contains(item))
          .toList();
    }
    for (final item in items) {
      if (animatedItems.contains(item)) {
        if (item.pendingGroupDismiss) continue;
        item.pendingGroupDismiss = true;
        item.dismissSignal += 1;
        item.entry.markNeedsBuild();
      } else {
        _removeItem(item);
      }
    }
    _cleanupGroup(groupKey);
    _markAllNeedsBuild();
  }

  List<_ToastStackItem> _groupEntries(String groupKey) {
    return _entries.where((item) => item.groupKey == groupKey).toList();
  }

  List<_ToastStackItem> _visibleEntries(
    List<_ToastStackItem> groupEntries,
    int maxVisibleCount,
  ) {
    final ordered = _orderedEntries(groupEntries);
    if (maxVisibleCount <= 0 || ordered.length <= maxVisibleCount) {
      return ordered;
    }
    return ordered.take(maxVisibleCount).toList();
  }

  List<_ToastStackItem> _orderedEntries(List<_ToastStackItem> groupEntries) {
    return groupEntries.reversed.toList();
  }

  List<_ToastStackItem> _expandedViewportItems(
    List<_ToastStackItem> groupEntries,
    double scrollOffset,
    double viewportExtent,
    double spacing,
  ) {
    final ordered = _orderedEntries(groupEntries);
    final animated = <_ToastStackItem>[];
    var logicalOffset = 0.0;
    for (final item in ordered) {
      final visibleTop = logicalOffset - scrollOffset;
      final visibleBottom = visibleTop + item.height;
      if (visibleBottom >= -8 && visibleTop <= viewportExtent + 8) {
        animated.add(item);
      }
      logicalOffset += item.height + spacing;
    }
    return animated;
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

  double _groupMaxWidth(List<_ToastStackItem> groupEntries) {
    var maxWidth = 0.0;
    for (final item in groupEntries) {
      if (item.width > maxWidth) {
        maxWidth = item.width;
      }
    }
    return maxWidth;
  }

  void _onItemSizeChanged(_ToastStackItem item, Size size) {
    final nextHeight = (size.height.isFinite ? size.height : 0)
        .clamp(0, 4000)
        .toDouble();
    final nextWidth = (size.width.isFinite ? size.width : 0)
        .clamp(0, 4000)
        .toDouble();
    if ((item.height - nextHeight).abs() < 0.5 &&
        (item.width - nextWidth).abs() < 0.5) {
      return;
    }
    item
      ..height = nextHeight
      ..width = nextWidth;
    _markAllNeedsBuild();
  }

  double _stackScaleFor(
    List<_ToastStackItem> visibleEntries,
    int visibleIndex, {
    required bool overlapStackWhenMultiple,
  }) {
    if (!overlapStackWhenMultiple || visibleEntries.length <= 1) return 1;
    final layersBehind = visibleIndex.clamp(0, 4);
    return 1 - (layersBehind * 0.025);
  }

  void _setGroupInteraction(String groupKey, bool active) {
    final state = _groups.putIfAbsent(groupKey, _ToastGroupState.new);
    if (state.dismissing) return;
    if (active &&
        state.interactionCooldownUntil != null &&
        state.interactionCooldownUntil!.isAfter(DateTime.now())) {
      return;
    }
    final previousExpanded = state.expanded;
    if (active) {
      state.activeInteractions++;
      // Keep the whole stack expanded after first hover/tap until explicitly
      // collapsed by control.
      state.pinnedExpanded = true;
    } else {
      state.activeInteractions = (state.activeInteractions - 1).clamp(0, 999);
    }
    if (previousExpanded != state.expanded) {
      _markGroupNeedsBuild(groupKey);
    }
  }

  void _toggleGroupExpanded(String groupKey) {
    final state = _groups.putIfAbsent(groupKey, _ToastGroupState.new);
    if (state.dismissing) return;
    state.holdExpandedDuringDismiss = false;
    state.pinnedExpanded = !state.pinnedExpanded;
    if (!state.pinnedExpanded) {
      _stopScrollAnimation(state);
      state
        ..scrollOffset = 0
        ..scrollTargetOffset = 0
        ..maxScroll = 0
        ..interactionCooldownUntil = DateTime.now().add(
          _kCollapseHoverCooldown,
        );
    }
    _markGroupNeedsBuild(groupKey);
  }

  void _setGroupExpanded(
    String groupKey,
    bool expanded, {
    bool clearInteractions = false,
  }) {
    final state = _groups.putIfAbsent(groupKey, _ToastGroupState.new);
    if (state.dismissing) return;
    state.holdExpandedDuringDismiss = false;
    state.pinnedExpanded = expanded;
    if (clearInteractions) {
      state.activeInteractions = 0;
    }
    if (!expanded) {
      _stopScrollAnimation(state);
      state
        ..scrollOffset = 0
        ..scrollTargetOffset = 0
        ..maxScroll = 0
        ..interactionCooldownUntil = DateTime.now().add(
          _kCollapseHoverCooldown,
        );
    }
    _markGroupNeedsBuild(groupKey);
  }

  void _scrollGroup(String groupKey, double delta) {
    final state = _groups[groupKey];
    if (state == null || !state.expanded || state.dismissing) return;
    if (state.maxScroll <= 0) return;
    final next = (state.scrollTargetOffset + delta)
        .clamp(0.0, state.maxScroll)
        .toDouble();
    if ((next - state.scrollTargetOffset).abs() < 0.5) return;
    state.scrollTargetOffset = next;
    _ensureScrollAnimation(groupKey, state);
  }

  void _ensureScrollAnimation(String groupKey, _ToastGroupState state) {
    if (state.scrollTimer != null) return;
    state.scrollTimer = Timer.periodic(const Duration(milliseconds: 16), (
      timer,
    ) {
      final current = _groups[groupKey];
      if (current == null || !current.expanded || current.dismissing) {
        timer.cancel();
        if (current != null) {
          current.scrollTimer = null;
        }
        return;
      }
      final delta = current.scrollTargetOffset - current.scrollOffset;
      if (delta.abs() < 0.35) {
        current.scrollOffset = current.scrollTargetOffset;
        timer.cancel();
        current.scrollTimer = null;
        _markGroupNeedsBuild(groupKey);
        return;
      }
      current.scrollOffset += delta * 0.24;
      _markGroupNeedsBuild(groupKey);
    });
  }

  void _stopScrollAnimation(_ToastGroupState state) {
    state.scrollTimer?.cancel();
    state.scrollTimer = null;
  }

  void _syncGroupBackdrop(
    String groupKey,
    OverlayState overlay,
    bool shouldShow,
  ) {
    final state = _groups.putIfAbsent(groupKey, _ToastGroupState.new);
    state.desiredBackdropVisible = shouldShow;
    if (state.backdropMutationScheduled) {
      return;
    }
    state.backdropMutationScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final current = _groups[groupKey];
      if (current == null) {
        _removeBackdrop(state);
        return;
      }
      current.backdropMutationScheduled = false;
      if (!current.desiredBackdropVisible) {
        _removeBackdrop(current);
        return;
      }
      if (current.backdropEntry != null) return;
      final groupEntries = _groupEntries(groupKey);
      if (groupEntries.isEmpty) return;
      final entry = OverlayEntry(
        builder: (context) {
          return Positioned.fill(
            child: Listener(
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  _scrollGroup(groupKey, event.scrollDelta.dy);
                }
              },
              child: Stack(
                children: [
                  _buildGroupBackdropBlur(current),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => _setGroupExpanded(
                      groupKey,
                      false,
                      clearInteractions: true,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ],
              ),
            ),
          );
        },
      );
      current.backdropEntry = entry;
      overlay.insert(entry, below: groupEntries.first.entry);
    });
  }

  void _removeBackdrop(_ToastGroupState state) {
    state.desiredBackdropVisible = false;
    state.backdropEntry?.remove();
    state.backdropEntry = null;
  }

  Widget _buildGroupBackdropBlur(_ToastGroupState state) {
    if (state.panelWidth <= 0 || state.viewportExtent <= 0) {
      return const SizedBox.shrink();
    }
    final left = state.anchorLeft;
    final right = state.anchorRight;
    final top = state.anchorTop;
    final bottom = state.anchorBottom;
    final horizontalPad = 14.0;
    final verticalPad = 12.0;
    final panelHeight = state.viewportExtent + verticalPad * 2;

    return Positioned(
      top: top == null
          ? null
          : (top - verticalPad).clamp(0.0, 4000.0).toDouble(),
      bottom: bottom == null
          ? null
          : (bottom - verticalPad).clamp(0.0, 4000.0).toDouble(),
      left: left == null
          ? null
          : (left - horizontalPad).clamp(0.0, 4000.0).toDouble(),
      right: right == null
          ? null
          : (right - horizontalPad).clamp(0.0, 4000.0).toDouble(),
      width: (state.panelWidth + horizontalPad * 2)
          .clamp(120.0, 3000.0)
          .toDouble(),
      height: panelHeight.clamp(120.0, 3000.0).toDouble(),
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0x2AFFFFFF), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x28000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
              child: ColoredBox(color: const Color(0x12000000)),
            ),
          ),
        ),
      ),
    );
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
      final state = _groups[groupKey];
      if (state != null) {
        _stopScrollAnimation(state);
        _removeBackdrop(state);
      }
      _groups.remove(groupKey);
    }
  }

  double _expandedViewportExtent(
    BuildContext context, {
    required double? top,
    required double? bottom,
  }) {
    final media = MediaQuery.maybeOf(context);
    final height = media?.size.height ?? 900;
    final edgeInset = 20.0;
    final available = height - (top ?? 0) - (bottom ?? 0) - edgeInset;
    return available.clamp(220.0, 560.0).toDouble();
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
  bool holdExpandedDuringDismiss = false;
  int activeInteractions = 0;
  bool dismissing = false;
  double scrollOffset = 0;
  double scrollTargetOffset = 0;
  double maxScroll = 0;
  double viewportExtent = 0;
  double itemSpacing = 8;
  double? anchorTop;
  double? anchorRight;
  double? anchorBottom;
  double? anchorLeft;
  double panelWidth = 0;
  Timer? scrollTimer;
  OverlayEntry? backdropEntry;
  bool desiredBackdropVisible = false;
  bool backdropMutationScheduled = false;
  DateTime? interactionCooldownUntil;

  bool get expanded => pinnedExpanded || activeInteractions > 0;
}

class _ToastStackItem {
  _ToastStackItem({required this.entry, required this.groupKey});

  final OverlayEntry entry;
  final String groupKey;
  double height = 56;
  double width = 0;
  double shift = 0;
  double scale = 1;
  bool lockAutoDismiss = false;
  int dismissSignal = 0;
  bool pendingGroupDismiss = false;
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
