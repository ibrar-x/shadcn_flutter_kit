part of '../../text_animate.dart';

/// Typewriter reveal settings for [StreamingText].
@immutable
class TypewriterEffect {
  const TypewriterEffect({this.enabled = true, this.charsPerSecond = 48});

  /// Enables/disables progressive reveal.
  final bool enabled;

  /// Reveal speed for newly appended characters.
  final double charsPerSecond;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TypewriterEffect &&
        other.enabled == enabled &&
        other.charsPerSecond == charsPerSecond;
  }

  @override
  int get hashCode => Object.hash(enabled, charsPerSecond);
}
