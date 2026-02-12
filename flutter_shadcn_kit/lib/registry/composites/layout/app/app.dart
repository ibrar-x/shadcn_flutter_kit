export '../../../components/display/divider/divider.dart' show Divider;
export '../../../components/layout/scaffold/scaffold.dart'
/// Stores `Scaffold` state/configuration for this implementation.
    show AppBar, Scaffold;

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../../shared/primitives/overlay.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/constants.dart';

/// Minimal app wrapper that wires up shadcn theme + overlay handling.

part '_impl/core/shadcn_ui.dart';

/// ShadcnApp defines a reusable type for this registry module.
class ShadcnApp extends StatelessWidget {
/// Creates a `ShadcnApp` instance.
  const ShadcnApp({
    super.key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.pageRouteBuilder,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.color,
    this.theme = const ThemeData(),
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.scaling,
    this.popoverHandler,
    this.tooltipHandler,
    this.menuHandler,
    this.enableThemeAnimation = false,
    this.materialFallback = true,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
  });

/// Creates a `ShadcnApp.router` instance.
  const ShadcnApp.router({
    super.key,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.color,
    this.theme = const ThemeData(),
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.scaling,
    this.popoverHandler,
    this.tooltipHandler,
    this.menuHandler,
    this.enableThemeAnimation = false,
    this.materialFallback = true,
  }) : navigatorKey = null,
       home = null,
       routes = const <String, WidgetBuilder>{},
       initialRoute = null,
       onGenerateRoute = null,
       onGenerateInitialRoutes = null,
       onUnknownRoute = null,
       pageRouteBuilder = null,
       navigatorObservers = const <NavigatorObserver>[];

/// Stores `navigatorKey` state/configuration for this implementation.
  final GlobalKey<NavigatorState>? navigatorKey;
/// Stores `home` state/configuration for this implementation.
  final Widget? home;
/// Stores `routes` state/configuration for this implementation.
  final Map<String, WidgetBuilder> routes;
/// Stores `initialRoute` state/configuration for this implementation.
  final String? initialRoute;
/// Stores `onGenerateRoute` state/configuration for this implementation.
  final RouteFactory? onGenerateRoute;
/// Stores `onGenerateInitialRoutes` state/configuration for this implementation.
  final InitialRouteListFactory? onGenerateInitialRoutes;
/// Stores `onUnknownRoute` state/configuration for this implementation.
  final RouteFactory? onUnknownRoute;
/// Stores `pageRouteBuilder` state/configuration for this implementation.
  final PageRouteFactory? pageRouteBuilder;
/// Stores `navigatorObservers` state/configuration for this implementation.
  final List<NavigatorObserver> navigatorObservers;
/// Stores `builder` state/configuration for this implementation.
  final TransitionBuilder? builder;
/// Stores `title` state/configuration for this implementation.
  final String title;
/// Stores `color` state/configuration for this implementation.
  final Color? color;
/// Stores `theme` state/configuration for this implementation.
  final ThemeData theme;
/// Stores `darkTheme` state/configuration for this implementation.
  final ThemeData? darkTheme;
/// Stores `themeMode` state/configuration for this implementation.
  final ThemeMode themeMode;
/// Stores `locale` state/configuration for this implementation.
  final Locale? locale;
/// Stores `localizationsDelegates` state/configuration for this implementation.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
/// Stores `localeListResolutionCallback` state/configuration for this implementation.
  final LocaleListResolutionCallback? localeListResolutionCallback;
/// Stores `localeResolutionCallback` state/configuration for this implementation.
  final LocaleResolutionCallback? localeResolutionCallback;
/// Stores `supportedLocales` state/configuration for this implementation.
  final Iterable<Locale> supportedLocales;
/// Stores `showPerformanceOverlay` state/configuration for this implementation.
  final bool showPerformanceOverlay;
/// Stores `showSemanticsDebugger` state/configuration for this implementation.
  final bool showSemanticsDebugger;
/// Stores `debugShowCheckedModeBanner` state/configuration for this implementation.
  final bool debugShowCheckedModeBanner;
/// Stores `debugShowMaterialGrid` state/configuration for this implementation.
  final bool debugShowMaterialGrid;
/// Stores `shortcuts` state/configuration for this implementation.
  final Map<ShortcutActivator, Intent>? shortcuts;
/// Stores `actions` state/configuration for this implementation.
  final Map<Type, Action<Intent>>? actions;
/// Stores `restorationScopeId` state/configuration for this implementation.
  final String? restorationScopeId;
/// Stores `scrollBehavior` state/configuration for this implementation.
  final ScrollBehavior? scrollBehavior;
/// Stores `scaling` state/configuration for this implementation.
  final AdaptiveScaling? scaling;
/// Stores `popoverHandler` state/configuration for this implementation.
  final OverlayHandler? popoverHandler;
/// Stores `tooltipHandler` state/configuration for this implementation.
  final OverlayHandler? tooltipHandler;
/// Stores `menuHandler` state/configuration for this implementation.
  final OverlayHandler? menuHandler;
/// Stores `enableThemeAnimation` state/configuration for this implementation.
  final bool enableThemeAnimation;
/// Stores `materialFallback` state/configuration for this implementation.
  final bool materialFallback;

/// Stores `routeInformationProvider` state/configuration for this implementation.
  final RouteInformationProvider? routeInformationProvider;
/// Stores `routeInformationParser` state/configuration for this implementation.
  final RouteInformationParser<Object>? routeInformationParser;
/// Stores `routerDelegate` state/configuration for this implementation.
  final RouterDelegate<Object>? routerDelegate;
/// Stores `backButtonDispatcher` state/configuration for this implementation.
  final BackButtonDispatcher? backButtonDispatcher;

/// Executes `_resolveTheme` behavior for this component/composite.
  ThemeData _resolveTheme(BuildContext context) {
    final platformBrightness =
        MediaQuery.maybeOf(context)?.platformBrightness ?? Brightness.light;
    final useDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);
    var resolved = useDark ? (darkTheme ?? theme) : theme;
    if (scaling != null) {
      resolved = scaling!.scale(resolved);
    }
    return resolved;
  }

  Widget _wrapWithTheme(
    BuildContext context,
    Widget child,
    ThemeData themeData,
  ) {
    Widget wrapped = Theme(
      data: themeData,
      child: ShadcnUI(child: child),
    );
    if (!enableThemeAnimation) {
      return _wrapWithMaterialFallback(wrapped);
    }
    wrapped = TweenAnimationBuilder<ThemeData>(
      tween: ThemeDataTween(begin: themeData, end: themeData),
      duration: kDefaultDuration,
      builder: (context, value, themedChild) {
        return Theme(data: value, child: themedChild ?? child);
      },
      child: ShadcnUI(child: child),
    );
    return _wrapWithMaterialFallback(wrapped);
  }

