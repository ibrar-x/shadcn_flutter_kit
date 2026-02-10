part of '../../tooltip.dart';

class _InstantTooltipState extends State<InstantTooltip> {
  final PopoverController _controller = PopoverController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overlayManager = OverlayManager.of(context);
    return MouseRegion(
      onEnter: (event) {
        _controller.close(true);
        _controller.show(
          context: context,
          modal: false,
          builder: widget.tooltipBuilder,
          alignment: widget.tooltipAlignment,
          anchorAlignment: widget.tooltipAnchorAlignment,
          dismissBackdropFocus: false,
          showDuration: Duration.zero,
          hideDuration: Duration.zero,
          overlayBarrier: const OverlayBarrier(barrierColor: Color(0x00000000)),
          handler: OverlayManagerAsTooltipOverlayHandler(
            overlayManager: overlayManager,
          ),
        );
      },
      onExit: (event) {
        _controller.close();
      },
      hitTestBehavior: widget.behavior,
      child: widget.child,
    );
  }
}
