part of '../../context_menu.dart';

class _ContextMenuState extends State<ContextMenu> {
  late ValueNotifier<List<MenuItem>> _children;

  @override
  void initState() {
    super.initState();
    _children = ValueNotifier(widget.items);
  }

  @override
  void didUpdateWidget(covariant ContextMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.items, oldWidget.items)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) _children.value = widget.items;
      });
    }
  }

  @override
  void dispose() {
    _children.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final bool enableLongPress =
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    return GestureDetector(
      behavior: widget.behavior,
      onSecondaryTapDown: !widget.enabled
          ? null
          : (details) {
              _showContextMenu(
                context,
                details.globalPosition,
                _children,
                widget.direction,
              );
            },
      onLongPressStart: enableLongPress && widget.enabled
          ? (details) {
              _showContextMenu(
                context,
                details.globalPosition,
                _children,
                widget.direction,
              );
            }
          : null,
      child: widget.child,
    );
  }
}

Future<void> _showContextMenu(
  BuildContext context,
  Offset position,
  ValueListenable<List<MenuItem>> children,
  Axis direction,
) async {
  final key = GlobalKey<OverlayHandlerStateMixin>();
  final theme = Theme.of(context);
  final overlayManager = OverlayManager.of(context);
  return overlayManager
      .showMenu(
        key: key,
        context: context,
        position: position + const Offset(8, 0),
        alignment: Alignment.topLeft,
        anchorAlignment: Alignment.topRight,
        regionGroupId: key,
        modal: true,
        follow: true,
        consumeOutsideTaps: false,
        dismissBackdropFocus: false,
        overlayBarrier: OverlayBarrier(
          borderRadius: BorderRadius.circular(theme.radiusMd),
          barrierColor: const Color(0xB2000000),
        ),
        builder: (context) {
          return AnimatedBuilder(
            animation: children,
            builder: (context, child) {
              bool isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
              return ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 192),
                child: MenuGroup(
                  itemPadding: isSheetOverlay
                      ? EdgeInsets.symmetric(
                              horizontal: theme.density.baseGap,
                            ) *
                            theme.scaling
                      : EdgeInsets.zero,
                  direction: direction,
                  regionGroupId: key,
                  subMenuOffset: const Offset(8, -4),
                  onDismissed: () {
                    closeOverlay(context);
                  },
                  builder: (context, children) {
                    final compTheme = ComponentTheme.maybeOf<ContextMenuTheme>(
                      context,
                    );
                    return MenuPopup(
                      surfaceOpacity: compTheme?.surfaceOpacity,
                      surfaceBlur: compTheme?.surfaceBlur,
                      children: children,
                    );
                  },
                  children: children.value,
                ),
              );
            },
          );
        },
      )
      .future;
}

/// Internal widget for rendering a context menu popup.
///
/// Displays the actual menu content in an overlay with positioning and theming.
/// Typically used internally by [ContextMenu].
