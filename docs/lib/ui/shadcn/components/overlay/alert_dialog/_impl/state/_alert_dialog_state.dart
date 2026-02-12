part of '../../alert_dialog.dart';

class _AlertDialogState extends State<AlertDialog> {
  Widget _wrapIcon(ThemeData theme, Widget icon) {
    return IconTheme(
      data: theme.iconTheme.xLarge
          .copyWith(color: theme.colorScheme.mutedForeground),
      child: icon,
    );
  }

  Widget _wrapTitle(ThemeData theme, Widget title) {
    final style = theme.typography.large.merge(theme.typography.semiBold);
    return DefaultTextStyle.merge(style: style, child: title);
  }

  Widget _wrapContent(ThemeData theme, Widget content) {
    final style = theme.typography.small
        .copyWith(color: theme.colorScheme.mutedForeground);
    return DefaultTextStyle.merge(style: style, child: content);
  }

  List<Widget> _buildHeaderRow(ThemeData theme, double spacing) {
    final children = <Widget>[];
    if (widget.leading != null) {
      children.add(_wrapIcon(theme, widget.leading!));
    }
    if (widget.title != null || widget.content != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(width: spacing));
      }
      final columnChildren = <Widget>[];
      if (widget.title != null) {
        columnChildren.add(_wrapTitle(theme, widget.title!));
      }
      if (widget.title != null && widget.content != null) {
        columnChildren.add(SizedBox(height: 8 * theme.scaling));
      }
      if (widget.content != null) {
        columnChildren.add(_wrapContent(theme, widget.content!));
      }
      children.add(
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnChildren,
          ),
        ),
      );
    }
    if (widget.trailing != null) {
      if (children.isNotEmpty) {
        children.add(SizedBox(width: spacing));
      }
      children.add(_wrapIcon(theme, widget.trailing!));
    }
    return children;
  }

  List<Widget> _buildActions(double spacing) {
    final actions = widget.actions ?? const [];
    if (actions.isEmpty) {
      return const [];
    }
    final widgets = <Widget>[];
    for (var i = 0; i < actions.length; i++) {
      if (i > 0) {
        widgets.add(SizedBox(width: spacing));
      }
      widgets.add(actions[i]);
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final header = _buildHeaderRow(theme, 16 * scaling);
    final actionRow = _buildActions(8 * scaling);

    return ModalBackdrop(
      borderRadius: theme.borderRadiusXxl,
      barrierColor: widget.barrierColor ?? Colors.black.withValues(alpha: 0.8),
      surfaceClip: ModalBackdrop.shouldClipSurface(
        widget.surfaceOpacity ?? theme.surfaceOpacity,
      ),
      child: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 560 * scaling),
          child: ModalContainer(
            fillColor: theme.colorScheme.popover,
            filled: true,
            borderRadius: theme.borderRadiusXxl,
            borderWidth: 1 * scaling,
            borderColor: theme.colorScheme.muted,
            padding: widget.padding ?? EdgeInsets.all(24 * scaling),
            surfaceBlur: widget.surfaceBlur ?? theme.surfaceBlur,
            surfaceOpacity: widget.surfaceOpacity ?? theme.surfaceOpacity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (header.isNotEmpty)
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: header,
                    ),
                  ),
                if (header.isNotEmpty && actionRow.isNotEmpty)
                  SizedBox(height: 16 * scaling),
                if (actionRow.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: actionRow,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
