import 'dart:ui' show Color, Offset, Rect, Size, lerpDouble;

import 'package:flutter/animation.dart';

/// Interpolates between two values of type [T].
typedef PropertyLerp<T> = T? Function(T? a, T? b, double t);

/// Common interpolation helpers for timeline animations.
class Transformers {
  const Transformers._();

  static int? typeInt(int? a, int? b, double t) {
    if (a == null || b == null) return null;
    return (a + (b - a) * t).round();
  }

  static double? typeDouble(double? a, double? b, double t) {
    if (a == null || b == null) return null;
    return lerpDouble(a, b, t);
  }

  static Color? typeColor(Color? a, Color? b, double t) {
    return Color.lerp(a, b, t);
  }

  static Offset? typeOffset(Offset? a, Offset? b, double t) {
    return Offset.lerp(a, b, t);
  }

  static Size? typeSize(Size? a, Size? b, double t) {
    return Size.lerp(a, b, t);
  }

  static Rect? typeRect(Rect? a, Rect? b, double t) {
    return Rect.lerp(a, b, t);
  }
}

/// Defines a segment in a timeline animation.
abstract class Keyframe<T> {
  Duration get duration;
  T compute(TimelineAnimation<T> timeline, int index, double t);
}

/// Animates between explicit start and end values.
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
