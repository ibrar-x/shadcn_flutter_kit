import 'package:flutter/widgets.dart';

import '../utils/click_details.dart';
import '../core/click_detector.dart';

/// ClickDetectorState defines a reusable type for this registry module.
class ClickDetectorState extends State<ClickDetector> {
/// Stores `lastClick` state/configuration for this implementation.
  DateTime? lastClick;
/// Stores `count` state/configuration for this implementation.
  int count = 0;

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: widget.onClick == null
          ? null
          : () {
              final now = DateTime.now();
              if (lastClick == null ||
                  (now.difference(lastClick!) > widget.threshold)) {
                count = 1;
              } else {
                count++;
              }
              widget.onClick?.call(ClickDetails(clickCount: count));
              lastClick = now;
            },
      child: widget.child,
    );
  }
}
