part of '../../markdown.dart';

typedef MarkdownEditingBarActionHandler =
    void Function(BuildContext context, MarkdownEditingController controller);
typedef MarkdownEditingBarItemBuilder =
    Widget Function(
      BuildContext context,
      MarkdownEditingBarItemDetails details,
    );

@immutable
class MarkdownEditingBarAction {
  const MarkdownEditingBarAction({
    required this.id,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isEnabled,
  });

  final String id;
  final IconData icon;
  final String tooltip;
  final MarkdownEditingBarActionHandler onPressed;
  final bool Function(MarkdownEditingController controller)? isEnabled;

  bool enabledFor(MarkdownEditingController controller) {
    return isEnabled?.call(controller) ?? true;
  }

  static List<MarkdownEditingBarAction> defaults() {
    return <MarkdownEditingBarAction>[
      undo(),
      redo(),
      divider(),
      bold(),
      italic(),
      heading(),
      strikethrough(),
      bulletList(),
      orderedList(),
      taskList(),
      quote(),
      codeFence(),
      table(),
      link(),
      image(),
    ];
  }

  static MarkdownEditingBarAction divider() {
    return MarkdownEditingBarAction(
      id: '__divider__',
      icon: Icons.more_vert_rounded,
      tooltip: '',
      onPressed: _noopMarkdownEditAction,
      isEnabled: _alwaysDisabledMarkdownEditAction,
    );
  }

  static MarkdownEditingBarAction undo() {
    return MarkdownEditingBarAction(
      id: 'undo',
      icon: Icons.undo_rounded,
      tooltip: 'Undo',
      onPressed: (context, controller) => controller.undo(),
      isEnabled: (controller) => controller.canUndo,
    );
  }

  static MarkdownEditingBarAction redo() {
    return MarkdownEditingBarAction(
      id: 'redo',
      icon: Icons.redo_rounded,
      tooltip: 'Redo',
      onPressed: (context, controller) => controller.redo(),
      isEnabled: (controller) => controller.canRedo,
    );
  }

  static MarkdownEditingBarAction bold() {
    return MarkdownEditingBarAction(
      id: 'bold',
      icon: Icons.format_bold_rounded,
      tooltip: 'Bold',
      onPressed: (context, controller) =>
          controller.applyTransformer(MarkdownEditingHelpers.toggleBold),
    );
  }

  static MarkdownEditingBarAction italic() {
    return MarkdownEditingBarAction(
      id: 'italic',
      icon: Icons.format_italic_rounded,
      tooltip: 'Italic',
      onPressed: (context, controller) =>
          controller.applyTransformer(MarkdownEditingHelpers.toggleItalic),
    );
  }

  static MarkdownEditingBarAction heading({int level = 2}) {
    return MarkdownEditingBarAction(
      id: 'heading-$level',
      icon: Icons.title_rounded,
      tooltip: 'Heading $level',
      onPressed: (context, controller) => controller.applyTransformer(
        ({required text, required selection}) =>
            MarkdownEditingHelpers.toggleHeading(
              text: text,
              selection: selection,
              level: level,
            ),
      ),
    );
  }

  static MarkdownEditingBarAction strikethrough() {
    return MarkdownEditingBarAction(
      id: 'strikethrough',
      icon: Icons.format_strikethrough_rounded,
      tooltip: 'Strikethrough',
      onPressed: (context, controller) => controller.applyTransformer(
        MarkdownEditingHelpers.toggleStrikethrough,
      ),
    );
  }

  static MarkdownEditingBarAction bulletList() {
    return MarkdownEditingBarAction(
      id: 'bullet-list',
      icon: Icons.format_list_bulleted_rounded,
      tooltip: 'Bullet list',
      onPressed: (context, controller) =>
          controller.applyTransformer(MarkdownEditingHelpers.toggleBulletList),
    );
  }

  static MarkdownEditingBarAction orderedList() {
    return MarkdownEditingBarAction(
      id: 'ordered-list',
      icon: Icons.format_list_numbered_rounded,
      tooltip: 'Ordered list',
      onPressed: (context, controller) =>
          controller.applyTransformer(MarkdownEditingHelpers.toggleOrderedList),
    );
  }

  static MarkdownEditingBarAction taskList() {
    return MarkdownEditingBarAction(
      id: 'task-list',
      icon: Icons.checklist_rtl_rounded,
      tooltip: 'Task list',
      onPressed: (context, controller) =>
          controller.applyTransformer(MarkdownEditingHelpers.toggleTaskList),
    );
  }

