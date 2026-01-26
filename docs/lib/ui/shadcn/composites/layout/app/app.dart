export '../../../components/display/divider/divider.dart' show Divider;
export '../../../components/layout/scaffold/scaffold.dart' show AppBar, Scaffold;

import 'package:flutter/widgets.dart';

import '../../../shared/primitives/overlay.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/constants.dart';

/// Minimal app wrapper that wires up shadcn theme + overlay handling.
class ShadcnApp extends StatelessWidget {
  const ShadcnApp({
    super.key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
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
  });

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

  ThemeData _resolveTheme(BuildContext context) {
    final platformBrightness =
        MediaQuery.maybeOf(context)?.platformBrightness ?? Brightness.light;
    final useDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && platformBrightness == Brightness.dark);
    var resolved = useDark ? (darkTheme ?? theme) : theme;
    if (scaling != null) {
      resolved = scaling!.scale(resolved);
    }
    return resolved;
  }

  Widget _wrapWithTheme(BuildContext context, Widget child, ThemeData themeData) {
    final wrapped = Theme(
      data: themeData,
      child: ShadcnUI(child: child),
    );
    if (!enableThemeAnimation) {
      return wrapped;
    }
    return TweenAnimationBuilder<ThemeData>(
      tween: ThemeDataTween(begin: themeData, end: themeData),
      duration: kDefaultDuration,
      builder: (context, value, themedChild) {
        return Theme(data: value, child: themedChild ?? child);
      },
      child: ShadcnUI(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = _resolveTheme(context);
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
      navigatorObservers: navigatorObservers,
      builder: (context, child) {
        final built = builder != null ? builder!(context, child) : child;
        final safeChild = built ?? const SizedBox.shrink();
        return OverlayManagerLayer(
          popoverHandler: popoverHandler ?? OverlayHandler.popover,
          tooltipHandler: tooltipHandler ?? OverlayHandler.popover,
          menuHandler: menuHandler ?? OverlayHandler.popover,
          child: _wrapWithTheme(context, safeChild, resolvedTheme),
        );
      },
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

/// A widget that applies shadcn text + icon styles to descendants.
class ShadcnUI extends StatelessWidget {
  const ShadcnUI({
    super.key,
    this.textStyle,
    required this.child,
  });

  final TextStyle? textStyle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedDefaultTextStyle(
      style: textStyle ??
          theme.typography.sans.copyWith(
            color: theme.colorScheme.foreground,
          ),
      duration: kDefaultDuration,
      child: IconTheme(
        data: IconThemeData(color: theme.colorScheme.foreground),
        child: child,
      ),
    );
  }
}
