part of '../../hover_card.dart';

/// Displays a popover when the child is hovered or long-pressed.

class HoverCard extends StatefulWidget {
  final Widget child;
  final Duration? debounce;
  final Duration? wait;
  final WidgetBuilder hoverBuilder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? anchorAlignment;
  final Offset? popoverOffset;
  final HitTestBehavior? behavior;
  final PopoverController? controller;
  final OverlayHandler? handler;

  const HoverCard({
    super.key,
    required this.child,
    required this.hoverBuilder,
    this.debounce,
    this.wait,
    this.popoverAlignment,
    this.anchorAlignment,
    this.popoverOffset,
    this.behavior,
    this.controller,
    this.handler,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}
