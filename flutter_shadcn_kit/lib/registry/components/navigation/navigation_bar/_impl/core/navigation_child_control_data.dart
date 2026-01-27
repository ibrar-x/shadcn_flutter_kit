part of '../../navigation_bar.dart';

class NavigationChildControlData {
  /// Logical index for selection (null if not selectable).
  final int? index;

  /// Actual position index in the navigation layout.
  final int actualIndex;

  /// Creates navigation child control data.
  ///
  /// Parameters:
  /// - [index] (int?): Logical selection index
  /// - [actualIndex] (int, required): Layout position index
  NavigationChildControlData({this.index, required this.actualIndex});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigationChildControlData &&
        other.index == index &&
        other.actualIndex == actualIndex;
  }

  @override
  int get hashCode {
    return Object.hash(index, actualIndex);
  }
}
