part of '../menu.dart';

class MenuRadioGroup<T> extends StatelessWidget implements MenuItem {
  /// Currently selected value.
  final T? value;

  /// Callback when selection changes.
  final ContextedValueChanged<T>? onChanged;

  /// List of [MenuRadio] children.
  final List<Widget> children;

  /// Creates a radio group for menu items.
  ///
  /// Parameters:
  /// - [value] (T?): Currently selected value
  /// - [onChanged] (`ContextedValueChanged<T>?`): Selection change callback
  /// - [children] (`List<Widget>`): Radio button children
  const MenuRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.children,
  });

  @override
  bool get hasLeading => children.isNotEmpty;

  @override
  PopoverController? get popoverController => null;

  @override
  Widget build(BuildContext context) {
    final menuGroupData = Data.maybeOf<MenuGroupData>(context);
    assert(
        menuGroupData != null, 'MenuRadioGroup must be a child of MenuGroup');
    return Data<MenuRadioGroup<T>>.inherit(
      data: this,
      child: Flex(
        direction: menuGroupData!.direction,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

/// Individual radio button item within a [MenuRadioGroup].
///
/// Displays a radio button indicator when selected and integrates with
/// the parent radio group for selection management.
