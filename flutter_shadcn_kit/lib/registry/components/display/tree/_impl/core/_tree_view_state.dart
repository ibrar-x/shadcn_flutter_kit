part of '../../tree.dart';

class _TreeViewState<T> extends State<TreeView<T>> {
  bool _multiSelect = false;
  bool _rangeMultiSelect = false;

  int? _currentFocusedIndex;
  int? _startFocusedIndex;

  void _walkFlattened(
    _TreeWalker<T> walker,
    List<TreeNode<T>> nodes,
    bool parentExpanded,
    List<TreeNodeDepth> depth,
  ) {
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node is TreeItem<T>) {
        List<TreeNodeDepth> newDepth = List.from(depth);
        newDepth.add(TreeNodeDepth(i, nodes.length));
        walker(parentExpanded, node, newDepth);
        _walkFlattened(
            walker, node.children, parentExpanded && node.expanded, newDepth);
      } else if (node is TreeRoot<T>) {
        _walkFlattened(walker, node.children, parentExpanded, depth);
      }
    }
  }

  void _walkNodes(_NodeWalker<T> walker, List<TreeNode<T>> nodes) {
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node is TreeItem<T>) {
        walker(node);
        _walkNodes(walker, node.children);
      } else if (node is TreeRoot<T>) {
        _walkNodes(walker, node.children);
      }
    }
  }

  void _onChangeSelectionRange(
      List<TreeNodeData<T>> children, int start, int end, bool recursive) {
    if (start > end) {
      final temp = start;
      start = end;
      end = temp;
    }
    final selectedItems = <TreeNode<T>>[];
    for (int i = start; i <= end; i++) {
      if (recursive) {
        _walkNodes((node) {
          selectedItems.add(node);
        }, [children[i].node]);
      } else {
        selectedItems.add(children[i].node);
      }
    }
    widget.onSelectionChanged?.call(selectedItems, false, true);
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<TreeTheme>(context);
    final branchLine =
        widget.branchLine ?? compTheme?.branchLine ?? BranchLine.path;
    final expandIcon = widget.expandIcon ?? compTheme?.expandIcon ?? true;
    final allowMultiSelect =
        widget.allowMultiSelect ?? compTheme?.allowMultiSelect ?? true;
    final recursiveSelection =
        widget.recursiveSelection ?? compTheme?.recursiveSelection ?? true;
    final padding = widget.padding ?? compTheme?.padding;
    List<TreeNodeData<T>> children = [];
    int index = 0;
    _walkFlattened((expanded, node, depth) {
      if (node is! TreeItem<T>) return;
      final int currentIndex = index++;
      children.add(TreeNodeData(
        depth,
        node,
        branchLine,
        expanded,
        expandIcon,
        (reason) {
          if (reason == FocusChangeReason.focusScope) {
            _startFocusedIndex = currentIndex;
            _currentFocusedIndex = currentIndex;
            return;
          }
          _currentFocusedIndex = currentIndex;
          if (_rangeMultiSelect && _startFocusedIndex != null) {
            var start = _startFocusedIndex!;
            var end = _currentFocusedIndex!;
            _onChangeSelectionRange(children, start, end, recursiveSelection);
          } else {
            _startFocusedIndex = currentIndex;
            if (recursiveSelection) {
              final selectedItems = <TreeNode<T>>[];
              _walkNodes((node) {
                selectedItems.add(node);
              }, [node]);
              widget.onSelectionChanged
                  ?.call(selectedItems, _multiSelect, !node.selected);
            } else {
              widget.onSelectionChanged
                  ?.call([node], _multiSelect, !node.selected);
            }
          }
        },
      ));
    }, widget.nodes, true, []);
    int selectedCount = 0;
    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      if (child.node is! TreeItem<T> || !child.node.selected) {
        continue;
      }
      if (child.node.selected) {
        bool isNextSelected = false;
        for (int j = i + 1; j < children.length; j++) {
          if (!children[j].expanded || children[j].node is! TreeItem<T>) {
            continue;
          }
          isNextSelected = children[j].node.selected;
          break;
        }
        if (selectedCount == 0) {
          if (isNextSelected) {
            child.selectionPosition = SelectionPosition.start;
          } else {
            child.selectionPosition = SelectionPosition.single;
            selectedCount = 0;
            continue;
          }
        } else {
          if (isNextSelected) {
            child.selectionPosition = SelectionPosition.middle;
          } else {
            child.selectionPosition = SelectionPosition.end;
            selectedCount = 0;
            continue;
          }
        }
        selectedCount++;
      } else {
        child.selectionPosition = null;
        selectedCount = 0;
      }
    }
    return Shortcuts(
      shortcuts: {
        if (allowMultiSelect) ...{
          // range select
          LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowUp):
              const DirectionalSelectTreeNodeIntent(false),
          LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowDown):
              const DirectionalSelectTreeNodeIntent(true),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.arrowUp):
              const DirectionalSelectTreeNodeIntent(false),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.arrowDown):
              const DirectionalSelectTreeNodeIntent(true),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.arrowUp):
              const DirectionalSelectTreeNodeIntent(false),
          LogicalKeySet(
                  LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.arrowDown):
              const DirectionalSelectTreeNodeIntent(true),

          // multi select
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.space):
              const SelectTreeNodeIntent(),
          LogicalKeySet(
                  LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.space):
              const SelectTreeNodeIntent(),
          LogicalKeySet(
                  LogicalKeyboardKey.controlRight, LogicalKeyboardKey.space):
              const SelectTreeNodeIntent(),
        }
      },
      child: Actions(
        actions: {
          SelectTreeNodeIntent: CallbackAction(
            onInvoke: (e) {
              if (_currentFocusedIndex != null) {
                final selectedNode = children[_currentFocusedIndex!];
                if (recursiveSelection) {
                  final selectedItems = <TreeNode<T>>[];
                  _walkNodes((node) {
                    selectedItems.add(node);
                  }, [selectedNode.node]);
                  widget.onSelectionChanged?.call(
                      selectedItems, _multiSelect, !selectedNode.node.selected);
                } else {
                  widget.onSelectionChanged?.call([selectedNode.node],
                      _multiSelect, !selectedNode.node.selected);
                }
              }
              return null;
            },
          ),
          DirectionalSelectTreeNodeIntent: CallbackAction(
            onInvoke: (e) {
              final bool down = (e as DirectionalSelectTreeNodeIntent).forward;
              var currentIndex = _currentFocusedIndex ?? 0;
              _startFocusedIndex ??= _currentFocusedIndex;
              var reverseSelection = currentIndex < _startFocusedIndex!;
              var equalSelection = currentIndex == _startFocusedIndex!;
              if (down) {
                for (int i = currentIndex + 1; i < children.length; i++) {
                  if (children[i].node is TreeItem<T> &&
                      children[i].expanded &&
                      (equalSelection
                          ? !children[i].node.selected
                          : (reverseSelection
                              ? children[i].node.selected
                              : !children[i].node.selected))) {
                    _currentFocusedIndex = i;
                    break;
                  }
                }
              } else {
                for (int i = currentIndex - 1; i >= 0; i--) {
                  if (children[i].node is TreeItem<T> &&
                      children[i].expanded &&
                      (equalSelection
                          ? !children[i].node.selected
                          : (reverseSelection
                              ? !children[i].node.selected
                              : children[i].node.selected))) {
                    _currentFocusedIndex = i;
                    break;
                  }
                }
              }
              _onChangeSelectionRange(children, _startFocusedIndex!,
                  _currentFocusedIndex!, recursiveSelection);
              return null;
            },
          ),
        },
        child: FocusScope(
          node: widget.focusNode,
          onKeyEvent: (node, event) {
            if (!allowMultiSelect) return KeyEventResult.ignored;
            if (event is KeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.shift ||
                  event.logicalKey == LogicalKeyboardKey.shiftLeft ||
                  event.logicalKey == LogicalKeyboardKey.shiftRight) {
                _rangeMultiSelect = true;
              } else if (event.logicalKey == LogicalKeyboardKey.control ||
                  event.logicalKey == LogicalKeyboardKey.controlLeft ||
                  event.logicalKey == LogicalKeyboardKey.controlRight) {
                _multiSelect = true;
              }
            } else if (event is KeyUpEvent) {
              if (event.logicalKey == LogicalKeyboardKey.shift ||
                  event.logicalKey == LogicalKeyboardKey.shiftLeft ||
                  event.logicalKey == LogicalKeyboardKey.shiftRight) {
                _rangeMultiSelect = false;
              } else if (event.logicalKey == LogicalKeyboardKey.control ||
                  event.logicalKey == LogicalKeyboardKey.controlLeft ||
                  event.logicalKey == LogicalKeyboardKey.controlRight) {
                _multiSelect = false;
              }
            }
            return KeyEventResult.ignored;
          },
          child: ListView(
            padding: padding ?? const EdgeInsets.all(8),
            shrinkWrap: widget.shrinkWrap,
            controller: widget.controller,
            children: children
                .map((data) => Data<TreeNodeData>.inherit(
                      data: data,
                      child: Builder(builder: (context) {
                        return widget.builder(
                            context, data.node as TreeItem<T>);
                      }),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
