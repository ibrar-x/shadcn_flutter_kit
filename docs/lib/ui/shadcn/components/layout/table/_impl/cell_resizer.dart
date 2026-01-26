part of '../table.dart';

class _CellResizer extends StatefulWidget {
  final ResizableTableController controller;
  final ResizableTableTheme? theme;
  final _HoverCallback onHover;
  final _HoverCallback onDrag;
  final ValueNotifier<_HoveredLine?> hoverNotifier;
  final ValueNotifier<_HoveredLine?> dragNotifier;
  final int maxRow;
  final int maxColumn;

  const _CellResizer({
    required this.controller,
    required this.onHover,
    required this.onDrag,
    required this.hoverNotifier,
    required this.dragNotifier,
    this.theme,
    required this.maxRow,
    required this.maxColumn,
  });

  @override
  State<_CellResizer> createState() => _CellResizerState();
}

