import 'package:flutter/widgets.dart';

/// Animation request payload for queue-driven animations.
class AnimationRequest {
  /// The target value to animate to.
  final double target;

  /// The duration of the animation.
  final Duration duration;

  /// The easing curve to apply during the animation.
  final Curve curve;

  /// Creates an animation request with the specified parameters.
  AnimationRequest(this.target, this.duration, this.curve);
}

class _AnimationRunner {
  final double from;
  final double to;
  final Duration duration;
  final Curve curve;

  double _progress = 0.0;

  _AnimationRunner(this.from, this.to, this.duration, this.curve);
}

/// Queue-based animation controller used by carousel transitions.
class AnimationQueueController extends ChangeNotifier {
  double _value;

  /// Creates an animation queue controller with an optional initial value.
  AnimationQueueController([this._value = 0.0]);

  List<AnimationRequest> _requests = [];
  _AnimationRunner? _runner;

  /// Adds an animation request to the queue or replaces the current queue.
  void push(AnimationRequest request, [bool queue = true]) {
    if (queue) {
      _requests.add(request);
    } else {
      _runner = null;
      _requests = [request];
    }
    _runner ??= _AnimationRunner(
      _value,
      request.target,
      request.duration,
      request.curve,
    );
    notifyListeners();
  }

  /// Sets the current value immediately and clears queued animations.
  set value(double value) {
    _value = value;
    _runner = null;
    _requests.clear();
    notifyListeners();
  }

  /// Returns the current value.
  double get value => _value;

  /// Whether there are pending animations to tick.
  bool get shouldTick => _runner != null || _requests.isNotEmpty;

  /// Advances the animation by the given delta.
  void tick(Duration delta) {
    if (_requests.isNotEmpty) {
      final request = _requests.removeAt(0);
      _runner = _AnimationRunner(
        _value,
        request.target,
        request.duration,
        request.curve,
      );
    }
    final runner = _runner;
    if (runner != null) {
      runner._progress +=
          delta.inMilliseconds / runner.duration.inMilliseconds;
      _value = runner.from +
          (runner.to - runner.from) *
              runner.curve.transform(runner._progress.clamp(0, 1));
      if (runner._progress >= 1.0) {
        _runner = null;
      }
      notifyListeners();
    }
  }
}
