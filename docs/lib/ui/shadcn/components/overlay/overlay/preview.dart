import 'package:flutter/material.dart';
import '../overlay/overlay.dart';

class OverlayPreview extends StatelessWidget {
  const OverlayPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const OverlayManagerLayer(
      popoverHandler: OverlayHandler.popover,
      tooltipHandler: OverlayHandler.popover,
      menuHandler: OverlayHandler.popover,
      child: Scaffold(
        body: Center(
          child: Text('Overlay manager layer ready'),
        ),
      ),
    );
  }
}
