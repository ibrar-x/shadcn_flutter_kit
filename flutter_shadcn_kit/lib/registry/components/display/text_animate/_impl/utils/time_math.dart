part of '../../text_animate.dart';

double _normalizedProgress({
  required Duration age,
  required Duration duration,
  required Curve curve,
}) {
  if (duration <= Duration.zero) return 1;
  final raw = age.inMicroseconds / duration.inMicroseconds;
  final clamped = raw.clamp(0.0, 1.0).toDouble();
  return curve.transform(clamped);
}

Duration _revealDelayForIndex(int index, TypewriterEffect typewriter) {
  if (!typewriter.enabled || typewriter.charsPerSecond <= 0 || index <= 0) {
    return Duration.zero;
  }
  final micros =
      (index / typewriter.charsPerSecond) * Duration.microsecondsPerSecond;
  return Duration(microseconds: micros.round());
}

int _visibleCharacterCount({
  required int total,
  required Duration elapsed,
  required TypewriterEffect typewriter,
}) {
  if (total <= 0) return 0;
  if (!typewriter.enabled || typewriter.charsPerSecond <= 0) {
    return total;
  }
  final micros = elapsed.inMicroseconds;
  if (micros <= 0) {
    return 1;
  }
  final revealed =
      ((micros / Duration.microsecondsPerSecond) * typewriter.charsPerSecond)
          .floor() +
      1;
  return revealed.clamp(0, total).toInt();
}
