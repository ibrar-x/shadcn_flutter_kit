import 'package:flutter/widgets.dart';

import 'shadcn_scrollbar.dart';

/// A customizable scrollbar widget.
class Scrollbar extends StatelessWidget {
  const Scrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thumbVisibility,
    this.trackVisibility,
    this.thickness,
    this.radius,
    this.color,
    this.notificationPredicate,
    this.interactive,
    this.scrollbarOrientation,
  });

  final Widget child;
  final ScrollController? controller;
  final bool? thumbVisibility;
  final bool? trackVisibility;
  final double? thickness;
  final Radius? radius;
  final Color? color;
  final bool? interactive;
  final ScrollNotificationPredicate? notificationPredicate;
  final ScrollbarOrientation? scrollbarOrientation;

  @override
  Widget build(BuildContext context) {
    return ShadcnScrollbar(
      controller: controller,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      thickness: thickness,
      radius: radius,
      color: color,
      notificationPredicate: notificationPredicate,
      interactive: interactive,
      scrollbarOrientation: scrollbarOrientation,
      child: child,
    );
  }
}
