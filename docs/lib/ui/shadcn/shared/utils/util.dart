import 'dart:math';

import 'package:data_widget/data_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../primitives/form_control.dart';
import '../primitives/form_value_supplier.dart';

typedef Predicate<T> = bool Function(T value);
typedef UnaryOperator<T> = T Function(T value);
typedef ContextedCallback = void Function(BuildContext context);
typedef ContextedValueChanged<T> = void Function(BuildContext context, T value);
typedef SearchPredicate<T> = double Function(T value, String query);

/// Mixin for values that need custom rebuild logic.
mixin CachedValue {
  /// Determines if the widget should rebuild when value changes.
  bool shouldRebuild(covariant CachedValue oldValue);
}

/// A widget that caches a computed value.
class CachedValueWidget<T> extends StatefulWidget {
  /// The value to cache and pass to builder.
  final T value;

  /// Builder function that creates the widget from the value.
  final Widget Function(BuildContext context, T value) builder;

  /// Creates a [CachedValueWidget].
  const CachedValueWidget({
    super.key,
    required this.value,
    required this.builder,
  });

  @override
  State<StatefulWidget> createState() => _CachedValueWidgetState<T>();
}

class _CachedValueWidgetState<T> extends State<CachedValueWidget<T>> {
  Widget? _cachedWidget;

  @override
  void didUpdateWidget(covariant CachedValueWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (T is CachedValue) {
      if ((widget.value as CachedValue)
          .shouldRebuild(oldWidget.value as CachedValue)) {
        _cachedWidget = null;
      }
    } else {
      if (widget.value != oldWidget.value) {
        _cachedWidget = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _cachedWidget ??= widget.builder(context, widget.value);
    return _cachedWidget!;
  }
}

double degToRad(double deg) => deg * (pi / 180);

double unlerpDouble(double value, double min, double max) {
  return (value - min) / (max - min);
}

typedef OnContextInvokeCallback<T extends Intent> = Object? Function(T intent,
    [BuildContext? context]);

class CallbackContextAction<T extends Intent> extends ContextAction<T> {
  final OnContextInvokeCallback onInvoke;
  CallbackContextAction({required this.onInvoke});

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    return onInvoke(intent, context);
  }
}

typedef OnContextedCallback<T extends Intent> = Object? Function(T intent,
    [BuildContext? context]);

class ContextCallbackAction<T extends Intent> extends ContextAction<T> {
  final OnContextedCallback<T> onInvoke;
  ContextCallbackAction({required this.onInvoke});

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    return onInvoke(intent, context);
  }
}

typedef FormPendingWidgetBuilder = Widget Function(
  BuildContext context,
  Map<FormKey, Future<ValidationResult?>> pending,
  Widget? child,
);

class FormPendingBuilder extends StatelessWidget {
  final Widget? child;
  final FormPendingWidgetBuilder builder;

  const FormPendingBuilder({super.key, required this.builder, this.child});

  @override
  Widget build(BuildContext context) {
    return builder(context, const {}, child);
  }
}

typedef RepeatedAnimationWidgetBuilder = Widget Function(
  BuildContext context,
  double value,
  Widget? child,
);

class RepeatedAnimationBuilder extends StatefulWidget {
  final double start;
  final double end;
  final Duration duration;
  final Curve curve;
  final RepeatedAnimationWidgetBuilder builder;
  final Widget? child;

  const RepeatedAnimationBuilder({
    super.key,
    required this.start,
    required this.end,
    required this.duration,
    this.curve = Curves.linear,
    required this.builder,
    this.child,
  });

  @override
  State<RepeatedAnimationBuilder> createState() =>
      _RepeatedAnimationBuilderState();
}

class _RepeatedAnimationBuilderState extends State<RepeatedAnimationBuilder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        final value = widget.start +
            (widget.end - widget.start) * _animation.value;
        return widget.builder(context, value, child);
      },
    );
  }
}

class CapturedWrapper extends StatefulWidget {
  final CapturedThemes? themes;
  final CapturedData? data;
  final Widget child;

  const CapturedWrapper({
    super.key,
    this.themes,
    this.data,
    required this.child,
  });

