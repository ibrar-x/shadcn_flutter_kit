part of '../menu.dart';

class _MenuButtonState extends State<MenuButton> {
  final ValueNotifier<List<MenuItem>> _children = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _children.value = widget.subMenu ?? [];
  }

  @override
  void didUpdateWidget(covariant MenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.subMenu, oldWidget.subMenu)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          _children.value = widget.subMenu ?? [];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarData = Data.maybeOf<MenubarState>(context);
    final menuData = Data.maybeOf<MenuData>(context);
    final menuGroupData = Data.maybeOf<MenuGroupData>(context);
    assert(menuGroupData != null, 'MenuButton must be a child of MenuGroup');
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<MenuTheme>(context);
    final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
    final isDialogOverlay = DialogOverlayHandler.isDialogOverlay(context);
    final isIndependentOverlay = isSheetOverlay || isDialogOverlay;
    void openSubMenu(BuildContext context, bool autofocus) {
      menuGroupData!.closeOthers();
      final overlayManager = OverlayManager.of(context);
      menuData!.popoverController.show(
        context: context,
        regionGroupId: menuGroupData.regionGroupId,
        consumeOutsideTaps: false,
        dismissBackdropFocus: false,
        modal: true,
        handler: MenuOverlayHandler(overlayManager),
        overlayBarrier: OverlayBarrier(
          borderRadius: BorderRadius.circular(theme.radiusMd),
        ),
        builder: (context) {
          final theme = Theme.of(context);
          final scaling = theme.scaling;
          var itemPadding = menuGroupData.itemPadding;
          final isSheetOverlay = SheetOverlayHandler.isSheetOverlay(context);
          if (isSheetOverlay) {
            itemPadding = const EdgeInsets.symmetric(horizontal: 8) * scaling;
          }
          return ConstrainedBox(
            constraints: const BoxConstraints(
                  minWidth: 192, // 12rem
                ) *
                scaling,
            child: AnimatedBuilder(
                animation: _children,
                builder: (context, child) {
                  return MenuGroup(
                      direction: menuGroupData.direction,
                      parent: menuGroupData,
                      onDismissed: menuGroupData.onDismissed,
                      regionGroupId: menuGroupData.regionGroupId,
                      subMenuOffset: compTheme?.subMenuOffset ??
                          const Offset(8, -4 + -1) * scaling,
                      itemPadding: itemPadding,
                      autofocus: autofocus,
                      builder: (context, children) {
                        return MenuPopup(
                          children: children,
                        );
                      },
                      children: _children.value);
                }),
          );
        },
        alignment: Alignment.topLeft,
        anchorAlignment:
            menuBarData != null ? Alignment.bottomLeft : Alignment.topRight,
        offset: menuGroupData.subMenuOffset ?? compTheme?.subMenuOffset,
      );
    }

    return Actions(
      actions: {
        OpenSubMenuIntent: ContextCallbackAction<OpenSubMenuIntent>(
          onInvoke: (intent, [context]) {
            if (widget.subMenu?.isNotEmpty ?? false) {
              openSubMenu(this.context, true);
              return true;
            }
            return false;
          },
        ),
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) {
            widget.onPressed?.call(context);
            if (widget.subMenu?.isNotEmpty ?? false) {
              openSubMenu(context, true);
            }
            if (widget.autoClose) {
              menuGroupData!.closeAll();
            }
            return;
          },
        ),
      },
      child: SubFocus(
          enabled: widget.enabled,
          builder: (context, subFocusState) {
            bool hasFocus = subFocusState.isFocused && menuBarData == null;
            return Data<MenuData>.boundary(
              child: Data<MenubarState>.boundary(
                child: TapRegion(
                  groupId: menuGroupData!.root,
                  child: AnimatedBuilder(
                      animation: menuData!.popoverController,
                      builder: (context, child) {
                        return Button(
                          disableFocusOutline: true,
                          alignment: menuGroupData.direction == Axis.vertical
                              ? AlignmentDirectional.centerStart
                              : Alignment.center,
                          style: (menuBarData == null
                                  ? ButtonVariance.menu
                                  : ButtonVariance.menubar)
                              .copyWith(
                            padding: (context, states, value) {
                              return value.optionallyResolve(context) +
                                  menuGroupData.itemPadding;
                            },
                            decoration: (context, states, value) {
                              final theme = Theme.of(context);
                              return (value as BoxDecoration).copyWith(
                                color:
                                    menuData.popoverController.hasOpenPopover ||
                                            hasFocus
                                        ? theme.colorScheme.accent
                                        : null,
                                borderRadius:
                                    BorderRadius.circular(theme.radiusMd),
                              );
                            },
                          ),
                          trailing: menuBarData != null
                              ? widget.trailing
                              : widget.trailing != null ||
                                      (widget.subMenu != null &&
                                          menuBarData == null)
                                  ? Row(
                                      children: [
                                        if (widget.trailing != null)
                                          widget.trailing!,
                                        if (widget.subMenu != null &&
                                            menuBarData == null)
                                          const Icon(
                                            RadixIcons.chevronRight,
                                          ).iconSmall(),
                                      ],
                                    ).gap(8 * scaling)
                                  : null,
                          leading: widget.leading == null &&
                                  menuGroupData.hasLeading &&
                                  menuBarData == null
                              ? SizedBox(width: 16 * scaling)
                              : widget.leading == null
                                  ? null
                                  : SizedBox(
                                      width: 16 * scaling,
                                      height: 16 * scaling,
                                      child: widget.leading!.iconSmall(),
                                    ),
                          disableTransition: true,
                          enabled: widget.enabled,
                          focusNode: widget.focusNode,
                          onHover: (value) {
                            if (value) {
                              subFocusState.requestFocus();
                              if ((menuBarData == null ||
                                      menuGroupData.hasOpenPopovers) &&
                                  widget.subMenu != null &&
                                  widget.subMenu!.isNotEmpty) {
                                if (!menuData
                                        .popoverController.hasOpenPopover &&
                                    !isIndependentOverlay) {
                                  openSubMenu(context, false);
                                }
                              } else {
                                menuGroupData.closeOthers();
                              }
                            } else {
                              subFocusState.unfocus();
                            }
                          },
                          onPressed: () {
                            widget.onPressed?.call(context);
                            if (widget.subMenu != null &&
                                widget.subMenu!.isNotEmpty) {
                              if (!menuData.popoverController.hasOpenPopover) {
                                openSubMenu(context, false);
                              }
                            } else {
                              if (widget.autoClose) {
                                menuGroupData.closeAll();
                              }
                            }
                          },
                          child: widget.child,
                        );
                      }),
                ),
              ),
            );
          }),
    );
  }
}

/// Data class containing menu group state and configuration.
///
/// Manages the hierarchical structure of menu groups, tracking parent-child
/// relationships, popover state, and layout properties. Used internally by
/// the menu system to coordinate behavior across nested menus.
