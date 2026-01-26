part of '../tabs.dart';

class TabContainerTheme extends ComponentThemeData {
  /// Default builder for laying out tab children.
  final TabBuilder? builder;

  /// Default builder for wrapping each tab child.
  final TabChildBuilder? childBuilder;

  /// {@macro tab_container_theme}
  const TabContainerTheme({
    this.builder,
    this.childBuilder,
  });

  /// Creates a copy of this theme with the given fields replaced.
  TabContainerTheme copyWith({
    ValueGetter<TabBuilder?>? builder,
    ValueGetter<TabChildBuilder?>? childBuilder,
  }) {
    return TabContainerTheme(
      builder: builder == null ? this.builder : builder(),
      childBuilder: childBuilder == null ? this.childBuilder : childBuilder(),
    );
  }

  @override
  int get hashCode => Object.hash(builder, childBuilder);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabContainerTheme &&
        other.builder == builder &&
        other.childBuilder == childBuilder;
  }

  @override
  String toString() {
    return 'TabContainerTheme(builder: $builder, childBuilder: $childBuilder)';
  }
}

/// Internal data class holding tab container state and callbacks.
///
/// Provides context information to child tabs including the current
/// selection state, tab index, and selection callback. Used internally
/// by the tab system to coordinate between container and children.
///
/// Accessed via [TabContainerData.of] from within tab child widgets.
