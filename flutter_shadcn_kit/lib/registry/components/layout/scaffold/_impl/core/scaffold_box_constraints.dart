part of '../../scaffold.dart';

class ScaffoldBoxConstraints extends BoxConstraints {
  /// Height of the header section.
  final double headerHeight;

  /// Height of the footer section.
  final double footerHeight;

  /// Creates [ScaffoldBoxConstraints].
  ///
  /// Parameters:
  /// - [headerHeight] (`double`, required): Header height.
  /// - [footerHeight] (`double`, required): Footer height.
  /// - Additional [BoxConstraints] parameters.
  const ScaffoldBoxConstraints({
    required this.headerHeight,
    required this.footerHeight,
    super.minWidth,
    super.maxWidth,
    super.minHeight,
    super.maxHeight,
  });

  /// Creates [ScaffoldBoxConstraints] from existing [BoxConstraints].
  ///
  /// Parameters:
  /// - [constraints] (`BoxConstraints`, required): Base constraints.
  /// - [headerHeight] (`double`, required): Header height.
  /// - [footerHeight] (`double`, required): Footer height.
  ///
  /// Returns: New [ScaffoldBoxConstraints] with scaffold-specific data.
  factory ScaffoldBoxConstraints.fromBoxConstraints({
    required BoxConstraints constraints,
    required double headerHeight,
    required double footerHeight,
  }) {
    return ScaffoldBoxConstraints(
      headerHeight: headerHeight,
      footerHeight: footerHeight,
      minWidth: constraints.minWidth,
      maxWidth: constraints.maxWidth,
      minHeight: constraints.minHeight,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  ScaffoldBoxConstraints copyWith({
    double? headerHeight,
    double? footerHeight,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return ScaffoldBoxConstraints(
      headerHeight: headerHeight ?? this.headerHeight,
      footerHeight: footerHeight ?? this.footerHeight,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScaffoldBoxConstraints) return false;
    return other.headerHeight == headerHeight &&
        other.footerHeight == footerHeight &&
        other.minWidth == minWidth &&
        other.maxWidth == maxWidth &&
        other.minHeight == minHeight &&
        other.maxHeight == maxHeight;
  }

  @override
  int get hashCode {
    return Object.hash(
      headerHeight,
      footerHeight,
      minWidth,
      maxWidth,
      minHeight,
      maxHeight,
    );
  }

  @override
  String toString() {
    return 'ScaffoldBoxConstraints(headerHeight: $headerHeight, footerHeight: $footerHeight, minWidth: $minWidth, maxWidth: $maxWidth, minHeight: $minHeight, maxHeight: $maxHeight)';
  }
}
