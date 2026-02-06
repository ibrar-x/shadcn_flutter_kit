import 'dart:async';
import 'dart:math';

import 'package:data_widget/data_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../primitives/form_control.dart';
import '../primitives/form_value_supplier.dart';

part '_impl/core/bi_directional_convert.dart';
part '_impl/core/cached_value_widget.dart';
part '_impl/core/callback_context_action.dart';
part '_impl/core/captured_wrapper.dart';
part '_impl/core/context_callback_action.dart';
part '_impl/core/form_pending_builder.dart';
part '_impl/core/repeated_animation_builder.dart';
part '_impl/core/separated_flex.dart';
part '_impl/core/time_of_day.dart';
part '_impl/state/__cached_value_widget_state.dart';
part '_impl/state/__captured_wrapper_state.dart';
part '_impl/state/__repeated_animation_builder_state.dart';
part '_impl/state/__separated_flex_state.dart';
part '_impl/utils/converted_controller.dart';

typedef Predicate<T> = bool Function(T value);
typedef UnaryOperator<T> = T Function(T value);
typedef BinaryOperator<T> = T Function(T a, T b);
typedef ContextedCallback = void Function(BuildContext context);
typedef ContextedValueChanged<T> = void Function(BuildContext context, T value);
typedef SearchPredicate<T> = double Function(T value, String query);
typedef NeverWidgetBuilder = Widget Function(
    [dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic,
    dynamic]);

/// Mixin for values that need custom rebuild logic.
mixin CachedValue {
  /// Determines if the widget should rebuild when value changes.
  bool shouldRebuild(covariant CachedValue oldValue);
}

/// Callback signature for context actions.
typedef OnContextInvokeCallback<T extends Intent> = Object? Function(T intent,
    [BuildContext? context]);

/// A safe lerp utility class.
class SafeLerp<T> {
  final T? Function(T? a, T? b, double t) nullableLerp;
  const SafeLerp(this.nullableLerp);

  T lerp(T a, T b, double t) {
    T? result = nullableLerp(a, b, t);
    assert(result != null, 'Unsafe lerp');
    return result!;
  }
}

/// Unlerp a double value from a min-max range.
double unlerpDouble(double value, double min, double max) {
  return (value - min) / (max - min);
}

/// Extension on nullable lerp functions.
extension SafeLerpExtension<T> on T? Function(T? a, T? b, double t) {
  T nonNull(T a, T b, double t) {
    T? result = this(a, b, t);
    assert(result != null);
    return result!;
  }
}

/// Extension methods for List operations.
extension ListExtension<T> on List<T> {
  int? indexOfOrNull(T obj, [int start = 0]) {
    int index = indexOf(obj, start);
    return index == -1 ? null : index;
  }

  int? lastIndexOfOrNull(T obj, [int? start]) {
    int index = lastIndexOf(obj, start);
    return index == -1 ? null : index;
  }

  int? indexWhereOrNull(Predicate<T> test, [int start = 0]) {
    int index = indexWhere(test, start);
    return index == -1 ? null : index;
  }

  int? lastIndexWhereOrNull(Predicate<T> test, [int? start]) {
    int index = lastIndexWhere(test, start);
    return index == -1 ? null : index;
  }

  bool swapItem(T element, int targetIndex) {
    int currentIndex = indexOf(element);
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
    int currentIndex = indexWhere(test);
    if (currentIndex == -1) {
      return false;
    }
    T element = this[currentIndex];
    return swapItem(element, targetIndex);
  }

  T? optGet(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index];
  }
}

/// Extension methods for FutureOr transformation.
extension FutureOrExtension<T> on FutureOr<T> {
  FutureOr<R> map<R>(R Function(T value) transform) {
    if (this is Future<T>) {
      return (this as Future<T>).then(transform);
    }
    return transform(this as T);
  }

  FutureOr<R> flatMap<R>(FutureOr<R> Function(T value) transform) {
    if (this is Future<T>) {
      return (this as Future<T>).then(transform);
    }
    return transform(this as T);
  }

  FutureOr<R> then<R>(FutureOr<R> Function(T value) transform) {
    if (this is Future<T>) {
      return (this as Future<T>).then(transform);
    }
    return transform(this as T);
  }

  FutureOr<T> catchError(Function onError,
      {bool Function(Object error)? test}) {
    if (this is Future<T>) {
      return (this as Future<T>).catchError(onError, test: test);
    }
    return this;
  }
}

double wrapDouble(double value, double min, double max) {
  final range = max - min;
  if (range == 0) {
    return min;
  }
  return (value - min) % range + min;
}

/// Widget tree change detector
class WidgetTreeChangeDetector extends StatefulWidget {
  final Widget child;
  final void Function() onWidgetTreeChange;

  const WidgetTreeChangeDetector({
    super.key,
    required this.child,
    required this.onWidgetTreeChange,
  });

  @override
  WidgetTreeChangeDetectorState createState() =>
      WidgetTreeChangeDetectorState();
}

class WidgetTreeChangeDetectorState extends State<WidgetTreeChangeDetector> {
  @override
  void initState() {
    super.initState();
    widget.onWidgetTreeChange();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

Widget gap(double gap, {double? crossGap}) {
  return Gap(
    gap,
    crossAxisExtent: crossGap,
  );
}

/// Extension for joining lists of widgets.
extension Joinable<T extends Widget> on List<T> {
  List<T> joinSeparator(T separator) {
    List<T> result = [];
    for (int i = 0; i < length; i++) {
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

/// An iterable that inserts a separator between each widget.
Iterable<Widget> join(Iterable<Widget> widgets, Widget separator) {
  return SeparatedIterable(widgets, separator);
}

/// Iterable that lazily inserts separators between widgets.
class SeparatedIterable extends Iterable<Widget> {
  final Iterable<Widget> _widgets;
  final Widget _separator;

  SeparatedIterable(this._widgets, this._separator);

  @override
  Iterator<Widget> get iterator => _SeparatedIterator(_widgets.iterator, _separator);
}

class _SeparatedIterator implements Iterator<Widget> {
  final Iterator<Widget> _iterator;
  final Widget _separator;
  bool _isOnSeparator = false;
  bool _hasNext = true;
  Widget? _current;

  _SeparatedIterator(this._iterator, this._separator) {
    _hasNext = _iterator.moveNext();
  }

  @override
  Widget get current => _current!;

  @override
  bool moveNext() {
    if (!_hasNext) {
      return false;
    }

    if (_isOnSeparator) {
      _current = _iterator.current;
      _isOnSeparator = false;
      _hasNext = _iterator.moveNext();
      return true;
    }

    _current = _iterator.current;
    if (!_iterator.moveNext()) {
      _hasNext = false;
      return true;
    }

    _isOnSeparator = true;
    _current = _separator;
    return true;
  }
}

/// Mutates a separated list in place when the source list changes.
void mutateSeparated(List<Widget> source, List<Widget> separated, Widget separator) {
  final expectedLength = source.isEmpty ? 0 : source.length * 2 - 1;
  
  if (separated.length != expectedLength) {
    separated.clear();
    separated.addAll(join(source, separator));
    return;
  }

  for (var i = 0; i < source.length; i++) {
    final separatedIndex = i * 2;
    if (separated[separatedIndex] != source[i]) {
      separated[separatedIndex] = source[i];
    }
  }
}

/// A widget that caches a computed value.
