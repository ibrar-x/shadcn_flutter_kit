part of '../../timeline_animation.dart';

abstract class Keyframe<T> {
  Duration get duration;
  T compute(TimelineAnimation<T> timeline, int index, double t);
}

/// Animates between explicit start and end values.
