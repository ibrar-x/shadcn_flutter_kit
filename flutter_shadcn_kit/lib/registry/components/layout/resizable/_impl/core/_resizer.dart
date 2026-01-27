part of '../../resizable.dart';

class _Resizer extends StatefulWidget {
  final Axis direction;
  final int index;
  final double thickness;
  final _ResizablePanelState panelState;
  final VoidCallback? onResizeStart;
  final VoidCallback? onResizeEnd;

  const _Resizer({
    required this.direction,
    required this.index,
    required this.thickness,
    required this.panelState,
    this.onResizeStart,
    this.onResizeEnd,
  });

  @override
  State<_Resizer> createState() => _ResizerState();
}
