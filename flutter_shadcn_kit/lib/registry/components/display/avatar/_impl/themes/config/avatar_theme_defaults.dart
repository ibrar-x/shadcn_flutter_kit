// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class AvatarThemeConfigGlobalDefaults {
  final Object? size;
  final Object? borderRadius;
  final Object? backgroundColor;
  final Object? badgeAlignment;
  final Object? badgeGap;
  final Object? textStyle;

  const AvatarThemeConfigGlobalDefaults({
    this.size = 'theme.scaling * 40',
    this.borderRadius = 'theme.radius * size',
    this.backgroundColor = 'theme.colorScheme.muted',
    this.badgeAlignment = 'AlignmentDirectional(offset, offset)',
    this.badgeGap = 'theme.density.baseGap * theme.scaling * gapXs',
    this.textStyle,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'size': size,
    'borderRadius': borderRadius,
    'backgroundColor': backgroundColor,
    'badgeAlignment': badgeAlignment,
    'badgeGap': badgeGap,
    'textStyle': textStyle,
  };
}

const avatarThemeTokensConfigGlobalDefaults = AvatarThemeConfigGlobalDefaults();
