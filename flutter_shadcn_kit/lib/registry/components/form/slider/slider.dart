import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../shared/primitives/form_control.dart';
import '../../../shared/primitives/form_value_supplier.dart';
import '../../../shared/primitives/slider_value.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/color_extensions.dart';

part '_impl/utils/slider_controller.dart';
part '_impl/styles/slider_style.dart';
part '_impl/extensions/slider_value_extensions.dart';

part '_impl/state/_slider_state.dart';
part '_impl/core/slider_engine_models.dart';
part '_impl/core/controlled_slider.dart';
part '_impl/core/decrease_slider_value.dart';
part '_impl/core/increase_slider_value.dart';
part '_impl/themes/slider_theme.dart';
part '_impl/variants/hybrid_tick_slider_variant.dart';
part '_impl/variants/labeled_slider_variant.dart';
part '_impl/variants/media_control_slider_variant.dart';
part '_impl/variants/range_selector_slider_variant.dart';
part '_impl/variants/ranged_scale_slider_variant.dart';
part '_impl/variants/striped_slider_variant.dart';
part '_impl/variants/wave_range_slider_variant.dart';

/// A Material Design slider widget for selecting values or ranges.
///
/// A highly customizable slider supporting both single-value and range
/// selection modes. Provides keyboard navigation, discrete divisions,
/// hint values, and comprehensive theming options.
///
/// Unlike [ControlledSlider], this widget is uncontrolled and requires
/// explicit value management through [onChanged]. For a controlled
/// alternative with automatic state management, use [ControlledSlider].
///
/// Example:
/// ```dart
/// Slider(
///   value: SliderValue.single(0.5),
///   min: 0.0,
///   max: 1.0,
///   divisions: 10,
///   onChanged: (newValue) {
///     setState(() => value = newValue);
///   },
/// )
/// ```
class Slider extends StatefulWidget {
  /// The current value of the slider.
  ///
  /// Can be either a single value or a range. The slider's visual state
  /// reflects this value.
  final SliderValue value;

  /// Callback invoked when the slider value changes.
  ///
  /// Called repeatedly during slider interaction as the user drags the thumb
  /// or clicks the track. Receives the new [SliderValue].
  final ValueChanged<SliderValue>? onChanged;

  /// Callback invoked when the user starts changing the slider value.
  ///
  /// Called once when interaction begins. Receives the initial [SliderValue].
  final ValueChanged<SliderValue>? onChangeStart;

  /// Callback invoked when the user finishes changing the slider value.
  ///
  /// Called once when interaction ends. Receives the final [SliderValue].
  final ValueChanged<SliderValue>? onChangeEnd;

  /// The minimum value the slider can represent.
  ///
  /// Defaults to `0`. Must be less than [max].
  final double min;

  /// The maximum value the slider can represent.
  ///
  /// Defaults to `1`. Must be greater than [min].
  final double max;

  /// The number of discrete divisions the slider range is divided into.
  ///
  /// If `null`, the slider is continuous. If specified, the slider snaps to
  /// discrete values.
  final int? divisions;

  /// Snap behavior for the slider value.
  ///
  /// If not provided, [divisions] is used for quantization when available.
  final SliderSnap snap;

  /// An optional hint value displayed on the slider track.
  ///
  /// Renders as a visual marker showing a target or reference position.
  final SliderValue? hintValue;

  /// The step size for keyboard increment actions.
  ///
  /// Used when the user triggers increase actions via keyboard. If `null`,
  /// a default step is calculated based on the slider range.
  final double? increaseStep;

  /// The step size for keyboard decrement actions.
  ///
  /// Used when the user triggers decrease actions via keyboard. If `null`,
  /// a default step is calculated based on the slider range.
  final double? decreaseStep;

  /// Whether the slider is interactive.
  ///
  /// When `false` or `null` with no [onChanged] callback, the slider is
  /// displayed in a disabled state and does not respond to user input.
  final bool? enabled;

