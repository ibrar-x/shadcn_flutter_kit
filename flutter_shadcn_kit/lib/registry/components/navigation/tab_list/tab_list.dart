import 'package:flutter/material.dart' hide Theme, ThemeData;

import '../../../shared/theme/theme.dart';
import '../../../shared/utils/style_value.dart';
import '../../control/button/button.dart';
import '../tab_container/tab_container.dart';

/// Theme configuration for [TabList] appearance and behavior.
///
/// TabListTheme defines the visual styling for tab list components including
/// border colors, indicator styling, and dimensional properties. All properties
/// are optional and fall back to theme defaults when not specified.
///
/// Example:
/// ```dart
/// ComponentTheme<TabListTheme>(
///   data: TabListTheme(
///     borderColor: Colors.grey,
///     borderWidth: 2.0,
///     indicatorColor: Colors.blue,
///     indicatorHeight: 3.0,
///   ),
///   child: TabList(...),
/// )
/// ```
class TabListTheme extends ComponentThemeData {
  /// Color of the bottom border line separating tabs from content.
  final Color? borderColor;

  /// Width of the bottom border line in logical pixels.
  final double? borderWidth;

  /// Color of the active tab indicator line.
  final Color? indicatorColor;

  /// Height of the active tab indicator line in logical pixels.
  final double? indicatorHeight;

  /// Creates a [TabListTheme].
  const TabListTheme({
    this.borderColor,
    this.borderWidth,
    this.indicatorColor,
    this.indicatorHeight,
  });

  /// Creates a copy with specified fields replaced.
  TabListTheme copyWith({
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<Color?>? indicatorColor,
    ValueGetter<double?>? indicatorHeight,
  }) {
    return TabListTheme(
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      indicatorColor:
          indicatorColor == null ? this.indicatorColor : indicatorColor(),
      indicatorHeight: indicatorHeight == null
          ? this.indicatorHeight
          : indicatorHeight(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabListTheme &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.indicatorColor == indicatorColor &&
        other.indicatorHeight == indicatorHeight;
  }

  @override
  int get hashCode =>
      Object.hash(borderColor, borderWidth, indicatorColor, indicatorHeight);
}

/// A horizontal tab list widget for selecting between multiple tab content areas.
///
/// TabList provides a classic tab interface with a horizontal row of tab buttons
/// and an active tab indicator. It handles tab selection state and provides visual
/// feedback for the currently active tab through styling and an indicator line.
///
/// The widget automatically manages the appearance of tab buttons, applying
/// appropriate styling for active and inactive states. The active tab is
/// highlighted with foreground styling and the indicator line at the bottom.
///
/// Features:
/// - Horizontal row of selectable tab buttons
/// - Visual active tab indicator with customizable styling
/// - Automatic tab button state management (active/inactive)
/// - Theme-aware styling with customizable colors and dimensions
/// - Integration with TabContainer for coordinated tab management
///
/// The TabList works as part of a complete tab system, typically used with
/// corresponding content areas that show/hide based on the selected tab.
///
/// Example:
/// ```dart
/// TabList(
///   index: currentTabIndex,
///   onChanged: (index) => setState(() => currentTabIndex = index),
///   children: [
///     TabChild(child: Text('Tab 1')),
///     TabChild(child: Text('Tab 2')),
///     TabChild(child: Text('Tab 3')),
///   ],
/// )
/// ```
class TabList extends StatelessWidget {
  /// List of tab child widgets to display in the tab list.
  final List<TabChild> children;

  /// Index of the currently active/selected tab.
  final int index;

  /// Callback invoked when a tab is selected.
  final ValueChanged<int>? onChanged;

  /// Creates a [TabList] with horizontal tab selection.
  const TabList({
    super.key,
    required this.children,
    required this.index,
    required this.onChanged,
  });

  Widget _childBuilder(
    BuildContext context,
    TabContainerData data,
    Widget child,
  ) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<TabListTheme>(context);
    final indicatorColor = styleValue(
      defaultValue: theme.colorScheme.primary,
      themeValue: compTheme?.indicatorColor,
    );
    final indicatorHeight = styleValue(
      defaultValue: 2 * theme.scaling,
      themeValue: compTheme?.indicatorHeight,
    );
    child = TabButton(
      enabled: data.onSelect != null,
      onPressed: () {
        data.onSelect?.call(data.index);
      },
      child: child,
    );
    return Stack(
      fit: StackFit.passthrough,
      children: [
        data.index == index ? child.foreground() : child.muted(),
        if (data.index == index)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(height: indicatorHeight, color: indicatorColor),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<TabListTheme>(context);
    final borderColor = styleValue(
      defaultValue: theme.colorScheme.border,
      themeValue: compTheme?.borderColor,
    );
    final borderWidth = styleValue(
      defaultValue: 1 * scaling,
      themeValue: compTheme?.borderWidth,
    );
    return TabContainer(
      selected: index,
      onSelect: onChanged,
      builder: (context, children) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: borderColor, width: borderWidth),
            ),
          ),
          child: Row(children: children),
        );
      },
      childBuilder: _childBuilder,
    children: children,
  );
}
}

extension _TabListTextStyles on Widget {
  Widget muted() {
    return _TabListTextStyle(
      child: this,
      styleBuilder: (theme) => TextStyle(
        color: theme.colorScheme.mutedForeground,
      ),
    );
  }

  Widget foreground() {
    return _TabListTextStyle(
      child: this,
      styleBuilder: (theme) => TextStyle(
        color: theme.colorScheme.foreground,
      ),
    );
  }
}

class _TabListTextStyle extends StatelessWidget {
  final Widget child;
  final TextStyle Function(ThemeData theme) styleBuilder;

  const _TabListTextStyle({
    required this.child,
    required this.styleBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(
      style: styleBuilder(theme),
      child: child,
    );
  }
}
