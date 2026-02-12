part of '../../scaffold.dart';

/// ScaffoldBarData defines a reusable type for this registry module.
class ScaffoldBarData {
  /// Whether this bar is in the header section (vs footer).
  final bool isHeader;

  /// Zero-based index of this child bar.
  final int childIndex;

  /// Total number of children in this section.
  final int childrenCount;

  /// Creates [ScaffoldBarData].
  const ScaffoldBarData({
    this.isHeader = true,
    required this.childIndex,
    required this.childrenCount,
  });
}
