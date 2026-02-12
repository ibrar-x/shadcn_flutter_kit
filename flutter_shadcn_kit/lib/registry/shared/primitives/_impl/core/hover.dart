part of '../../hover.dart';

/// Hover defines a reusable type for this registry module.
class Hover extends StatefulWidget {
/// Stores `child` state/configuration for this implementation.
  final Widget child;
/// Stores `waitDuration` state/configuration for this implementation.
  final Duration? waitDuration;
/// Stores `minDuration` state/configuration for this implementation.
  final Duration? minDuration;
/// Stores `showDuration` state/configuration for this implementation.
  final Duration? showDuration;
/// Stores `onHover` state/configuration for this implementation.
  final ValueChanged<bool>? onHover;

/// Creates a `Hover` instance.
  const Hover({
    super.key,
    required this.child,
    this.waitDuration,
    this.minDuration,
    this.showDuration,
    this.onHover,
  });

  @override
/// Executes `createState` behavior for this component/composite.
  State<Hover> createState() => _HoverState();
}
