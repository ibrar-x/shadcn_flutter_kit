part of '../../util.dart';


class _CapturedWrapperState extends State<CapturedWrapper> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Widget child = KeyedSubtree(
      key: _key,
      child: widget.child,
    );
    if (widget.themes != null) {
      child = widget.themes!.wrap(child);
    }
    if (widget.data != null) {
      child = widget.data!.wrap(child);
    }
    return child;
  }
}

Widget gap(double gap, {double? crossGap}) {
  return Gap(
    gap,
    crossAxisExtent: crossGap,
  );
}

extension Joinable<T extends Widget> on List<T> {
  List<T> joinSeparator(T separator) {
    if (length <= 1) return this;
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      if (i > 0) {
        result.add(separator);
      }
      result.add(this[i]);
    }
    return result;
  }
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<T> joinSeparator(T separator) {
    return map((e) => [separator, e]).expand((element) => element).skip(1);
  }

  Iterable<T> buildSeparator(ValueGetter<T> separator) {
    return map((e) => [separator(), e]).expand((element) => element).skip(1);
  }
}

extension ListSwapExtension<T> on List<T> {
  bool swapItem(T element, int targetIndex) {
    final currentIndex = indexOf(element);
    if (currentIndex == -1) {
      insert(targetIndex, element);
      return true;
    }
    if (currentIndex == targetIndex) {
      return true;
    }
    if (targetIndex >= length) {
      remove(element);
      add(element);
      return true;
    }
    removeAt(currentIndex);
    if (currentIndex < targetIndex) {
      insert(targetIndex - 1, element);
    } else {
      insert(targetIndex, element);
    }
    return true;
  }

  bool swapItemWhere(Predicate<T> test, int targetIndex) {
    final currentIndex = indexWhere(test);
    if (currentIndex == -1) {
      return false;
    }
    final element = this[currentIndex];
    return swapItem(element, targetIndex);
  }

  T? optGet(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index];
  }
}

void swapItemInLists<T>(
    List<List<T>> lists, T element, List<T> targetList, int targetIndex) {
  for (final list in lists) {
    if (list != targetList) {
      list.remove(element);
    }
  }
  targetList.swapItem(element, targetIndex);
}

(bool enabled, Object? invokeResult) invokeActionOnFocusedWidget(
    Intent intent) {
  final context = primaryFocus?.context;
  if (context != null) {
    final action = Actions.maybeFind<Intent>(context, intent: intent);
    if (action != null) {
      final (bool enabled, Object? invokeResult) =
          Actions.of(context).invokeActionIfEnabled(action, intent);
      return (enabled, invokeResult);
    }
  }
  return (false, null);
}

/// Wraps this widget with padding using directional helpers.
extension WidgetPaddingExtension on Widget {
  /// Adds padding around this widget.
  ///
  /// Parameters mirror the Flutter [Padding] helper in the main repo.
  Widget withPadding({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? horizontal,
    double? vertical,
    double? all,
    EdgeInsetsGeometry? padding,
  }) {
    assert(() {
      if (all != null) {
        if (top != null ||
            bottom != null ||
            left != null ||
            right != null ||
            horizontal != null ||
            vertical != null) {
          throw FlutterError(
              'All padding properties cannot be used with other padding properties.');
        }
      } else if (horizontal != null) {
        if (left != null || right != null) {
          throw FlutterError(
              'Horizontal padding cannot be used with left or right padding.');
        }
      } else if (vertical != null) {
        if (top != null || bottom != null) {
          throw FlutterError(
              'Vertical padding cannot be used with top or bottom padding.');
        }
      }
      return true;
    }());
    final edgeInsets = EdgeInsets.only(
      top: top ?? vertical ?? all ?? 0,
      bottom: bottom ?? vertical ?? all ?? 0,
      left: left ?? horizontal ?? all ?? 0,
      right: right ?? horizontal ?? all ?? 0,
    );
    return Padding(
      padding: padding ?? edgeInsets,
      child: this,
    );
  }
}

/// Wraps this widget with an [Align] using the provided [alignment].
extension WidgetAlignmentExtension on Widget {
  /// Aligns the widget inside an [Align] container.
  Widget withAlign(AlignmentGeometry alignment) {
    return Align(alignment: alignment, child: this);
  }
}

/// Extension providing sizing helpers for widgets.
extension WidgetSizingExtension on Widget {
  /// Wraps this widget in a [SizedBox] with the requested dimensions.
  Widget sized({double? width, double? height}) {
    if (this is SizedBox) {
      return SizedBox(
        width: width ?? (this as SizedBox).width,
        height: height ?? (this as SizedBox).height,
        child: (this as SizedBox).child,
      );
    }
    return SizedBox(width: width, height: height, child: this);
  }

  /// Wraps this widget in a [ConstrainedBox] with the requested constraints.
  Widget constrained({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    double? width,
    double? height,
  }) {
    if (this is ConstrainedBox) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width ??
              minWidth ??
              (this as ConstrainedBox).constraints.minWidth,
          maxWidth: width ??
              maxWidth ??
              (this as ConstrainedBox).constraints.maxWidth,
          minHeight: height ??
              minHeight ??
              (this as ConstrainedBox).constraints.minHeight,
          maxHeight: height ??
              maxHeight ??
              (this as ConstrainedBox).constraints.maxHeight,
        ),
        child: (this as ConstrainedBox).child,
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: width ?? minWidth ?? 0,
        maxWidth: width ?? maxWidth ?? double.infinity,
        minHeight: height ?? minHeight ?? 0,
        maxHeight: height ?? maxHeight ?? double.infinity,
      ),
      child: this,
    );
  }
}

/// Converts between two value types using the provided converters.
