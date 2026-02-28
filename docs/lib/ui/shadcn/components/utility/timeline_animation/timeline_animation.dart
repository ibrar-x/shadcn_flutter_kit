import 'dart:ui' show Color, Offset, Rect, Size, lerpDouble;

import 'package:flutter/animation.dart';

part '_impl/utils/transformers.dart';
part '_impl/core/keyframe.dart';
part '_impl/core/absolute_keyframe.dart';
part '_impl/core/relative_keyframe.dart';
part '_impl/core/still_keyframe.dart';
part '_impl/utils/timeline_animatable.dart';
part '_impl/core/timeline_animation_widget.dart';

/// Interpolates between two values of type [T].
typedef PropertyLerp<T> = T? Function(T? a, T? b, double t);

/// Common interpolation helpers for timeline animations.
