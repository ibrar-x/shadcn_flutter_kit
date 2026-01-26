part of '../tabs.dart';

class TabContainer extends StatelessWidget {
  /// Currently selected tab index.
  final int selected;

  /// Callback when tab selection changes.
  final ValueChanged<int>? onSelect;

  /// List of tab children to display.
  final List<TabChild> children;

  /// Optional custom tab layout builder.
  final TabBuilder? builder;

  /// Optional custom child widget builder.
  final TabChildBuilder? childBuilder;

  /// Creates a [TabContainer].
  ///
  /// Parameters:
  /// - [selected] (`int`, required): index of the selected tab
  /// - [onSelect] (`ValueChanged<int>?`, optional): callback when tab changes
  /// - [children] (`List<TabChild>`, required): list of tab items
  /// - [builder] (`TabBuilder?`, optional): custom tab layout builder
  /// - [childBuilder] (`TabChildBuilder?`, optional): custom child builder
  const TabContainer({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.children,
    this.builder,
    this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<TabContainerTheme>(context);
    final tabBuilder = builder ??
        compTheme?.builder ??
        (context, children) => Column(children: children);
    final tabChildBuilder =
        childBuilder ?? compTheme?.childBuilder ?? ((_, __, child) => child);

    List<Widget> wrappedChildren = [];
    int index = 0;
    for (TabChild child in children) {
      if (child.indexed) {
        wrappedChildren.add(
          Data.inherit(
            key: ValueKey(child),
            data: TabContainerData(
              index: index,
              selected: selected,
              onSelect: onSelect,
              childBuilder: tabChildBuilder,
            ),
            child: child,
          ),
        );
        index++;
      } else {
        wrappedChildren.add(child);
      }
    }
    return tabBuilder(
      context,
      wrappedChildren,
    );
  }
}
