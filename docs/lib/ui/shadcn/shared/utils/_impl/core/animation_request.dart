part of '../../animation_queue.dart';

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
