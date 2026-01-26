part of '../drawer.dart';

class DrawerLayerData {
  /// The drawer overlay state for this layer.
  final DrawerOverlayState overlay;

  /// The parent drawer layer, null if this is the root layer.
  final DrawerLayerData? parent;

  /// Creates drawer layer data.
  ///
  /// Parameters:
  /// - [overlay] (DrawerOverlayState, required): Overlay state for this layer
  /// - [parent] (DrawerLayerData?): Parent layer in the hierarchy
  const DrawerLayerData(this.overlay, this.parent);

  /// Computes the size of this drawer layer.
  ///
  /// Delegates to the overlay state to calculate the layer dimensions.
  ///
  /// Returns the computed size or null if not available.
  Size? computeSize() {
    return overlay.computeSize();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DrawerLayerData &&
        other.overlay == overlay &&
        other.parent == parent;
  }

  @override
  int get hashCode {
    return overlay.hashCode ^ parent.hashCode;
  }
}

/// Widget that manages drawer overlay layers.
///
/// Provides a container for drawer overlays, managing their lifecycle and
/// hierarchical relationships. Supports nested drawers through layer data
/// propagation.
///
/// Example:
/// ```dart
/// DrawerOverlay(
///   child: MyAppContent(),
/// )
/// ```
