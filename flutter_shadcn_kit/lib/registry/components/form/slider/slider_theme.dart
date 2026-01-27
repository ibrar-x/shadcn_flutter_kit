part of 'slider.dart';

/// Theme for [Slider].
class SliderTheme extends ComponentThemeData {
  /// Height of the track.
  final double? trackHeight;

  /// Color of the inactive track.
  final Color? trackColor;

  /// Color of the active portion of the track.
  final Color? valueColor;

  /// Color of the inactive track when disabled.
  final Color? disabledTrackColor;

  /// Color of the active track when disabled.
  final Color? disabledValueColor;

  /// Background color of the thumb.
  final Color? thumbColor;

  /// Border color of the thumb.
  final Color? thumbBorderColor;

  /// Border color of the thumb when focused.
  final Color? thumbFocusedBorderColor;

  /// Size of the thumb.
  final double? thumbSize;

  /// Creates a [SliderTheme].
  const SliderTheme({
    this.trackHeight,
    this.trackColor,
    this.valueColor,
    this.disabledTrackColor,
    this.disabledValueColor,
    this.thumbColor,
    this.thumbBorderColor,
    this.thumbFocusedBorderColor,
    this.thumbSize,
  });

  /// Returns a copy of this theme with the given fields replaced.
  SliderTheme copyWith({
    ValueGetter<double?>? trackHeight,
    ValueGetter<Color?>? trackColor,
    ValueGetter<Color?>? valueColor,
    ValueGetter<Color?>? disabledTrackColor,
    ValueGetter<Color?>? disabledValueColor,
    ValueGetter<Color?>? thumbColor,
    ValueGetter<Color?>? thumbBorderColor,
    ValueGetter<Color?>? thumbFocusedBorderColor,
    ValueGetter<double?>? thumbSize,
  }) {
    return SliderTheme(
      trackHeight: trackHeight == null ? this.trackHeight : trackHeight(),
      trackColor: trackColor == null ? this.trackColor : trackColor(),
      valueColor: valueColor == null ? this.valueColor : valueColor(),
      disabledTrackColor: disabledTrackColor == null
          ? this.disabledTrackColor
          : disabledTrackColor(),
      disabledValueColor: disabledValueColor == null
          ? this.disabledValueColor
          : disabledValueColor(),
      thumbColor: thumbColor == null ? this.thumbColor : thumbColor(),
      thumbBorderColor:
          thumbBorderColor == null ? this.thumbBorderColor : thumbBorderColor(),
      thumbFocusedBorderColor: thumbFocusedBorderColor == null
          ? this.thumbFocusedBorderColor
          : thumbFocusedBorderColor(),
      thumbSize: thumbSize == null ? this.thumbSize : thumbSize(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SliderTheme &&
        other.trackHeight == trackHeight &&
        other.trackColor == trackColor &&
        other.valueColor == valueColor &&
        other.disabledTrackColor == disabledTrackColor &&
        other.disabledValueColor == disabledValueColor &&
        other.thumbColor == thumbColor &&
        other.thumbBorderColor == thumbBorderColor &&
        other.thumbFocusedBorderColor == thumbFocusedBorderColor &&
        other.thumbSize == thumbSize;
  }

  @override
  int get hashCode => Object.hash(
      trackHeight,
      trackColor,
      valueColor,
      disabledTrackColor,
      disabledValueColor,
      thumbColor,
      thumbBorderColor,
      thumbFocusedBorderColor,
      thumbSize);
}
