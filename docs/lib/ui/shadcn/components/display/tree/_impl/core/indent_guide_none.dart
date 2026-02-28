part of '../../tree.dart';

/// Branch line implementation with no visual connections.
///
/// Displays tree nodes without any connecting lines between parent and child
/// nodes. Use this for a minimal tree appearance.
///
/// Example:
/// ```dart
/// TreeView(
///   branchLine: BranchLine.none,
///   // ...
/// );
/// ```
class IndentGuideNone implements BranchLine {
  /// Creates an [IndentGuideNone].
  const IndentGuideNone();

  /// Builds the widget tree for tree.
  @override
  Widget build(BuildContext context, List<TreeNodeDepth> depth, int index) {
    return const SizedBox();
  }
}
