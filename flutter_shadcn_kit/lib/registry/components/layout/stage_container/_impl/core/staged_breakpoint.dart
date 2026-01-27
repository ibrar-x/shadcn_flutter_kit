part of '../../stage_container.dart';

class StagedBreakpoint implements StageBreakpoint {
  /// Default breakpoints matching common responsive design values.
  static const List<double> _defaultBreakpoints = [576, 768, 992, 1200, 1400];

  /// List of breakpoint width values in ascending order.
  final List<double> breakpoints;

  /// Creates a [StagedBreakpoint] with custom breakpoints.
  ///
  /// Requires at least 2 breakpoints.
  const StagedBreakpoint(this.breakpoints) : assert(breakpoints.length > 1);

  /// Creates a [StagedBreakpoint] with default responsive breakpoints.
  const StagedBreakpoint.defaultBreakpoints()
      : breakpoints = _defaultBreakpoints;

  @override
  double getMinWidth(double width) {
    for (int i = 1; i < breakpoints.length; i++) {
      if (width < breakpoints[i]) {
        return breakpoints[i - 1];
      }
    }
    return width;
  }

  @override
  double getMaxWidth(double width) {
    for (var breakpoint in breakpoints) {
      if (width < breakpoint) {
        return breakpoint;
      }
    }
    return maxSize;
  }

  @override
  double get minSize => breakpoints.first;

  @override
  double get maxSize => breakpoints.last;
}
