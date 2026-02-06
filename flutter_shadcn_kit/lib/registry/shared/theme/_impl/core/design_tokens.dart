part of '../../theme.dart';

/// Spacing scale for consistent padding/margins.
class SpacingScale {
  /// Base spacing unit.
  final double base;

  const SpacingScale(this.base);

  double get xs => base;
  double get sm => base * 2;
  double get md => base * 3;
  double get lg => base * 4;
  double get xl => base * 6;
  double get xxl => base * 8;

  SpacingScale copyWith({double? base}) => SpacingScale(base ?? this.base);

  static SpacingScale lerp(SpacingScale a, SpacingScale b, double t) {
    return SpacingScale(lerpDouble(a.base, b.base, t)!);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SpacingScale && other.base == base;

  @override
  int get hashCode => base.hashCode;
}

/// Letter-spacing scale for typography tracking.
class TrackingScale {
  final double normal;

  const TrackingScale({this.normal = 0});

  TrackingScale copyWith({double? normal}) =>
      TrackingScale(normal: normal ?? this.normal);

  static TrackingScale lerp(TrackingScale a, TrackingScale b, double t) {
    return TrackingScale(normal: lerpDouble(a.normal, b.normal, t)!);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackingScale && other.normal == normal;

  @override
  int get hashCode => normal.hashCode;
}

/// Shadow scale tokens for elevation styling.
class ShadowScale {
  final List<BoxShadow> shadow2xs;
  final List<BoxShadow> shadowXs;
  final List<BoxShadow> shadowSm;
  final List<BoxShadow> shadow;
  final List<BoxShadow> shadowMd;
  final List<BoxShadow> shadowLg;
  final List<BoxShadow> shadowXl;
  final List<BoxShadow> shadow2xl;

  const ShadowScale({
    required this.shadow2xs,
    required this.shadowXs,
    required this.shadowSm,
    required this.shadow,
    required this.shadowMd,
    required this.shadowLg,
    required this.shadowXl,
    required this.shadow2xl,
  });

  ShadowScale copyWith({
    List<BoxShadow>? shadow2xs,
    List<BoxShadow>? shadowXs,
    List<BoxShadow>? shadowSm,
    List<BoxShadow>? shadow,
    List<BoxShadow>? shadowMd,
    List<BoxShadow>? shadowLg,
    List<BoxShadow>? shadowXl,
    List<BoxShadow>? shadow2xl,
  }) {
    return ShadowScale(
      shadow2xs: shadow2xs ?? this.shadow2xs,
      shadowXs: shadowXs ?? this.shadowXs,
      shadowSm: shadowSm ?? this.shadowSm,
      shadow: shadow ?? this.shadow,
      shadowMd: shadowMd ?? this.shadowMd,
      shadowLg: shadowLg ?? this.shadowLg,
      shadowXl: shadowXl ?? this.shadowXl,
      shadow2xl: shadow2xl ?? this.shadow2xl,
    );
  }

  static ShadowScale lerp(ShadowScale a, ShadowScale b, double t) {
    return ShadowScale(
      shadow2xs: BoxShadow.lerpList(a.shadow2xs, b.shadow2xs, t) ?? const [],
      shadowXs: BoxShadow.lerpList(a.shadowXs, b.shadowXs, t) ?? const [],
      shadowSm: BoxShadow.lerpList(a.shadowSm, b.shadowSm, t) ?? const [],
      shadow: BoxShadow.lerpList(a.shadow, b.shadow, t) ?? const [],
      shadowMd: BoxShadow.lerpList(a.shadowMd, b.shadowMd, t) ?? const [],
      shadowLg: BoxShadow.lerpList(a.shadowLg, b.shadowLg, t) ?? const [],
      shadowXl: BoxShadow.lerpList(a.shadowXl, b.shadowXl, t) ?? const [],
      shadow2xl: BoxShadow.lerpList(a.shadow2xl, b.shadow2xl, t) ?? const [],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShadowScale &&
          listEquals(other.shadow2xs, shadow2xs) &&
          listEquals(other.shadowXs, shadowXs) &&
          listEquals(other.shadowSm, shadowSm) &&
          listEquals(other.shadow, shadow) &&
          listEquals(other.shadowMd, shadowMd) &&
          listEquals(other.shadowLg, shadowLg) &&
          listEquals(other.shadowXl, shadowXl) &&
          listEquals(other.shadow2xl, shadow2xl);

  @override
  int get hashCode => Object.hash(
    Object.hashAll(shadow2xs),
    Object.hashAll(shadowXs),
    Object.hashAll(shadowSm),
    Object.hashAll(shadow),
    Object.hashAll(shadowMd),
    Object.hashAll(shadowLg),
    Object.hashAll(shadowXl),
    Object.hashAll(shadow2xl),
  );
}
