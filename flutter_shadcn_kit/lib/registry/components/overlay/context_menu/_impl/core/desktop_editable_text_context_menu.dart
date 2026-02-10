part of '../../context_menu.dart';

class DesktopEditableTextContextMenu extends StatelessWidget {
  /// Build context for positioning the menu.
  final BuildContext anchorContext;

  /// State of the editable text field.
  final EditableTextState editableTextState;

  /// Optional controller for undo/redo functionality.
  final UndoHistoryController? undoHistoryController;

  /// Creates a [DesktopEditableTextContextMenu].
  ///
  /// Parameters:
  /// - [anchorContext] (`BuildContext`, required): Anchor context.
  /// - [editableTextState] (`EditableTextState`, required): Text field state.
  /// - [undoHistoryController] (`UndoHistoryController?`, optional): Undo controller.
  const DesktopEditableTextContextMenu({
    super.key,
    required this.anchorContext,
    required this.editableTextState,
    this.undoHistoryController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final localizations = ShadcnLocalizations.of(context);
    var undoHistoryController = this.undoHistoryController;
    var contextMenuButtonItems = List.of(
      editableTextState.contextMenuButtonItems,
    );

    ContextMenuButtonItem? take(ContextMenuButtonType type) {
      var item = contextMenuButtonItems
          .where((element) => element.type == type)
          .firstOrNull;
      if (item != null) {
        contextMenuButtonItems.remove(item);
      }
      return item;
    }

    var cutButton = take(ContextMenuButtonType.cut);
    var copyButton = take(ContextMenuButtonType.copy);
    var pasteButton = take(ContextMenuButtonType.paste);
    var selectAllButton = take(ContextMenuButtonType.selectAll);
    var shareButton = take(ContextMenuButtonType.share);
    var searchWebButton = take(ContextMenuButtonType.searchWeb);
    var liveTextInput = take(ContextMenuButtonType.liveTextInput);
    var cutButtonWidget = MenuButton(
      enabled: cutButton != null,
      onPressed: (context) {
        cutButton?.onPressed?.call();
      },
      trailing: const MenuShortcut(
        activator: SingleActivator(LogicalKeyboardKey.keyX, control: true),
      ),
      child: Text(localizations.menuCut),
    );
    var copyButtonWidget = MenuButton(
      enabled: copyButton != null,
      onPressed: (context) {
        copyButton?.onPressed?.call();
      },
      trailing: const MenuShortcut(
        activator: SingleActivator(LogicalKeyboardKey.keyC, control: true),
      ),
      child: Text(localizations.menuCopy),
    );
    var pasteButtonWidget = MenuButton(
      enabled: pasteButton != null,
      onPressed: (context) {
        pasteButton?.onPressed?.call();
      },
      trailing: const MenuShortcut(
        activator: SingleActivator(LogicalKeyboardKey.keyV, control: true),
      ),
      child: Text(localizations.menuPaste),
    );
    var selectAllButtonWidget = MenuButton(
      enabled: selectAllButton != null,
      onPressed: (context) {
        // somehow, we lost focus upon context menu open
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          selectAllButton?.onPressed?.call();
        });
      },
      trailing: const MenuShortcut(
        activator: SingleActivator(LogicalKeyboardKey.keyA, control: true),
      ),
      child: Text(localizations.menuSelectAll),
    );
    List<MenuItem> extras = [];
    if (shareButton != null) {
      extras.add(
        MenuButton(
          onPressed: (context) {
            shareButton.onPressed?.call();
          },
          child: Text(localizations.menuShare),
        ),
      );
    }
    if (searchWebButton != null) {
      extras.add(
        MenuButton(
          onPressed: (context) {
            searchWebButton.onPressed?.call();
          },
          child: Text(localizations.menuSearchWeb),
        ),
      );
    }
    if (liveTextInput != null) {
      extras.add(
        MenuButton(
          onPressed: (context) {
            liveTextInput.onPressed?.call();
          },
          child: Text(localizations.menuLiveTextInput),
        ),
      );
    }
    if (undoHistoryController == null) {
      return TextFieldTapRegion(
        child: _ContextMenuScope(
          child: ContextMenuPopup(
            anchorSize: Size.zero,
            anchorContext: anchorContext,
            position:
                editableTextState.contextMenuAnchors.primaryAnchor +
                const Offset(8, -8) * scaling,
            children: [
              cutButtonWidget,
              copyButtonWidget,
              pasteButtonWidget,
              selectAllButtonWidget,
              if (extras.isNotEmpty) const MenuDivider(),
              ...extras,
            ],
          ),
        ),
      );
    }
    return TextFieldTapRegion(
      child: _ContextMenuScope(
        child: AnimatedBuilder(
          animation: undoHistoryController,
          builder: (context, child) {
            return ContextMenuPopup(
              anchorContext: anchorContext,
              position:
                  editableTextState.contextMenuAnchors.primaryAnchor +
                  const Offset(8, -8) * scaling,
              children: [
                MenuButton(
                  enabled: undoHistoryController.value.canUndo,
                  onPressed: (context) {
                    undoHistoryController.undo();
                  },
                  trailing: const MenuShortcut(
                    activator: SingleActivator(
                      LogicalKeyboardKey.keyZ,
                      control: true,
                    ),
                  ),
                  child: const Text('Undo'),
                ),
                MenuButton(
                  enabled: undoHistoryController.value.canRedo,
                  onPressed: (context) {
                    undoHistoryController.redo();
                  },
                  trailing: const MenuShortcut(
                    activator: SingleActivator(
                      LogicalKeyboardKey.keyZ,
                      control: true,
                      shift: true,
                    ),
                  ),
                  child: const Text('Redo'),
                ),
                const MenuDivider(),
                cutButtonWidget,
                copyButtonWidget,
                pasteButtonWidget,
                selectAllButtonWidget,
                if (extras.isNotEmpty) const MenuDivider(),
                ...extras,
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Context menu for editable text fields on mobile platforms.
///
/// Similar to [DesktopEditableTextContextMenu] but optimized for mobile
/// with horizontal layout and no keyboard shortcuts displayed.
///
/// Typically used internally by text input widgets on mobile platforms.
