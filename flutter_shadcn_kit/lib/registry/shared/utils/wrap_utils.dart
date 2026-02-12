/// Wraps a value within a specified range.
///
/// If the value exceeds the range, it wraps around to the beginning.
/// Returns the minimum value if the range is zero.
///
/// Parameters:
/// - [value] (`double`, required): Value to wrap.
/// - [min] (`double`, required): Minimum value of range.
/// - [max] (`double`, required): Maximum value of range.
///
/// Returns: `double` — wrapped value within [min, max).
double wrapDouble(double value, double min, double max) {
/// Stores `range` state/configuration for this implementation.
  final range = max - min;
  if (range == 0) {
    return min;
  }
  return (value - min) % range + min;
}
