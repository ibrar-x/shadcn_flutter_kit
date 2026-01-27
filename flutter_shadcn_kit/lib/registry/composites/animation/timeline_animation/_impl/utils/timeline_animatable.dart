part of '../../timeline_animation.dart';

class TimelineAnimatable<T> extends Animatable<T> {
  final Duration duration;
  final TimelineAnimation<T> animation;

  TimelineAnimatable(this.duration, this.animation);

  @override
  T transform(double t) {
    final selfDuration = animation.totalDuration;
    final selfT =
        (t * selfDuration.inMilliseconds) / duration.inMilliseconds;
    return animation.transform(selfT);
  }
}

/// A timeline-based animation built from multiple keyframes.
