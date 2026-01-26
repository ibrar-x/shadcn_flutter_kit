---
title: "Class: ShadcnApp"
description: "Minimal app wrapper that wires up shadcn theme + overlay handling."
---

```dart
/// Minimal app wrapper that wires up shadcn theme + overlay handling.
class ShadcnApp extends StatelessWidget {
  const ShadcnApp({super.key, this.navigatorKey, this.home, this.routes = const <String, WidgetBuilder>{}, this.initialRoute, this.onGenerateRoute, this.onGenerateInitialRoutes, this.onUnknownRoute, this.navigatorObservers = const <NavigatorObserver>[], this.builder, this.title = '', this.color, this.theme = const ThemeData(), this.darkTheme, this.themeMode = ThemeMode.system, this.locale, this.localizationsDelegates, this.localeListResolutionCallback, this.localeResolutionCallback, this.supportedLocales = const <Locale>[Locale('en', 'US')], this.debugShowMaterialGrid = false, this.showPerformanceOverlay = false, this.showSemanticsDebugger = false, this.debugShowCheckedModeBanner = true, this.shortcuts, this.actions, this.restorationScopeId, this.scrollBehavior, this.scaling, this.popoverHandler, this.tooltipHandler, this.menuHandler, this.enableThemeAnimation = false});
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? home;
  final Map<String, WidgetBuilder> routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final Color? color;
  final ThemeData theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final bool debugShowMaterialGrid;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final AdaptiveScaling? scaling;
  final OverlayHandler? popoverHandler;
  final OverlayHandler? tooltipHandler;
  final OverlayHandler? menuHandler;
  final bool enableThemeAnimation;
  Widget build(BuildContext context);
}
```
