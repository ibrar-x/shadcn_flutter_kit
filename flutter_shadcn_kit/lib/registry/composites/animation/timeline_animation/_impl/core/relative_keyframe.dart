part of '../../timeline_animation.dart';

class RelativeKeyframe<T> implements Keyframe<T> {
  final T target;
  @override
  final Duration duration;

  const RelativeKeyframe(this.duration, this.target);

  @override
  T compute(TimelineAnimation<T> timeline, int index, double t) {
    if (index <= 0) {
      return target;
    }
    final previous = timeline.keyframes[index - 1]
        .compute(timeline, index - 1, 1.0);
    return timeline.lerp(previous, target, t) as T;
  }
}

/// Holds a value without animating.