  static MarkdownEditingBarAction quote() {
    return MarkdownEditingBarAction(
      id: 'quote',
      icon: Icons.format_quote_rounded,
      tooltip: 'Quote',
      onPressed: (context, controller) =>
          controller.applyTransformer(MarkdownEditingHelpers.toggleQuote),
    );
  }

  static MarkdownEditingBarAction codeFence({String language = 'dart'}) {
    return MarkdownEditingBarAction(
      id: 'code-fence',
      icon: Icons.code_rounded,
      tooltip: 'Code fence',
      onPressed: (context, controller) => controller.applyTransformer(
        ({required text, required selection}) =>
            MarkdownEditingHelpers.wrapCodeFence(
              text: text,
              selection: selection,
              language: language,
            ),
      ),
    );
  }

  static MarkdownEditingBarAction table() {
    return MarkdownEditingBarAction(
      id: 'table',
      icon: Icons.table_chart_rounded,
      tooltip: 'Insert table',
      onPressed: (context, controller) =>
          controller.applyTransformer(MarkdownEditingHelpers.insertTable),
    );
  }

  static MarkdownEditingBarAction link() {
    return MarkdownEditingBarAction(
      id: 'link',
      icon: Icons.link_rounded,
      tooltip: 'Insert link',
      onPressed: (context, controller) =>
          controller.applyTransformer(MarkdownEditingHelpers.insertLink),
    );
  }

  static MarkdownEditingBarAction image() {
    return MarkdownEditingBarAction(
      id: 'image',
      icon: Icons.image_outlined,
      tooltip: 'Insert image',
      onPressed: (context, controller) =>
          controller.applyTransformer(MarkdownEditingHelpers.insertImage),
    );
  }
}

@immutable
class MarkdownEditingBarItemDetails {
  const MarkdownEditingBarItemDetails({
    required this.action,
    required this.controller,
    required this.enabled,
  });

  final MarkdownEditingBarAction action;
  final MarkdownEditingController controller;
  final bool enabled;
}

class MarkdownEditingBar extends StatelessWidget {
  const MarkdownEditingBar({
    super.key,
    required this.controller,
    this.focusNode,
    this.actions,
    this.itemBuilder,
    this.leading,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    this.spacing = 6,
    this.backgroundColor = const Color(0xFF2B2B2F),
    this.borderRadius = const BorderRadius.all(Radius.circular(14)),
    this.borderColor = const Color(0x22FFFFFF),
  });

  final MarkdownEditingController controller;
  final FocusNode? focusNode;
  final List<MarkdownEditingBarAction>? actions;
  final MarkdownEditingBarItemBuilder? itemBuilder;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final resolvedActions = actions ?? MarkdownEditingBarAction.defaults();
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: borderColor),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x24000000),
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        padding: padding,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              if (leading != null) ...<Widget>[
                leading!,
                SizedBox(width: spacing),
              ],
              for (final action in resolvedActions) ...<Widget>[
                _buildAction(context, action),
                SizedBox(width: spacing),
              ],
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAction(BuildContext context, MarkdownEditingBarAction action) {
    if (action.id == '__divider__') {
      return Container(
        width: 1,
        height: 26,
        color: const Color(0x22FFFFFF),
        margin: const EdgeInsets.symmetric(horizontal: 4),
      );
    }

    final enabled = action.enabledFor(controller);
    final details = MarkdownEditingBarItemDetails(
      action: action,
      controller: controller,
      enabled: enabled,
    );
    if (itemBuilder != null) {
      return itemBuilder!(context, details);
    }

    return IconButton(
      onPressed: enabled
          ? () {
              action.onPressed(context, controller);
              focusNode?.requestFocus();
            }
          : null,
      tooltip: action.tooltip,
      style: IconButton.styleFrom(
        backgroundColor: enabled ? const Color(0x0FFFFFFF) : Colors.transparent,
        foregroundColor: enabled
            ? const Color(0xFFF8FAFC)
            : const Color(0x66F8FAFC),
        minimumSize: const Size(38, 38),
        maximumSize: const Size(38, 38),
        padding: EdgeInsets.zero,
      ),
      icon: Icon(action.icon, size: 22),
    );
  }
}

void _noopMarkdownEditAction(
  BuildContext context,
  MarkdownEditingController controller,
) {}

bool _alwaysDisabledMarkdownEditAction(MarkdownEditingController controller) {
  return false;
}
