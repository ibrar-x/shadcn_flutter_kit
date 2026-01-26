part of '../drawer.dart';

enum OverlayPosition {
  /// Positioned on the left edge
  left,

  /// Positioned on the right edge
  right,

  /// Positioned on the top edge
  top,

  /// Positioned on the bottom edge
  bottom,

  /// Positioned at the start (left in LTR, right in RTL)
  start,

  /// Positioned at the end (right in LTR, left in RTL)
  end,
}

/// Scale factor for backdrop transform when drawer is open.
///
/// Constant value of 0.95 creates a subtle zoom-out effect on the
/// background content when overlays appear.
const kBackdropScaleDown = 0.95;

/// Data class containing backdrop transformation information.
///
/// Holds the size difference needed to scale and position backdrop
/// content when overlays are displayed.