  @override
  State<CapturedWrapper> createState() => _CapturedWrapperState();
}

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

  /// Centers the widget inside an [Align].
  Widget center() {
    return Align(alignment: Alignment.center, child: this);
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

  /// Wraps this widget in an [Expanded] to fill available space.
  Widget expanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  /// Wraps this widget with intrinsic sizing on both axes.
  Widget intrinsic({bool width = true, bool height = true}) {
    Widget current = this;
    if (height) {
      current = IntrinsicHeight(child: current);
    }
    if (width) {
      current = IntrinsicWidth(child: current);
    }
    return current;
  }
}

/// Converts between two value types using the provided converters.
class BiDirectionalConvert<A, B> {
  /// Converts from A to B.
  final B Function(A) aToB;

  /// Converts from B to A.
  final A Function(B) bToA;

  /// Creates a [BiDirectionalConvert].
  BiDirectionalConvert(this.aToB, this.bToA);

  /// Converts A to B.
  B convertA(A value) => aToB(value);

  /// Converts B to A.
  A convertB(B value) => bToA(value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BiDirectionalConvert<A, B> &&
        other.aToB == aToB &&
        other.bToA == bToA;
  }

  @override
  int get hashCode => Object.hash(aToB, bToA);
}

/// A controller that converts between types [F] and [T].
class ConvertedController<F, T> extends ChangeNotifier
    implements ComponentController<T> {
  final ValueNotifier<F> _other;
  final BiDirectionalConvert<F, T> _convert;

  T _value;
  bool _isUpdating = false;

  /// Creates a [ConvertedController].
  ConvertedController(ValueNotifier<F> other, BiDirectionalConvert<F, T> convert)
      : _other = other,
        _convert = convert,
        _value = convert.convertA(other.value) {
    _other.addListener(_onOtherValueChanged);
  }

  void _onOtherValueChanged() {
    if (_isUpdating) {
      return;
    }
    _isUpdating = true;
    try {
      _value = _convert.convertA(_other.value);
      notifyListeners();
    } finally {
      _isUpdating = false;
    }
  }

  void _onValueChanged() {
    if (_isUpdating) {
      return;
    }
    _isUpdating = true;
    try {
      _other.value = _convert.convertB(_value);
    } finally {
      _isUpdating = false;
    }
  }

  @override
  T get value => _value;

  @override
  set value(T newValue) {
    if (newValue == _value) {
      return;
    }
    _value = newValue;
    notifyListeners();
    _onValueChanged();
  }

  @override
  void dispose() {
    _other.removeListener(_onOtherValueChanged);
    super.dispose();
  }
}

class SeparatedFlex extends StatefulWidget {
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final Clip clipBehavior;
  final Widget separator;
  final List<Widget> children;

  const SeparatedFlex({
    super.key,
    required this.direction,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.crossAxisAlignment,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.clipBehavior = Clip.none,
    required this.separator,
    required this.children,
  });

  @override
  State<SeparatedFlex> createState() => _SeparatedFlexState();
}

class _SeparatedFlexState extends State<SeparatedFlex> {
  @override
  Widget build(BuildContext context) {
    final children = widget.children.joinSeparator(widget.separator);
    return Flex(
      direction: widget.direction,
      mainAxisAlignment: widget.mainAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
      crossAxisAlignment: widget.crossAxisAlignment,
      textDirection: widget.textDirection,
      verticalDirection: widget.verticalDirection,
      textBaseline: widget.textBaseline,
      clipBehavior: widget.clipBehavior,
      children: children,
    );
  }
}

extension ColumnExtension on Column {
  Widget gap(double gap) {
    return separator(SizedBox(height: gap));
  }

  Widget separator(Widget separator) {
    return SeparatedFlex(
      key: key,
      direction: Axis.vertical,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      separator: separator,
      children: children,
    );
  }
}

extension RowExtension on Row {
  Widget gap(double gap) {
    return separator(SizedBox(width: gap));
  }

  Widget separator(Widget separator) {
    return SeparatedFlex(
      key: key,
      direction: Axis.horizontal,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      separator: separator,
      children: children,
    );
  }
}

