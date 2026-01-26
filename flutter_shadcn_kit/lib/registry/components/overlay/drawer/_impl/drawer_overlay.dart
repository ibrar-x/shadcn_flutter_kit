part of '../drawer.dart';

class DrawerOverlay extends StatefulWidget {
  static DrawerLayerData? _currentLayer;

  static void _registerLayer(DrawerLayerData layer) {
    _currentLayer = layer;
  }

  static void _clearLayer(DrawerLayerData layer) {
    if (_currentLayer == layer) {
      _currentLayer = layer.parent;
    }
  }

  static DrawerLayerData? get currentLayer => _currentLayer;

  /// Child widget displayed under the overlay layer.
  final Widget child;

  /// Creates a drawer overlay.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Content widget
  const DrawerOverlay({super.key, required this.child});

  @override
  State<DrawerOverlay> createState() => DrawerOverlayState();

  /// Finds the drawer layer data from the widget tree.
  ///
  /// Searches up the widget tree for the nearest [DrawerLayerData].
  /// Optionally navigates to the root layer if [root] is true.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [root] (bool): Whether to find root layer, defaults to false
  ///
  /// Returns [DrawerLayerData] or null if not found.
  static DrawerLayerData? maybeFind(BuildContext context, [bool root = false]) {
    var data = Data.maybeFind<DrawerLayerData>(context);
    if (root) {
      while (data?.parent != null) {
        data = data!.parent;
      }
    }
    return data;
  }

  /// Finds the drawer layer data using messenger lookup.
  ///
  /// Similar to [maybeFind] but uses the messenger mechanism for lookup.
  /// Optionally navigates to the root layer if [root] is true.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [root] (bool): Whether to find root layer, defaults to false
  ///
  /// Returns [DrawerLayerData] or null if not found.
  static DrawerLayerData? maybeFindMessenger(BuildContext context,
      [bool root = false]) {
    var data = Data.maybeFindMessenger<DrawerLayerData>(context);
    if (root) {
      while (data?.parent != null) {
        data = data!.parent;
      }
    }
    return data;
  }
}

/// State class for [DrawerOverlay] managing drawer entry lifecycle.
///
/// Manages the stack of active drawer overlays, handling their addition,
/// removal, and size computation. Maintains a backdrop key for managing
/// backdrop transformations.
class DrawerOverlayState extends State<DrawerOverlay> {
  DrawerLayerData? _layerData;

  final List<DrawerOverlayEntry> _entries = [];

  /// Key for the backdrop widget to enable transformations.
  final GlobalKey backdropKey = GlobalKey();

  /// Adds a drawer overlay entry to the list of active entries.
  ///
  /// Updates the widget state to include the new entry, triggering a rebuild
  /// to display the drawer overlay.
  ///
  /// Parameters:
  /// - [entry] (`DrawerOverlayEntry`, required): The drawer entry to add.
  ///
  /// Example:
  /// ```dart
  /// final entry = DrawerOverlayEntry(
  ///   builder: (context) => MyDrawerContent(),
  /// );
  /// drawerState.addEntry(entry);
  /// ```
  void addEntry(DrawerOverlayEntry entry) {
    setState(() {
      _entries.add(entry);
    });
  }

  /// Computes the size of the drawer overlay area.
  ///
  /// Returns the size of the overlay's render box. Used for positioning
  /// and sizing drawer content.
  ///
  /// Throws [AssertionError] if overlay is not ready (no size available).
  ///
  /// Returns [Size] of the overlay area.
  Size computeSize() {
    Size? size = context.size;
    assert(size != null, 'DrawerOverlay is not ready');
    return size!;
  }

  /// Removes a drawer entry from the overlay stack.
  ///
  /// Triggers a rebuild to update the overlay display after removing
  /// the specified entry.
  ///
  /// Parameters:
  /// - [entry] (DrawerOverlayEntry, required): Entry to remove
  void removeEntry(DrawerOverlayEntry entry) {
    if (mounted) {
      setState(() {
        _entries.remove(entry);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final parentLayer = Data.maybeOf<DrawerLayerData>(context);
    _layerData = DrawerLayerData(this, parentLayer);
    DrawerOverlay._registerLayer(_layerData!);
    Widget child = KeyedSubtree(
      key: backdropKey,
      child: widget.child,
    );
    int index = 0;
    for (final entry in _entries) {
      child = DrawerEntryWidget(
        key: entry.key, // to make the overlay state persistent
        builder: entry.builder,
        backdrop: child,
        barrierBuilder: entry.barrierBuilder,
        modal: entry.modal,
        themes: entry.themes,
        completer: entry.completer,
        position: entry.position,
        backdropBuilder: entry.backdropBuilder,
        animationController: entry.animationController,
        stackIndex: index++,
        totalStack: _entries.length,
        data: entry.data,
        useSafeArea: entry.useSafeArea,
        autoOpen: entry.autoOpen,
      );
    }
    return PopScope(
      // prevent from popping when there is an overlay
      // instead, the overlay should be closed first
      // once everything is closed, then this can be popped
      canPop: _entries.isEmpty,
      onPopInvokedWithResult: (didPop, result) {
        if (_entries.isNotEmpty) {
          var last = _entries.last;
          if (last.barrierDismissible) {
            var state = last.key.currentState;
            if (state != null) {
              state.close(result);
            } else {
              last.completer.complete(result);
            }
          }
        }
      },
      child: ForwardableData(
        data: _layerData!,
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    if (_layerData != null) {
      DrawerOverlay._clearLayer(_layerData!);
    }
    super.dispose();
  }
}

/// Widget representing a single drawer entry in the overlay stack.
///
/// Manages the lifecycle and rendering of an individual drawer overlay,
/// including its backdrop, barrier, and animated transitions.
