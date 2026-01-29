// AppErrorHub: singleton "error bus" that holds ValueNotifier<AppError?> channels.
// Use app(key) for global, cross-navigation errors; use screen(key) for per-screen channels (dispose via ScreenErrorScope or disposeScreen()).

import 'package:flutter/foundation.dart';

import 'app_error.dart';

class AppErrorHub {
  AppErrorHub._();

  /// Global singleton instance.
  static final AppErrorHub I = AppErrorHub._();

  // -------------------------
  // App-level (global) scopes
  // -------------------------

  /// Predefined app-level channels.
  static const String sessionExpired = 'app.sessionExpired';
  static const String maintenanceMode = 'app.maintenanceMode';
  static const String networkUnavailable = 'app.networkUnavailable';
  static const String criticalUpdate = 'app.criticalUpdate';
  static const String permissionDenied = 'app.permissionDenied';

  final Map<String, ValueNotifier<AppError?>> _appScopes = {};

  /// Returns a persistent app-level channel.
  ValueNotifier<AppError?> app(String key) {
    return _appScopes.putIfAbsent(key, () => ValueNotifier<AppError?>(null));
  }

  void clearApp(String key) => _appScopes[key]?.value = null;

  void clearAllApp() {
    for (final notifier in _appScopes.values) {
      notifier.value = null;
    }
  }

  bool get hasAppError => _appScopes.values.any((n) => n.value != null);

  List<AppError> get activeAppErrors => _appScopes.values
      .where((n) => n.value != null)
      .map((n) => n.value!)
      .toList(growable: false);

  // ----------------------------
  // Screen-level (scoped) scopes
  // ----------------------------

  final Map<String, ValueNotifier<AppError?>> _screenScopes = {};

  /// Returns a screen-level channel.
  ///
  /// Call [disposeScreen] when the screen unmounts (or use [ScreenErrorScope]).
  ValueNotifier<AppError?> screen(String key) {
    return _screenScopes.putIfAbsent(key, () => ValueNotifier<AppError?>(null));
  }

  void clearScreen(String key) => _screenScopes[key]?.value = null;

  void clearAllScreens() {
    for (final notifier in _screenScopes.values) {
      notifier.value = null;
    }
  }

  void disposeScreen(String key) {
    _screenScopes[key]?.dispose();
    _screenScopes.remove(key);
  }

  void disposeAllScreens() {
    for (final notifier in _screenScopes.values) {
      notifier.dispose();
    }
    _screenScopes.clear();
  }

  // ------------------
  // Legacy convenience
  // ------------------

  /// Legacy global channel (maps to an app-level "global" key).
  @Deprecated(
    'Use app(key) for app-level or screen(key) for screen-level channels.',
  )
  ValueNotifier<AppError?> get global => app('global');

  /// Legacy scoped channel (maps to screen-level).
  @Deprecated('Use screen(key) for screen-level channels.')
  ValueNotifier<AppError?> scope(String key) => screen(key);
}
