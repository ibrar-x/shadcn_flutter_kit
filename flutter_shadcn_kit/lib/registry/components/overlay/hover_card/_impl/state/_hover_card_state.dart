part of '../../hover_card.dart';

class _HoverCardState extends State<HoverCard> {
  late PopoverController _controller;
  int _hoverCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PopoverController();
  }

  @override
  void didUpdateWidget(covariant HoverCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? PopoverController();
    }
  }

  @override
  void dispose() {
    _controller.disposePopovers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<HoverCardTheme>(context);
    final debounce = styleValue(
      widgetValue: widget.debounce,
      themeValue: compTheme?.debounce,
      defaultValue: const Duration(milliseconds: 500),
    );
    final wait = styleValue(
      widgetValue: widget.wait,
      themeValue: compTheme?.wait,
      defaultValue: const Duration(milliseconds: 500),
    );
    final popoverAlignment = styleValue(
      widgetValue: widget.popoverAlignment,
      themeValue: compTheme?.popoverAlignment,
      defaultValue: Alignment.topCenter,
    );
    final anchorAlignment = styleValue(
      widgetValue: widget.anchorAlignment,
      themeValue: compTheme?.anchorAlignment,
      defaultValue: Alignment.bottomCenter,
    );
    final popoverOffset = styleValue(
      widgetValue: widget.popoverOffset,
      themeValue: compTheme?.popoverOffset,
      defaultValue: const Offset(0, 8),
    );
    final behavior = styleValue(
      widgetValue: widget.behavior,
      themeValue: compTheme?.behavior,
      defaultValue: HitTestBehavior.deferToChild,
    );

    return MouseRegion(
      hitTestBehavior: behavior,
      onEnter: (_) {
        int count = ++_hoverCount;
        Future.delayed(wait, () {
          if (count == _hoverCount &&
              !_controller.hasOpenPopover &&
              context.mounted) {
            _showPopover(
              context,
              alignment: popoverAlignment,
              anchorAlignment: anchorAlignment,
              offset: popoverOffset,
              debounce: debounce,
            );
          }
        });
      },
      onExit: (_) {
        int count = ++_hoverCount;
        Future.delayed(debounce, () {
          if (count == _hoverCount) {
            _controller.close();
          }
        });
      },
      child: GestureDetector(
        onLongPress: () {
          _showPopover(
            context,
            alignment: popoverAlignment,
            anchorAlignment: anchorAlignment,
            offset: popoverOffset,
            debounce: debounce,
          );
        },
        child: widget.child,
      ),
    );
  }

  void _showPopover(
    BuildContext context, {
    required AlignmentGeometry alignment,
    AlignmentGeometry? anchorAlignment,
    required Offset offset,
    required Duration debounce,
  }) {
    OverlayHandler? handler = widget.handler;
    if (handler == null) {
      final overlayManager = OverlayManager.of(context);
      handler = OverlayManagerAsTooltipOverlayHandler(
        overlayManager: overlayManager,
      );
    }
    _controller.show(
      context: context,
      builder: (context) {
        return MouseRegion(
          onEnter: (_) {
            _hoverCount++;
          },
          onExit: (_) {
            int count = ++_hoverCount;
            Future.delayed(debounce, () {
              if (count == _hoverCount) {
                _controller.close();
              }
            });
          },
          child: widget.hoverBuilder(context),
        );
      },
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      offset: offset,
      handler: handler,
    );
  }
}
