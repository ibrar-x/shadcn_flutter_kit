part of '../tooltip.dart';

/// Tooltip that appears after a hover delay.
class Tooltip extends StatefulWidget {
  final Widget child;
  final WidgetBuilder tooltip;
  final AlignmentGeometry alignment;
  final AlignmentGeometry anchorAlignment;
  final Duration waitDuration;
  final Duration showDuration;
  final Duration minDuration;

  const Tooltip({
    super.key,
    required this.child,
    required this.tooltip,
    this.alignment = Alignment.topCenter,
    this.anchorAlignment = Alignment.bottomCenter,
    this.waitDuration = const Duration(milliseconds: 500),
    this.showDuration = const Duration(milliseconds: 200),
    this.minDuration = const Duration(milliseconds: 0),
  });

  @override
  State<Tooltip> createState() => _TooltipState();
}

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
class InstantTooltip extends StatefulWidget {
  final Widget child;
  final HitTestBehavior behavior;
  final WidgetBuilder tooltipBuilder;
  final AlignmentGeometry tooltipAlignment;
  final AlignmentGeometry? tooltipAnchorAlignment;

  const InstantTooltip({
    super.key,
    required this.child,
    required this.tooltipBuilder,
    this.behavior = HitTestBehavior.translucent,
    this.tooltipAlignment = Alignment.bottomCenter,
    this.tooltipAnchorAlignment,
  });

  @override
  State<InstantTooltip> createState() => _InstantTooltipState();
}

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
          overlayBarrier: const OverlayBarrier(
            barrierColor: Color(0x00000000),
          ),
          handler: OverlayManagerAsTooltipOverlayHandler(
              overlayManager: overlayManager),
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
