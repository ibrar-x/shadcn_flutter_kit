part of '../drawer.dart';

typedef DrawerBuilder = Widget Function(BuildContext context, Size extraSize,
    Size size, EdgeInsets padding, int stackIndex);

/// Theme configuration for drawer and sheet overlays.
///
/// Defines visual properties for drawer and sheet components including
/// surface effects, drag handles, and barrier appearance.
///
/// Features:
/// - Surface opacity and blur effects
/// - Customizable barrier colors
/// - Drag handle appearance control
/// - Consistent theming across drawer types
///
/// Example:
/// ```dart
/// ComponentThemeData(
///   data: {
///     DrawerTheme: DrawerTheme(
///       surfaceOpacity: 0.9,
///       barrierColor: Colors.black54,
///       showDragHandle: true,
///     ),
///   },
///   child: MyApp(),
/// )
/// ```
