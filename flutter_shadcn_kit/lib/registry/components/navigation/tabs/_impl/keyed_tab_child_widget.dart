part of '../tabs.dart';

class KeyedTabChildWidget<T> extends TabChildWidget with KeyedTabChild<T> {
  /// Creates a keyed tab child widget.
  ///
  /// Parameters:
  /// - [key]: The unique key value for this tab (required)
  /// - [child]: The widget to wrap (required)
  /// - [indexed]: Whether to use indexed positioning (optional)
  KeyedTabChildWidget({
    required T key,
    required super.child,
    super.indexed,
  }) : super(key: ValueKey(key));

  @override
  ValueKey<T> get key => super.key as ValueKey<T>;

  @override
  T get tabKey => key.value;
}

/// A basic tab item widget.
///
/// Represents a single tab item with content that can be displayed
/// in a [TabContainer].
