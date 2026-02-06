import 'package:flutter/widgets.dart';

import '../utils/click_details.dart';
import '../core/click_detector.dart';

class ClickDetectorState extends State<ClickDetector> {
  DateTime? lastClick;
  int count = 0;

  @override
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
