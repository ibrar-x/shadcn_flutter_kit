import 'package:flutter/material.dart';

class FeatureCarouselThemeData {
  final Color backgroundColor;
  final Color vignetteOuterColor;
  final Color vignetteInnerColor;
  final Color cardFillColor;
  final Color cardBorderColor;
  final Color ghostFillColor;
  final Color ghostBorderColor;
  final Color arrowBackground;
  final Color arrowIconColor;
  final Color ctaBackground;
  final Color ctaBorderColor;
  final Color ctaTextColor;
  final Color titleColor;
  final Color descriptionColor;
  final Color accentColor;
  final double cardWidth;
  final double cardHeight;
  final double carouselWidth;
  final double carouselHeight;
  final double arrowSize;
  final double arrowRadius;
  final double cardRadius;
  final double ghostRadius;
  final double ctaHeight;
  final double ctaMinWidth;
  final double ctaHorizontalPadding;
  final double titleFontSize;
  final double descriptionFontSize;
  final double descriptionLineHeight;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const FeatureCarouselThemeData({
    required this.backgroundColor,
    required this.vignetteInnerColor,
    required this.vignetteOuterColor,
    required this.cardFillColor,
    required this.cardBorderColor,
    required this.ghostFillColor,
    required this.ghostBorderColor,
    required this.arrowBackground,
    required this.arrowIconColor,
    required this.ctaBackground,
    required this.ctaBorderColor,
    required this.ctaTextColor,
    required this.titleColor,
    required this.descriptionColor,
    required this.accentColor,
    required this.cardWidth,
    required this.cardHeight,
    required this.carouselWidth,
    required this.carouselHeight,
    required this.arrowSize,
    required this.arrowRadius,
    required this.cardRadius,
    required this.ghostRadius,
    required this.ctaHeight,
    required this.ctaMinWidth,
    required this.ctaHorizontalPadding,
    required this.titleFontSize,
    required this.descriptionFontSize,
    required this.descriptionLineHeight,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  factory FeatureCarouselThemeData.defaults() {
    return const FeatureCarouselThemeData(
      backgroundColor: Color(0xFF121212),
      vignetteInnerColor: Color(0x00000000),
      vignetteOuterColor: Color(0x8C000000),
      cardFillColor: Color(0xFF141414),
      cardBorderColor: Color(0x8CFFFFFF),
      ghostFillColor: Color(0x66141414),
      ghostBorderColor: Color(0x33FFFFFF),
      arrowBackground: Color(0x0FFFFFFF),
      arrowIconColor: Color(0x8CFFFFFF),
      ctaBackground: Color(0x12FFFFFF),
      ctaBorderColor: Color(0x14FFFFFF),
      ctaTextColor: Color(0xCCFFFFFF),
      titleColor: Color(0x8CFFFFFF),
      descriptionColor: Color(0xA6FFFFFF),
      accentColor: Color(0xFF7EA3FF),
      cardWidth: 250,
      cardHeight: 300,
      carouselWidth: 420,
      carouselHeight: 370,
      arrowSize: 44,
      arrowRadius: 12,
      cardRadius: 12,
      ghostRadius: 12,
      ctaHeight: 46,
      ctaMinWidth: 140,
      ctaHorizontalPadding: 22,
      titleFontSize: 18,
      descriptionFontSize: 18,
      descriptionLineHeight: 1.35,
      transitionDuration: Duration(milliseconds: 260),
      transitionCurve: Curves.easeOutCubic,
    );
  }

  FeatureCarouselThemeData copyWith({
    Color? backgroundColor,
    Color? vignetteInnerColor,
    Color? vignetteOuterColor,
    Color? cardFillColor,
    Color? cardBorderColor,
    Color? ghostFillColor,
    Color? ghostBorderColor,
    Color? arrowBackground,
    Color? arrowIconColor,
    Color? ctaBackground,
    Color? ctaBorderColor,
    Color? ctaTextColor,
    Color? titleColor,
    Color? descriptionColor,
    Color? accentColor,
    double? cardWidth,
    double? cardHeight,
    double? carouselWidth,
    double? carouselHeight,
    double? arrowSize,
    double? arrowRadius,
    double? cardRadius,
    double? ghostRadius,
    double? ctaHeight,
    double? ctaMinWidth,
    double? ctaHorizontalPadding,
    double? titleFontSize,
    double? descriptionFontSize,
    double? descriptionLineHeight,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return FeatureCarouselThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      vignetteInnerColor: vignetteInnerColor ?? this.vignetteInnerColor,
      vignetteOuterColor: vignetteOuterColor ?? this.vignetteOuterColor,
      cardFillColor: cardFillColor ?? this.cardFillColor,
      cardBorderColor: cardBorderColor ?? this.cardBorderColor,
      ghostFillColor: ghostFillColor ?? this.ghostFillColor,
      ghostBorderColor: ghostBorderColor ?? this.ghostBorderColor,
      arrowBackground: arrowBackground ?? this.arrowBackground,
      arrowIconColor: arrowIconColor ?? this.arrowIconColor,
      ctaBackground: ctaBackground ?? this.ctaBackground,
      ctaBorderColor: ctaBorderColor ?? this.ctaBorderColor,
      ctaTextColor: ctaTextColor ?? this.ctaTextColor,
      titleColor: titleColor ?? this.titleColor,
      descriptionColor: descriptionColor ?? this.descriptionColor,
      accentColor: accentColor ?? this.accentColor,
      cardWidth: cardWidth ?? this.cardWidth,
      cardHeight: cardHeight ?? this.cardHeight,
      carouselWidth: carouselWidth ?? this.carouselWidth,
      carouselHeight: carouselHeight ?? this.carouselHeight,
      arrowSize: arrowSize ?? this.arrowSize,
      arrowRadius: arrowRadius ?? this.arrowRadius,
      cardRadius: cardRadius ?? this.cardRadius,
      ghostRadius: ghostRadius ?? this.ghostRadius,
      ctaHeight: ctaHeight ?? this.ctaHeight,
      ctaMinWidth: ctaMinWidth ?? this.ctaMinWidth,
      ctaHorizontalPadding: ctaHorizontalPadding ?? this.ctaHorizontalPadding,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      descriptionFontSize: descriptionFontSize ?? this.descriptionFontSize,
      descriptionLineHeight:
          descriptionLineHeight ?? this.descriptionLineHeight,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }
}
