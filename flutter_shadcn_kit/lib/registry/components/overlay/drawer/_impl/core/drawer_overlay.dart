part of '../../drawer.dart';

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
