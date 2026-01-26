part of '../menu.dart';

class _MenuGroupState extends State<MenuGroup> {
  late List<MenuData> _data;

  @override
  void initState() {
    super.initState();
    _data = List.generate(widget.children.length, (i) {
      return MenuData();
    });
  }

  @override
  void didUpdateWidget(covariant MenuGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.children, widget.children)) {
      Map<Key, MenuData> oldKeyedData = {};
      for (int i = 0; i < oldWidget.children.length; i++) {
        oldKeyedData[oldWidget.children[i].key ?? ValueKey(i)] = _data[i];
      }
      _data = List.generate(widget.children.length, (i) {
        var child = widget.children[i];
        var key = child.key ?? ValueKey(i);
        var oldData = oldKeyedData[key];
        if (oldData != null) {
          if (child.popoverController != null &&
              oldData.popoverController != child.popoverController) {
            oldData.popoverController.dispose();
            oldData = MenuData(popoverController: child.popoverController);
          }
        } else {
          oldData = MenuData(popoverController: child.popoverController);
        }
        return oldData;
      });
      // dispose unused data
      for (var data in oldKeyedData.values) {
        if (!_data.contains(data)) {
          data.popoverController.dispose();
        }
      }
    }
  }

  @override
  void dispose() {
    for (var data in _data) {
      data.popoverController.dispose();
    }
    super.dispose();
  }

  void closeAll() {
    MenuGroupData? data = widget.parent;
    if (data == null) {
      widget.onDismissed?.call();
      return;
    }
    data.closeOthers();
    data.closeAll();
  }

  @override
  Widget build(BuildContext context) {
    final parentGroupData = Data.maybeOf<MenuGroupData>(context);
    final menubarData = Data.maybeOf<MenubarState>(context);
    final compTheme = ComponentTheme.maybeOf<MenuTheme>(context);
    final itemPadding =
        widget.itemPadding ?? compTheme?.itemPadding ?? EdgeInsets.zero;
    final subMenuOffset = widget.subMenuOffset ?? compTheme?.subMenuOffset;
    List<Widget> children = [];
    bool hasLeading = false;
    for (int i = 0; i < widget.children.length; i++) {
      final child = widget.children[i];
      final data = _data[i];
      if (child.hasLeading) {
        hasLeading = true;
      }
      children.add(
        Data<MenuData>.inherit(
          data: data,
          child: child,
        ),
      );
    }
    final direction = Directionality.of(context);
    return SubFocusScope(
        autofocus: widget.autofocus,
        builder: (context, scope) {
          return Actions(
            actions: {
              NextMenuFocusIntent: CallbackAction<NextMenuFocusIntent>(
                onInvoke: (intent) {
                  scope.nextFocus(intent.forward
                      ? widget.direction == Axis.horizontal
                          ? TraversalDirection.left
                          : TraversalDirection.up
                      : widget.direction == Axis.horizontal
                          ? TraversalDirection.right
                          : TraversalDirection.down);
                  return;
                },
              ),
              DirectionalMenuFocusIntent:
                  CallbackAction<DirectionalMenuFocusIntent>(
                onInvoke: (intent) {
                  if (widget.direction == Axis.vertical) {
                    if (intent.direction == TraversalDirection.left) {
                      if (direction == TextDirection.ltr) {
                        for (final menu in parentGroupData?.children ?? []) {
                          menu.popoverController.close();
                        }
                        return;
                      } else {}
                    } else if (intent.direction == TraversalDirection.right) {
                      if (direction == TextDirection.ltr) {
                        bool? result = scope.invokeActionOnFocused(
                            const OpenSubMenuIntent()) as bool?;
                        if (result != true) {
                          parentGroupData?.root.focusScope
                              .nextFocus(TraversalDirection.right);
                        }
                        return;
                      } else {}
                    }
                  }
                  if (!scope.nextFocus(intent.direction)) {
                    for (final menu in parentGroupData?.children ?? []) {
                      menu.popoverController.close();
                    }
                    parentGroupData?.focusScope.nextFocus(
                      intent.direction,
                    );
                  }
                  return;
                },
              ),
              CloseMenuIntent: CallbackAction<CloseMenuIntent>(
                onInvoke: (intent) {
                  closeAll();
                  return;
                },
              ),
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (intent) {
                  scope.invokeActionOnFocused(const ActivateIntent());
                  return;
                },
              ),
              ...widget.actions,
            },
            child: Shortcuts(
              shortcuts: {
                const SingleActivator(LogicalKeyboardKey.arrowUp):
                    const DirectionalMenuFocusIntent(TraversalDirection.up),
                const SingleActivator(LogicalKeyboardKey.arrowDown):
                    const DirectionalMenuFocusIntent(TraversalDirection.down),
                const SingleActivator(LogicalKeyboardKey.arrowLeft):
                    const DirectionalMenuFocusIntent(TraversalDirection.left),
                const SingleActivator(LogicalKeyboardKey.arrowRight):
                    const DirectionalMenuFocusIntent(TraversalDirection.right),
                const SingleActivator(LogicalKeyboardKey.tab):
                    DirectionalMenuFocusIntent(widget.direction == Axis.vertical
                        ? TraversalDirection.down
                        : TraversalDirection.right),
                const SingleActivator(LogicalKeyboardKey.tab, shift: true):
                    DirectionalMenuFocusIntent(widget.direction == Axis.vertical
                        ? TraversalDirection.up
                        : TraversalDirection.left),
                const SingleActivator(LogicalKeyboardKey.escape):
                    const CloseMenuIntent(),
                const SingleActivator(LogicalKeyboardKey.enter):
                    const ActivateIntent(),
                const SingleActivator(LogicalKeyboardKey.space):
                    const ActivateIntent(),
                const SingleActivator(LogicalKeyboardKey.backspace):
                    const CloseMenuIntent(),
                const SingleActivator(LogicalKeyboardKey.numpadEnter):
                    const ActivateIntent(),
              },
              child: Focus(
                autofocus: menubarData == null,
                focusNode: widget.focusNode,
                child: Data.inherit(
                  data: MenuGroupData(
                    widget.parent,
                    _data,
                    hasLeading,
                    subMenuOffset,
                    widget.onDismissed,
                    widget.regionGroupId,
                    widget.direction,
                    itemPadding,
                    scope,
                  ),
                  child: Builder(builder: (context) {
                    return widget.builder(context, children);
                  }),
                ),
              ),
            ),
          );
        });
  }
}

/// Intent for closing the current menu via keyboard action.
///
/// Used with keyboard shortcuts to dismiss open menus.
