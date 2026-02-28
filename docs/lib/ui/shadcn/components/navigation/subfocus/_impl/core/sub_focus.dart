part of '../../subfocus.dart';

/// SubFocus defines a reusable type for this registry module.
class SubFocus extends StatefulWidget {
  /// Builder function that creates the widget tree with focus state.
  ///
  /// Called with the build context and focus state, allowing the widget
  /// to update its appearance and behavior based on the current focus status.
  final SubFocusBuilder builder;

  /// Whether this focusable element is enabled.
  ///
  /// When `false`, the element cannot receive focus and is excluded from
  /// the focus traversal order. Defaults to `true`.
  final bool enabled;

  /// Creates a focusable widget.
  ///
  /// Parameters:
  /// - [builder]: Widget builder with focus state (required)
  /// - [enabled]: Whether focus is enabled (defaults to `true`)
  const SubFocus({super.key, required this.builder, this.enabled = true});

  @override
/// Executes `createState` behavior for this component/composite.
  State<SubFocus> createState() => _SubFocusState();
}
