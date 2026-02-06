part of '../../overlay.dart';

class ShadcnLayer extends StatelessWidget {
  const ShadcnLayer({
    super.key,
    required this.child,
    this.theme,
    this.popoverHandler = OverlayHandler.popover,
    this.tooltipHandler = OverlayHandler.popover,
    this.menuHandler = OverlayHandler.popover,
  });

  final Widget child;
  final ThemeData? theme;
  final OverlayHandler popoverHandler;
  final OverlayHandler tooltipHandler;
  final OverlayHandler menuHandler;

  @override
  Widget build(BuildContext context) {
    Widget wrapped = child;
    if (theme != null) {
      wrapped = Theme(data: theme!, child: wrapped);
    }
    final hasManager =
        Data.maybeOf<OverlayManager>(context) ?? OverlayManager._current;
    if (hasManager != null) {
      return wrapped;
    }
    return OverlayManagerLayer(
      popoverHandler: popoverHandler,
      tooltipHandler: tooltipHandler,
      menuHandler: menuHandler,
      child: wrapped,
    );
  }
}

/// Layer widget managing different overlay handlers for the application.
///
/// Provides centralized overlay management for popovers, tooltips, and menus
/// with customizable handlers for each type.
