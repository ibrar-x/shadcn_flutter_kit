part of '../../tooltip.dart';

class _TooltipState extends State<Tooltip> {
  final PopoverController _controller = PopoverController();

  @override
  Widget build(BuildContext context) {
    return Hover(
      waitDuration: widget.waitDuration,
      minDuration: widget.minDuration,
      showDuration: widget.showDuration,
      onHover: (hovered) {
        if (hovered) {
          _controller.show(
            context: context,
            modal: false,
            builder: (context) => widget.tooltip(context),
            alignment: widget.alignment,
            anchorAlignment: widget.anchorAlignment,
            dismissBackdropFocus: false,
            overlayBarrier: const OverlayBarrier(
              barrierColor: Color(0x00000000),
            ),
            handler: OverlayManagerAsTooltipOverlayHandler(
                overlayManager: OverlayManager.of(context)),
          );
        } else {
          _controller.close();
        }
      },
      child: widget.child,
    );
  }
}

/// Tooltip that shows immediately on hover.
