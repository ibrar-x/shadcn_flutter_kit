import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/shadcn/shared/theme/color_scheme.dart' as shadcn_colors;
import '../ui/shadcn/shared/theme/preset_themes.dart';
import '../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;
import 'docs_theme.dart';

const String kPrefsThemePresetId = 'themePresetId';
const String kPrefsThemeMode = 'themeMode';
const String kPrefsCustomScheme = 'colorScheme';
const String kPrefsRadius = 'radius';
const String kPrefsScaling = 'scaling';
const String kPrefsSurfaceOpacity = 'surfaceOpacity';
const String kPrefsSurfaceBlur = 'surfaceBlur';

class DocsThemePreset {
  final String id;
  final String name;
  final shadcn_colors.ColorScheme light;
  final shadcn_colors.ColorScheme dark;
  final RegistryThemePresetTokens lightTokens;
  final RegistryThemePresetTokens darkTokens;

  const DocsThemePreset({
    required this.id,
    required this.name,
    required this.light,
    required this.dark,
    required this.lightTokens,
    required this.darkTokens,
  });
}

class DocsThemeController extends ChangeNotifier {
  DocsThemeData _data;
  final SharedPreferences prefs;
  String _presetId;
  Brightness _brightness;

  DocsThemeController({
    required DocsThemeData initialData,
    required this.prefs,
    required String presetId,
    required Brightness brightness,
  })  : _data = initialData,
        _presetId = presetId,
        _brightness = brightness;

  DocsThemeData get data => _data;
  String get presetId => _presetId;
  Brightness get brightness => _brightness;

  static const shadcn_theme.ThemeData _baseTheme = shadcn_theme.ThemeData();
  static final RegistryThemePresetTokens _defaultTokens =
      RegistryThemePresetTokens(
    radius: _baseTheme.radius,
    spacing: _baseTheme.spacing,
    tracking: _baseTheme.tracking,
    shadows: _baseTheme.shadows,
  );

  static final List<DocsThemePreset> presets = [
    DocsThemePreset(
      id: 'default',
      name: 'Default',
      light: shadcn_colors.ColorSchemes.lightDefaultColor,
      dark: shadcn_colors.ColorSchemes.darkDefaultColor,
      lightTokens: _defaultTokens,
      darkTokens: _defaultTokens,
    ),
    ...registryThemePresets.map(
      (preset) => DocsThemePreset(
        id: preset.id,
        name: preset.name,
        light: preset.light,
        dark: preset.dark,
        lightTokens: preset.lightTokens,
        darkTokens: preset.darkTokens,
      ),
    ),
  ];

  void setPreset(String id) {
    if (_presetId == id) return;
    _presetId = id;
    final tokens = _tokensFor(id, _brightness);
    _data = _data.copyWith(
      colorScheme: _schemeFor(id, _brightness),
      radius: tokens.radius,
      spacing: tokens.spacing,
      tracking: tokens.tracking,
      shadows: tokens.shadows,
    );
    prefs.setString(kPrefsThemePresetId, _presetId);
    notifyListeners();
  }

  void setBrightness(Brightness brightness) {
    if (_brightness == brightness) return;
    _brightness = brightness;
    if (_presetId == 'custom') {
      final colors = _data.colorScheme.toColorMap();
      _data = _data.copyWith(
        colorScheme: shadcn_colors.ColorScheme.fromColors(
          colors: colors,
          brightness: _brightness,
        ),
      );
      prefs.setString(kPrefsCustomScheme, _encodeScheme(_data.colorScheme));
    } else {
      final tokens = _tokensFor(_presetId, _brightness);
      _data = _data.copyWith(
        colorScheme: _schemeFor(_presetId, _brightness),
        radius: tokens.radius,
        spacing: tokens.spacing,
        tracking: tokens.tracking,
        shadows: tokens.shadows,
      );
    }
    prefs.setString(
      kPrefsThemeMode,
      _brightness == Brightness.dark ? 'dark' : 'light',
    );
    notifyListeners();
  }

  void setCustomScheme(shadcn_colors.ColorScheme scheme) {
    _presetId = 'custom';
    _data = _data.copyWith(colorScheme: scheme);
    prefs.setString(kPrefsThemePresetId, _presetId);
    prefs.setString(kPrefsCustomScheme, _encodeScheme(scheme));
    notifyListeners();
  }

  void setRadius(double radius) {
    _data = _data.copyWith(radius: radius);
    prefs.setDouble(kPrefsRadius, radius);
    notifyListeners();
  }

  void setScaling(double scaling) {
    _data = _data.copyWith(scaling: scaling);
    prefs.setDouble(kPrefsScaling, scaling);
    notifyListeners();
  }

  void setSurfaceOpacity(double surfaceOpacity) {
    _data = _data.copyWith(surfaceOpacity: surfaceOpacity);
    prefs.setDouble(kPrefsSurfaceOpacity, surfaceOpacity);
    notifyListeners();
  }

  void setSurfaceBlur(double surfaceBlur) {
    _data = _data.copyWith(surfaceBlur: surfaceBlur);
    prefs.setDouble(kPrefsSurfaceBlur, surfaceBlur);
    notifyListeners();
  }

  shadcn_colors.ColorScheme _schemeFor(String id, Brightness brightness) {
    final preset = presets.firstWhere(
      (preset) => preset.id == id,
      orElse: () => presets.first,
    );
    return brightness == Brightness.dark ? preset.dark : preset.light;
  }

  RegistryThemePresetTokens _tokensFor(String id, Brightness brightness) {
    final preset = presets.firstWhere(
      (preset) => preset.id == id,
      orElse: () => presets.first,
    );
    return brightness == Brightness.dark
        ? preset.darkTokens
        : preset.lightTokens;
  }

  String _encodeScheme(shadcn_colors.ColorScheme scheme) {
    return jsonEncode(scheme.toMap());
  }
}

class DocsThemeControllerScope extends InheritedNotifier<DocsThemeController> {
  const DocsThemeControllerScope({
    super.key,
    required DocsThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static DocsThemeController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<DocsThemeControllerScope>();
    return scope?.notifier ??
        (throw StateError('DocsThemeControllerScope not found'));
  }
}

extension DocsThemeControllerX on BuildContext {
  DocsThemeController get docsThemeController =>
      DocsThemeControllerScope.of(this);
}
