part of '../../text_animate.dart';

/// Theme data for [StreamingText].
class TextAnimateTheme extends ComponentThemeData {
  const TextAnimateTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.style,
    this.typewriter,
    this.effect,
    this.cursor,
  });

  final TextStyle? style;
  final TypewriterEffect? typewriter;
  final StreamingTextEffectAdapter? effect;
  final StreamingCursor? cursor;

  TextAnimateTheme copyWith({
    ValueGetter<TextStyle?>? style,
    ValueGetter<TypewriterEffect?>? typewriter,
    ValueGetter<StreamingTextEffectAdapter?>? effect,
    ValueGetter<StreamingCursor?>? cursor,
  }) {
    return TextAnimateTheme(
      style: style == null ? this.style : style(),
      typewriter: typewriter == null ? this.typewriter : typewriter(),
      effect: effect == null ? this.effect : effect(),
      cursor: cursor == null ? this.cursor : cursor(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextAnimateTheme &&
        other.style == style &&
        other.typewriter == typewriter &&
        other.effect == effect &&
        other.cursor == cursor;
  }

  @override
  int get hashCode => Object.hash(style, typewriter, effect, cursor);
}
