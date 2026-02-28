part of '../../timeline_animation.dart';

/// Keyframe defines a reusable type for this registry module.
abstract class Keyframe<T> {
/// Stores `duration` state/configuration for this implementation.
  Duration get duration;
  T compute(TimelineAnimation<T> timeline, int index, double t);
}

/// Animates between explicit start and end values.
