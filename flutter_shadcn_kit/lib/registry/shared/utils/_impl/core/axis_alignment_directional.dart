part of '../../axis.dart';

class AxisAlignmentDirectional extends AxisAlignmentGeometry {
  static const AxisAlignmentDirectional start = AxisAlignmentDirectional(-1.0);
  static const AxisAlignmentDirectional end = AxisAlignmentDirectional(1.0);
  static const AxisAlignmentDirectional center =
      AxisAlignmentDirectional(0.0);

  final double value;

  const AxisAlignmentDirectional(this.value);

  @override
  AxisAlignment resolve(TextDirection textDirection) {
    return AxisAlignment._(textDirection, value);
  }
}