/// Executes `_wrapWithMaterialFallback` behavior for this component/composite.
  Widget _wrapWithMaterialFallback(Widget child) {
    if (!materialFallback) {
      return child;
    }
    return material.Material(
      type: material.MaterialType.transparency,
      child: child,
    );
  }

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final resolvedTheme = _resolveTheme(context);
/// Executes `appBuilder` behavior for this component/composite.
    Widget appBuilder(BuildContext context, Widget? child) {
      final built = builder != null ? builder!(context, child) : child;
      final safeChild = built ?? const SizedBox.shrink();
      return OverlayManagerLayer(
        popoverHandler: popoverHandler ?? OverlayHandler.popover,
        tooltipHandler: tooltipHandler ?? OverlayHandler.popover,
        menuHandler: menuHandler ?? OverlayHandler.popover,
        child: _wrapWithTheme(context, safeChild, resolvedTheme),
      );
    }

    if (routerDelegate != null && routeInformationParser != null) {
      return WidgetsApp.router(
        routeInformationProvider: routeInformationProvider,
        routeInformationParser: routeInformationParser!,
        routerDelegate: routerDelegate!,
        backButtonDispatcher: backButtonDispatcher,
        color: color ?? resolvedTheme.colorScheme.primary,
        title: title,
        builder: appBuilder,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        showPerformanceOverlay: showPerformanceOverlay,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
      );
    }

    return WidgetsApp(
      navigatorKey: navigatorKey,
      color: color ?? resolvedTheme.colorScheme.primary,
      title: title,
      home: home,
      routes: routes,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      pageRouteBuilder: pageRouteBuilder ?? _defaultPageRouteBuilder,
      navigatorObservers: navigatorObservers,
      builder: appBuilder,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      actions: actions,
      restorationScopeId: restorationScopeId,
    );
  }
}

PageRoute<T> _defaultPageRouteBuilder<T>(
  RouteSettings settings,
  WidgetBuilder builder,
) => PageRouteBuilder<T>(
  settings: settings,
  pageBuilder: (context, animation, secondaryAnimation) => builder(context),
);

/// A widget that applies shadcn text + icon styles to descendants.
