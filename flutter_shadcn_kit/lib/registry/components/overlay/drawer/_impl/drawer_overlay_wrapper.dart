part of '../drawer.dart';

class _DrawerOverlayWrapper extends StatefulWidget {
  final Widget child;
  final Completer completer;
  const _DrawerOverlayWrapper({
    required this.child,
    required this.completer,
  });

  @override
  State<_DrawerOverlayWrapper> createState() => _DrawerOverlayWrapperState();
}

class _DrawerOverlayWrapperState extends State<_DrawerOverlayWrapper>
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
    if (immediate) {
      widget.completer.complete();
      return widget.completer.future;
    }
    return closeDrawer(context);
  }

  @override
  void closeLater() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          closeDrawer(context);
        } else {
          widget.completer.complete();
        }
      });
    }
  }

  @override
  Future<void> closeWithResult<X>([X? value]) {
    return closeDrawer(context, value);
  }
}

/// Opens a raw drawer overlay with full customization.
///
/// Low-level function for creating custom drawer overlays. Provides complete
/// control over drawer positioning, appearance, and behavior.
///
/// Parameters:
/// - [key] (`Key?`, optional): Widget key.
/// - [context] (`BuildContext`, required): Build context.
/// - [builder] (`DrawerBuilder`, required): Drawer content builder.
/// - [position] (`OverlayPosition`, required): Drawer position on screen.
/// - [transformBackdrop] (`bool`, default: `true`): Whether to transform backdrop.
/// - [useRootDrawerOverlay] (`bool`, default: `true`): Use root overlay.
/// - [modal] (`bool`, default: `true`): Whether drawer is modal.
/// - [barrierColor] (`Color?`, optional): Barrier color.
/// - [barrierDismissible] (`bool`, default: `true`): Dismissible by tapping barrier.
/// - [backdropBuilder] (`WidgetBuilder?`, optional): Custom backdrop builder.
/// - [useSafeArea] (`bool`, default: `true`): Respect safe area.
/// - [animationController] (`AnimationController?`, optional): Custom animation.
/// - [autoOpen] (`bool`, default: `true`): Auto-open on creation.
/// - [constraints] (`BoxConstraints?`, optional): Size constraints.
/// - [alignment] (`AlignmentGeometry?`, optional): Content alignment.
///
/// Returns: `DrawerOverlayCompleter<T?>` for managing the drawer lifecycle.
