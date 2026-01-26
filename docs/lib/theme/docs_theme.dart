import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../ui/shadcn/shared/theme/color_scheme.dart' as shadcn_colors;
import '../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

class DocsThemeData {
  final shadcn_colors.ColorScheme colorScheme;
  final double radius;
  final double scaling;
  final double surfaceOpacity;
  final double surfaceBlur;

  const DocsThemeData({
    required this.colorScheme,
    required this.radius,
    required this.scaling,
    required this.surfaceOpacity,
    required this.surfaceBlur,
  });

  DocsThemeData copyWith({
    shadcn_colors.ColorScheme? colorScheme,
    double? radius,
    double? scaling,
    double? surfaceOpacity,
    double? surfaceBlur,
  }) {
    return DocsThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      radius: radius ?? this.radius,
      scaling: scaling ?? this.scaling,
      surfaceOpacity: surfaceOpacity ?? this.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? this.surfaceBlur,
    );
  }

  shadcn_theme.ThemeData toShadcnTheme() {
    return shadcn_theme.ThemeData(
      colorScheme: colorScheme,
      radius: radius,
      scaling: scaling,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
    );
  }

  material.ThemeData toMaterialTheme() {
    final errorOn = material.ThemeData.estimateBrightnessForColor(
              colorScheme.destructive,
            ) ==
            material.Brightness.dark
        ? material.Colors.white
        : material.Colors.black;
    final materialScheme = material.ColorScheme(
      brightness: colorScheme.brightness,
      primary: colorScheme.primary,
      onPrimary: colorScheme.primaryForeground,
      secondary: colorScheme.secondary,
      onSecondary: colorScheme.secondaryForeground,
      error: colorScheme.destructive,
      onError: errorOn,
      surface: colorScheme.background,
      onSurface: colorScheme.foreground,
      surfaceContainerHighest: colorScheme.muted,
      onSurfaceVariant: colorScheme.mutedForeground,
      outline: colorScheme.border,
      outlineVariant: colorScheme.input,
      shadow: colorScheme.border,
      inverseSurface: colorScheme.foreground,
      onInverseSurface: colorScheme.background,
      inversePrimary: colorScheme.primary,
      scrim: colorScheme.ring,
    );
    return material.ThemeData(
      useMaterial3: true,
      colorScheme: materialScheme,
      scaffoldBackgroundColor: colorScheme.background,
      cardColor: colorScheme.card,
      dividerColor: colorScheme.border,
      canvasColor: colorScheme.background,
    );
  }
}

class DocsThemeScope extends InheritedWidget {
  final DocsThemeData data;

  const DocsThemeScope({
    super.key,
    required this.data,
    required super.child,
  });

  static DocsThemeData of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<DocsThemeScope>();
    return scope?.data ?? _fallback;
  }

  static const DocsThemeData _fallback = DocsThemeData(
    colorScheme: shadcn_colors.ColorSchemes.lightDefaultColor,
    radius: 0.1,
    scaling: 1.0,
    surfaceOpacity: 1.0,
    surfaceBlur: 0.0,
  );

  @override
  bool updateShouldNotify(DocsThemeScope oldWidget) {
    return data != oldWidget.data;
  }
}

extension DocsThemeExtensions on BuildContext {
  DocsThemeData get docsTheme => DocsThemeScope.of(this);
}

extension ThemeScaling on material.ThemeData {
  double scaling(BuildContext context) => DocsThemeScope.of(context).scaling;
}
