part of '../../toast.dart';

/// ToastEntry defines a reusable type for this registry module.
class ToastEntry extends StatefulWidget {
  /// Stores `child` state/configuration for this implementation.
  final Widget child;

  /// Stores `duration` state/configuration for this implementation.
  final Duration duration;

  /// Stores `animationDuration` state/configuration for this implementation.
  final Duration animationDuration;

  /// Stores `animationCurve` state/configuration for this implementation.
  final Curve animationCurve;

  /// Stores `onDismissed` state/configuration for this implementation.
  final VoidCallback onDismissed;

  /// Stores `pauseOnHover` state/configuration for this implementation.
  final bool pauseOnHover;

  /// Stores `dismissDirections` state/configuration for this implementation.
  final Set<ToastSwipeDirection> dismissDirections;

  /// Stores `dismissDragThreshold` state/configuration for this implementation.
  final double dismissDragThreshold;

  /// Stores `autoDismiss` state/configuration for this implementation.
  final bool autoDismiss;

  /// Stores `onInteractionStart` state/configuration for this implementation.
  final VoidCallback? onInteractionStart;

  /// Creates a `ToastEntry` instance.
  const ToastEntry({
    super.key,
    required this.child,
    required this.duration,
    required this.animationDuration,
    required this.animationCurve,
    required this.onDismissed,
    this.pauseOnHover = false,
    this.dismissDirections = const {},
    this.dismissDragThreshold = 72,
    this.autoDismiss = true,
    this.onInteractionStart,
  });

  @override
  /// Executes `createState` behavior for this component/composite.
  State<ToastEntry> createState() => _ToastEntryState();
}
