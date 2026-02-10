part of '../../avatar.dart';

class AvatarTheme extends ComponentThemeData {
  final double? size;
  final double? borderRadius;
  final Color? backgroundColor;
  final AlignmentGeometry? badgeAlignment;
  final double? badgeGap;
  final TextStyle? textStyle;

  const AvatarTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.size,
    this.borderRadius,
    this.backgroundColor,
    this.badgeAlignment,
    this.badgeGap,
    this.textStyle,
  });

  AvatarTheme copyWith({
    ValueGetter<double?>? size,
    ValueGetter<double?>? borderRadius,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<AlignmentGeometry?>? badgeAlignment,
    ValueGetter<double?>? badgeGap,
    ValueGetter<TextStyle?>? textStyle,
  }) {
    return AvatarTheme(
      size: size == null ? this.size : size(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      backgroundColor: backgroundColor == null
          ? this.backgroundColor
          : backgroundColor(),
      badgeAlignment: badgeAlignment == null
          ? this.badgeAlignment
          : badgeAlignment(),
      badgeGap: badgeGap == null ? this.badgeGap : badgeGap(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AvatarTheme &&
        other.size == size &&
        other.borderRadius == borderRadius &&
        other.backgroundColor == backgroundColor &&
        other.badgeAlignment == badgeAlignment &&
        other.badgeGap == badgeGap &&
        other.textStyle == textStyle;
  }

  @override
  int get hashCode => Object.hash(
    size,
    borderRadius,
    backgroundColor,
    badgeAlignment,
    badgeGap,
    textStyle,
  );
}
