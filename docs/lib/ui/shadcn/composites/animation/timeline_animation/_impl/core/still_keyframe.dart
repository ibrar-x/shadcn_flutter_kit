part of '../../timeline_animation.dart';

class StillKeyframe<T> implements Keyframe<T> {
  final T? value;
  @override
  final Duration duration;

  const StillKeyframe(this.duration, [this.value]);

  @override
  T compute(TimelineAnimation<T> timeline, int index, double t) {
    var resolved = value;
    if (resolved == null) {
      assert(index > 0, 'Relative still keyframe must have a previous keyframe');
      resolved =
          timeline.keyframes[index - 1].compute(timeline, index - 1, 1.0);
    }
    return resolved as T;
  }
}

/// Binds a timeline to an explicit duration.
