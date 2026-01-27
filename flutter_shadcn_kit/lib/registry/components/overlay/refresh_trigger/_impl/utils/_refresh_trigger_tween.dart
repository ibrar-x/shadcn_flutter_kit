part of '../../refresh_trigger.dart';

class _RefreshTriggerTween extends Animatable<double> {
  final double minExtent;

  const _RefreshTriggerTween(this.minExtent);

  @override
  double transform(double t) {
    return t / minExtent;
  }
}

/// State for the refresh trigger widget.
///
/// Manages the refresh lifecycle, gesture detection, and animation coordination
/// for pull-to-refresh functionality.
