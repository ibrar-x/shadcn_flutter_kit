part of '../collapsible.dart';

/// Shared state used by [CollapsibleTrigger] and [CollapsibleContent].
class CollapsibleStateData {
  /// Creates shared state data.
  const CollapsibleStateData({
    required this.isExpanded,
    required this.handleTap,
  });

  /// Current expansion state.
  final bool isExpanded;

  /// Callback invoked when the trigger is tapped.
  final VoidCallback handleTap;
}
