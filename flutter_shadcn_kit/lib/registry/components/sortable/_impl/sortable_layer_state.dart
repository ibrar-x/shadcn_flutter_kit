part of '../sortable.dart';

class _SortableLayerState extends State<SortableLayer>
    with SingleTickerProviderStateMixin {
  final MutableNotifier<List<_SortableDraggingSession>> _sessions =
      MutableNotifier([]);
  final MutableNotifier<List<_DropTransform>> _activeDrops =
      MutableNotifier([]);

  final ValueNotifier<_PendingDropTransform?> _pendingDrop =
      ValueNotifier(null);

  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
  }

  void ensureAndDismissDrop(Object data) {
    if (_pendingDrop.value != null && data == _pendingDrop.value!.data) {
      _pendingDrop.value = null;
    }
  }

  void dismissDrop() {
    _pendingDrop.value = null;
  }

  bool _canClaimDrop(_SortableState item, Object? data) {
    return _pendingDrop.value != null && data == _pendingDrop.value!.data;
  }

  _DropTransform? _claimDrop(_SortableState item, SortableData data,
      [bool force = false]) {
    if (_pendingDrop.value != null &&
        (force || data == _pendingDrop.value!.data)) {
      RenderBox layerRenderBox = context.findRenderObject() as RenderBox;
      RenderBox itemRenderBox = item.context.findRenderObject() as RenderBox;
      var dropTransform = _DropTransform(
        layer: this,
        from: _pendingDrop.value!.from,
        to: itemRenderBox.getTransformTo(layerRenderBox),
        child: _pendingDrop.value!.child,
        state: item,
      );
      _activeDrops.mutate((value) {
        value.add(dropTransform);
      });
      item._hasClaimedDrop.value = true;
      _pendingDrop.value = null;
      if (!_ticker.isActive) {
        _ticker.start();
      }
      return dropTransform;
    }
    return null;
  }

  void _tick(Duration elapsed) {
    List<_DropTransform> toRemove = [];
    for (final drop in _activeDrops.value) {
      drop.start ??= elapsed;
      double progress = ((elapsed - drop.start!).inMilliseconds /
              (widget.dropDuration ?? kDefaultDuration).inMilliseconds)
          .clamp(0, 1);
      progress = (widget.dropCurve ?? Curves.easeInOut).transform(progress);
      if (progress >= 1 || !drop.state.mounted) {
        drop.state._hasClaimedDrop.value = false;
        toRemove.add(drop);
      } else {
        drop.progress.value = progress;
      }
    }
    _activeDrops.mutate((value) {
      value.removeWhere((element) => toRemove.contains(element));
    });
    if (_activeDrops.value.isEmpty) {
      _ticker.stop();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  Matrix4 _tweenMatrix(Matrix4 from, Matrix4 to, double progress) {
    return Matrix4Tween(
      begin: from,
      end: to,
    ).transform(progress);
  }

  void pushDraggingSession(_SortableDraggingSession session) {
    _sessions.mutate(
      (value) {
        value.add(session);
      },
    );
  }

  void removeDraggingSession(_SortableDraggingSession session) {
    if (!mounted) {
      return;
    }
    if (_sessions.value.contains(session)) {
      _sessions.mutate((value) {
        value.remove(session);
      });
      if (widget.dropDuration != Duration.zero) {
        RenderBox? ghostRenderBox =
            session.key.currentContext?.findRenderObject() as RenderBox?;
        if (ghostRenderBox != null) {
          RenderBox layerRenderBox = context.findRenderObject() as RenderBox;
          _pendingDrop.value = _PendingDropTransform(
            from: ghostRenderBox.getTransformTo(layerRenderBox),
            child: SizedBox.fromSize(
              size: session.size,
              child: session.ghost,
            ),
            data: session.data,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MetaData(
      metaData: this,
      behavior: HitTestBehavior.translucent,
      child: Data.inherit(
        data: this,
        child: Stack(
          fit: StackFit.passthrough,
          clipBehavior:
              widget.clipBehavior ?? (widget.lock ? Clip.hardEdge : Clip.none),
          children: [
            widget.child,
            ListenableBuilder(
              listenable: _sessions,
              builder: (context, child) {
                return Positioned.fill(
                  child: MouseRegion(
                    opaque: false,
                    hitTestBehavior: HitTestBehavior.translucent,
                    cursor: _sessions.value.isNotEmpty
                        ? SystemMouseCursors.grabbing
                        : MouseCursor.defer,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        for (final session in _sessions.value)
                          ListenableBuilder(
                            listenable: session.offset,
                            builder: (context, child) {
                              return Positioned(
                                left: session.offset.value.dx,
                                top: session.offset.value.dy,
                                child: IgnorePointer(
                                  child: Transform(
                                    transform: session.transform,
                                    child: SizedBox.fromSize(
                                      key: session.key,
                                      size: session.size,
                                      child: session.ghost,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _activeDrops,
              builder: (context, child) {
                return Positioned.fill(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (final drop in _activeDrops.value)
                        ListenableBuilder(
                          listenable: drop.progress,
                          builder: (context, child) {
                            return IgnorePointer(
                              child: Transform(
                                transform: _tweenMatrix(
                                  drop.from,
                                  drop.to,
                                  drop.progress.value,
                                ),
                                child: drop.child,
                              ),
                            );
                          },
                        ),
                      child!,
                    ],
                  ),
                );
              },
              child: ListenableBuilder(
                listenable: _pendingDrop,
                builder: (context, child) {
                  if (_pendingDrop.value != null) {
                    return IgnorePointer(
                      child: Transform(
                        transform: _pendingDrop.value!.from,
                        child: _pendingDrop.value!.child,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A sortable layer that provides automatic scrolling during drag operations.
///
/// ScrollableSortableLayer extends the basic sortable functionality with automatic
/// scrolling when dragged items approach the edges of scrollable areas. This provides
/// a smooth user experience when dragging items in long lists or grids that extend
/// beyond the visible area.
///
/// The layer monitors drag positions and automatically scrolls the associated
/// scroll controller when the drag position comes within the configured threshold
/// of the scroll area edges. Scrolling speed is proportional to proximity to edges.
///
/// Features:
/// - Automatic scrolling when dragging near scroll area edges
/// - Configurable scroll threshold distance from edges
/// - Proportional scrolling speed based on proximity
/// - Optional overscroll support for scrolling beyond normal bounds
/// - Integrated with standard Flutter ScrollController
///
/// This layer should wrap scrollable widgets like ListView, GridView, or CustomScrollView
/// that contain sortable items. The scroll controller must be provided to enable
/// automatic scrolling functionality.
///
/// Example:
/// ```dart
/// ScrollController scrollController = ScrollController();
///
/// ScrollableSortableLayer(
///   controller: scrollController,
///   scrollThreshold: 80.0,
///   child: ListView.builder(
///     controller: scrollController,
///     itemBuilder: (context, index) => Sortable(...),
///   ),
/// )
/// ```
