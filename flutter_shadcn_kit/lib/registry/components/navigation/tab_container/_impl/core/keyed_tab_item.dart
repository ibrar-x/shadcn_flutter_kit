part of '../../tab_container.dart';

class KeyedTabItem<T> extends TabItem with KeyedTabChild<T> {
  /// Creates a [KeyedTabItem].
  ///
  /// Parameters:
  /// - [key] (`T`, required): unique key for this tab
  /// - [child] (`Widget`, required): content to display in this tab
  KeyedTabItem({
    required T key,
    required super.child,
  }) : super(key: ValueKey(key));

  @override
  ValueKey<T> get key => super.key as ValueKey<T>;

  @override
  T get tabKey => key.value;
}
