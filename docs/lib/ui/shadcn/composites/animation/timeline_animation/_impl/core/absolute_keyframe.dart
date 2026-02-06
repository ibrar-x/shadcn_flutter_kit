part of '../../timeline_animation.dart';

class AbsoluteKeyframe<T> implements Keyframe<T> {
  final T from;
  final T to;
  @override
  final Duration duration;

  const AbsoluteKeyframe(this.duration, this.from, this.to);

  @override
  T compute(TimelineAnimation<T> timeline, int index, double t) {
    return timeline.lerp(from, to, t) as T;
  }
}

/// Animates from the previous keyframe's end to [target].