extension FlexExtension on Flex {
  Widget gap(double gap) {
    return separator(
      direction == Axis.horizontal
          ? SizedBox(width: gap)
          : SizedBox(height: gap),
    );
  }

  Widget separator(Widget separator) {
    return SeparatedFlex(
      key: key,
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      separator: separator,
      children: children,
    );
  }
}

/// Represents a time of day with hour, minute, and second.
class TimeOfDay {
  /// Hour component (0-23).
  final int hour;

  /// Minute component (0-59).
  final int minute;

  /// Second component (0-59).
  final int second;

  /// Creates a [TimeOfDay] with specified components.
  ///
  /// Parameters:
  /// - [hour] (`int`, required): Hour (0-23).
  /// - [minute] (`int`, required): Minute (0-59).
  /// - [second] (`int`, default: 0): Second (0-59).
  const TimeOfDay({
    required this.hour,
    required this.minute,
    this.second = 0,
  });

  /// Creates a PM time (adds 12 to the hour).
  ///
  /// Parameters:
  /// - [hour] (`int`, required): Hour in 12-hour format (1-12).
  /// - [minute] (`int`, required): Minute (0-59).
  /// - [second] (`int`, default: 0): Second (0-59).
  const TimeOfDay.pm({
    required int hour,
    required this.minute,
    this.second = 0,
  }) : hour = hour + 12;

  /// Creates an AM time.
  ///
  /// Parameters:
  /// - [hour] (`int`, required): Hour in 12-hour format (0-11).
  /// - [minute] (`int`, required): Minute (0-59).
  /// - [second] (`int`, default: 0): Second (0-59).
  const TimeOfDay.am({
    required this.hour,
    required this.minute,
    this.second = 0,
  });

  /// Creates a [TimeOfDay] from a [DateTime].
  ///
  /// Parameters:
  /// - [dateTime] (`DateTime`, required): DateTime to extract time from.
  TimeOfDay.fromDateTime(DateTime dateTime)
      : hour = dateTime.hour,
        minute = dateTime.minute,
        second = dateTime.second;

  /// Creates a [TimeOfDay] from a [Duration].
  ///
  /// Parameters:
  /// - [duration] (`Duration`, required): Duration to convert.
  TimeOfDay.fromDuration(Duration duration)
      : hour = duration.inHours,
        minute = duration.inMinutes % 60,
        second = duration.inSeconds % 60;

  /// Creates a [TimeOfDay] representing the current time.
  TimeOfDay.now() : this.fromDateTime(DateTime.now());

  /// Creates a copy with specified fields replaced.
  ///
  /// Parameters:
  /// - [hour] (`ValueGetter<int>?`, optional): New hour value.
  /// - [minute] (`ValueGetter<int>?`, optional): New minute value.
  /// - [second] (`ValueGetter<int>?`, optional): New second value.
  ///
  /// Returns: `TimeOfDay` — copy with updated values.
  TimeOfDay copyWith({
    ValueGetter<int>? hour,
    ValueGetter<int>? minute,
    ValueGetter<int>? second,
  }) {
    return TimeOfDay(
      hour: hour == null ? this.hour : hour(),
      minute: minute == null ? this.minute : minute(),
      second: second == null ? this.second : second(),
    );
  }

  /// Creates a copy with optional replacements.
  TimeOfDay replacing({
    int? hour,
    int? minute,
    int? second,
  }) {
    return TimeOfDay(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TimeOfDay &&
        other.hour == hour &&
        other.minute == minute &&
        other.second == second;
  }

  @override
  int get hashCode => Object.hash(hour, minute, second);

  @override
  String toString() {
    return 'TimeOfDay{hour: $hour, minute: $minute, second: $second}';
  }
}

extension TextEditingValueExtension on TextEditingValue {
  TextEditingValue replaceText(String newText) {
    var selection = this.selection;
    selection = selection.copyWith(
      baseOffset: selection.baseOffset.clamp(0, newText.length),
      extentOffset: selection.extentOffset.clamp(0, newText.length),
    );
    return TextEditingValue(
      text: newText,
      selection: selection,
    );
  }
}
