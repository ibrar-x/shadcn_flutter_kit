part of '../../timeline_animation.dart';

class TimelineAnimation<T> extends Animatable<T> {
  static T defaultLerp<T>(T a, T b, double t) {
    return ((a as dynamic) + ((b as dynamic) - (a as dynamic)) * t) as T;
  }

  final PropertyLerp<T> lerp;
  final Duration totalDuration;
  final List<Keyframe<T>> keyframes;

  TimelineAnimation._({
    required this.lerp,
    required this.totalDuration,
    required this.keyframes,
  });

  factory TimelineAnimation({
    PropertyLerp<T>? lerp,
    required List<Keyframe<T>> keyframes,
  }) {
    lerp ??= defaultLerp;
    assert(keyframes.isNotEmpty, 'No keyframes found');
    Duration current = Duration.zero;
    for (final keyframe in keyframes) {
      assert(keyframe.duration.inMilliseconds > 0, 'Invalid duration');
      current += keyframe.duration;
    }
    return TimelineAnimation._(
      lerp: lerp,
      totalDuration: current,
      keyframes: keyframes,
    );
  }

  Duration _computeDuration(double t) {
    return Duration(
      milliseconds: (t * totalDuration.inMilliseconds).floor(),
    );
  }

  TimelineAnimatable<T> drive(AnimationController controller) {
    return TimelineAnimatable(controller.duration!, this);
  }

  T transformWithController(AnimationController controller) {
    return drive(controller).transform(controller.value);
  }

  TimelineAnimatable<T> withTotalDuration(Duration duration) {
    return TimelineAnimatable(duration, this);
  }

  @override
  T transform(double t) {
    assert(t >= 0 && t <= 1, 'Invalid time $t');
    assert(keyframes.isNotEmpty, 'No keyframes found');
    final duration = _computeDuration(t);
    var current = Duration.zero;
    for (var i = 0; i < keyframes.length; i++) {
      final keyframe = keyframes[i];
      final next = current + keyframe.duration;
      if (duration < next) {
        final localT = (duration - current).inMilliseconds /
            keyframe.duration.inMilliseconds;
        return keyframe.compute(this, i, localT);
      }
      current = next;
    }
    return keyframes.last.compute(this, keyframes.length - 1, 1.0);
  }
}

Duration _maxDuration(Duration a, Duration b) => a > b ? a : b;

/// Returns the longest total duration among timelines.
Duration timelineMaxDuration(Iterable<TimelineAnimation> timelines) {
  Duration max = Duration.zero;
  for (final timeline in timelines) {
    max = _maxDuration(max, timeline.totalDuration);
  }
  return max;
}