  /// Optional per-instance layout override values.
  final double? minWidth;
  final double? minHeight;
  final double? maxHeight;
  final double? horizontalPadding;

  /// Optional per-instance track style overrides.
  final double? trackHeight;
  final BorderRadiusGeometry? trackRadius;
  final Color? trackColor;
  final Color? valueColor;
  final Color? disabledTrackColor;
  final Color? disabledValueColor;

  /// Optional per-instance hint style overrides.
  final double? hintHeight;
  final BorderRadiusGeometry? hintRadius;
  final Color? hintColor;

  /// Optional per-instance thumb style overrides.
  final double? thumbSize;
  final double? thumbInset;
  final double? fillEndBias;
  final Color? thumbColor;
  final Color? disabledThumbColor;
  final Color? thumbBorderColor;
  final Color? thumbFocusedBorderColor;
  final Color? disabledThumbBorderColor;
  final double? thumbBorderWidth;
  final double? thumbFocusedBorderWidth;

  /// Optional per-instance animation overrides.
  final Duration? animationDuration;
  final Curve? animationCurve;

  /// Optional advanced render hooks.
  final SliderTrackBuilder? trackBuilder;
  final SliderFillBuilder? fillBuilder;
  final SliderThumbBuilder? thumbBuilder;
  final SliderTicksBuilder? ticksBuilder;
  final SliderOverlayBuilder? overlayBuilder;

  /// Whether range thumbs can swap when crossing.
  final bool allowThumbSwap;

  /// Creates a [Slider].
  ///
  /// Parameters:
  /// - [value] (`SliderValue`, required): Current slider value.
  /// - [onChanged] (`ValueChanged<SliderValue>?`, optional): Value change callback.
  /// - [onChangeStart] (`ValueChanged<SliderValue>?`, optional): Interaction start callback.
  /// - [onChangeEnd] (`ValueChanged<SliderValue>?`, optional): Interaction end callback.
  /// - [min] (`double`, default: `0`): Minimum value.
  /// - [max] (`double`, default: `1`): Maximum value.
  /// - [divisions] (`int?`, optional): Number of discrete divisions.
  /// - [hintValue] (`SliderValue?`, optional): Visual hint marker.
  /// - [increaseStep] (`double?`, optional): Keyboard increment step.
  /// - [decreaseStep] (`double?`, optional): Keyboard decrement step.
  /// - [enabled] (`bool?`, optional): Whether interactive.
  ///
  /// Example:
  /// ```dart
  /// Slider(
  ///   value: SliderValue.ranged(0.2, 0.8),
  ///   min: 0.0,
  ///   max: 1.0,
  ///   onChanged: (value) => print('Range: ${value.start}-${value.end}'),
  /// )
  /// ```
  const Slider({
    super.key,
    required this.value,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.snap = const SliderSnap.none(),
    this.hintValue,
    this.increaseStep,
    this.decreaseStep,
    this.enabled = true,
    this.minWidth,
    this.minHeight,
    this.maxHeight,
    this.horizontalPadding,
    this.trackHeight,
    this.trackRadius,
    this.trackColor,
    this.valueColor,
    this.disabledTrackColor,
    this.disabledValueColor,
    this.hintHeight,
    this.hintRadius,
    this.hintColor,
    this.thumbSize,
    this.thumbInset,
    this.fillEndBias,
    this.thumbColor,
    this.disabledThumbColor,
    this.thumbBorderColor,
    this.thumbFocusedBorderColor,
    this.disabledThumbBorderColor,
    this.thumbBorderWidth,
    this.thumbFocusedBorderWidth,
    this.animationDuration,
    this.animationCurve,
    this.trackBuilder,
    this.fillBuilder,
    this.thumbBuilder,
    this.ticksBuilder,
    this.overlayBuilder,
    this.allowThumbSwap = false,
  }) : assert(min <= max);

  /// Creates the `State` object for this widget.
  @override
  State<Slider> createState() => _SliderState();
}
