import 'package:flutter/gestures.dart';

/// DesktopPointerScrollEvent defines a reusable type for this registry module.
class DesktopPointerScrollEvent extends PointerScrollEvent {
/// Creates a `DesktopPointerScrollEvent` instance.
  const DesktopPointerScrollEvent({
    required super.position,
    required super.device,
    required super.embedderId,
    required super.kind,
    required super.timeStamp,
    required super.viewId,
    required super.scrollDelta,
  });
}
