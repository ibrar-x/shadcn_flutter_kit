part of '../dialog.dart';

Future<T?> showDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool useSafeArea = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  TraversalEdgeBehavior? traversalEdgeBehavior,
  AlignmentGeometry? alignment,
  bool fullScreen = false,
}) {
  var navigatorState = Navigator.of(
    context,
    rootNavigator: useRootNavigator,
  );
  final CapturedThemes themes =
      InheritedTheme.capture(from: context, to: navigatorState.context);
  final CapturedData data =
      Data.capture(from: context, to: navigatorState.context);
  var dialogRoute = DialogRoute<T>(
    context: context,
    builder: (context) {
      return _DialogOverlayWrapper(
        route: ModalRoute.of(context) as DialogRoute<T>,
        child: Builder(builder: (context) {
          return builder(context);
        }),
      );
    },
    themes: themes,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor ?? const Color.fromRGBO(0, 0, 0, 0),
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    settings: routeSettings,
    anchorPoint: anchorPoint,
    data: data,
    traversalEdgeBehavior:
        traversalEdgeBehavior ?? TraversalEdgeBehavior.closedLoop,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return _buildShadcnDialogTransitions(
        context,
        BorderRadius.zero,
        alignment ?? Alignment.center,
        animation,
        secondaryAnimation,
        fullScreen,
        child,
      );
    },
    alignment: alignment ?? Alignment.center,
  );
  return navigatorState.push(
    dialogRoute,
  );
}

class _DialogOverlayWrapper<T> extends StatefulWidget {
  final DialogRoute<T> route;
  final Widget child;

  const _DialogOverlayWrapper({
    super.key,
    required this.route,
    required this.child,
  });

  @override
  State<_DialogOverlayWrapper<T>> createState() =>
      _DialogOverlayWrapperState<T>();
}

class _DialogOverlayWrapperState<T> extends State<_DialogOverlayWrapper<T>>
    with OverlayHandlerStateMixin {
  @override
  Widget build(BuildContext context) {
    return Data<OverlayHandlerStateMixin>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  Future<void> close([bool immediate = false]) {
    if (immediate || !widget.route.isCurrent) {
      widget.route.navigator?.removeRoute(widget.route);
    } else {
      widget.route.navigator?.pop();
    }
    return widget.route.completed;
  }

  @override
  void closeLater() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.route.isCurrent) {
        widget.route.navigator?.pop();
      } else {
        widget.route.navigator?.removeRoute(widget.route);
      }
    });
  }

  @override
  Future<void> closeWithResult<X>([X? value]) {
    if (widget.route.isCurrent) {
      widget.route.navigator?.pop(value);
    } else {
      widget.route.navigator?.removeRoute(widget.route);
    }
    return widget.route.completed;
  }
}

/// Overlay handler that manages dialog display using the navigation stack.
///
/// Provides a standardized way to show dialogs through the overlay system
/// with proper theme inheritance, animation handling, and modal behavior.
/// Integrates with the shadcn_flutter overlay architecture for consistent
/// dialog management across the application.
///
/// Features:
/// - Navigation-based dialog management
/// - Theme and data inheritance
/// - Configurable modal barriers
/// - Animation integration
/// - Proper focus management
///
/// Example:
/// ```dart
/// const DialogOverlayHandler().show<String>(
///   context: context,
///   alignment: Alignment.center,
///   builder: (context) => MyCustomDialog(),
/// );
/// ```
