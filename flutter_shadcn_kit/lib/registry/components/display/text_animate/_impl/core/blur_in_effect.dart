part of '../../text_animate.dart';

/// Blur -> settle effect for newly revealed characters.
@immutable
class BlurInEffect extends StreamingTextEffectAdapter
    with ComposableStreamingTextEffect {
  const BlurInEffect({
    this.duration = const Duration(milliseconds: 260),
    this.maxBlurSigma = 6,
    this.fadeIn = true,
    this.slideUpPx = 0,
    this.curve = Curves.easeOut,
  }) : assert(maxBlurSigma >= 0, 'maxBlurSigma must be >= 0');

  final Duration duration;
  final double maxBlurSigma;
  final bool fadeIn;
  final double slideUpPx;
  final Curve curve;

  @override
  Duration get settleDuration => duration;

  @override
  InlineSpan buildSpan({
    required String char,
    required int index,
    required Duration age,
    required TextStyle baseStyle,
  }) {
    if (char == '\n') {
      return TextSpan(text: char, style: baseStyle);
    }
    final child = wrap(
      child: Text(char, style: baseStyle),
      char: char,
      index: index,
      age: age,
      baseStyle: baseStyle,
    );
    return _buildCharacterWidgetSpan(child: child);
  }

  @override
  Widget wrap({
    required Widget child,
    required String char,
    required int index,
    required Duration age,
    required TextStyle baseStyle,
  }) {
    final t = _normalizedProgress(age: age, duration: duration, curve: curve);
    final sigma = (1 - t) * maxBlurSigma;
    final opacity = fadeIn ? math.max(t, 0.0) : 1.0;
    final dy = slideUpPx * (1 - t);

    var current = child;
    if (sigma > 0.01) {
      current = ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: current,
      );
    }
    if (fadeIn) {
      current = Opacity(opacity: opacity.clamp(0.0, 1.0), child: current);
    }
    if (slideUpPx != 0) {
      current = Transform.translate(offset: Offset(0, -dy), child: current);
    }
    return current;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BlurInEffect &&
        other.duration == duration &&
        other.maxBlurSigma == maxBlurSigma &&
        other.fadeIn == fadeIn &&
        other.slideUpPx == slideUpPx &&
        other.curve == curve;
  }

  @override
  int get hashCode =>
      Object.hash(duration, maxBlurSigma, fadeIn, slideUpPx, curve);
}
