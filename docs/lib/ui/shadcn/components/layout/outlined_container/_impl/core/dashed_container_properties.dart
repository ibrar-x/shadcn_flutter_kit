part of '../../outlined_container.dart';

/// DashedContainerProperties defines a reusable type for this registry module.
class DashedContainerProperties {
/// Stores `width` state/configuration for this implementation.
  final double width;
/// Stores `gap` state/configuration for this implementation.
  final double gap;
/// Stores `thickness` state/configuration for this implementation.
  final double thickness;
/// Stores `color` state/configuration for this implementation.
  final Color color;
/// Stores `borderRadius` state/configuration for this implementation.
  final BorderRadiusGeometry borderRadius;

/// Creates a `DashedContainerProperties` instance.
  const DashedContainerProperties({
    required this.width,
    required this.gap,
    required this.thickness,
    required this.color,
    required this.borderRadius,
  });

  static DashedContainerProperties lerp(
    BuildContext context,
    DashedContainerProperties a,
    DashedContainerProperties b,
    double t,
  ) {
    return DashedContainerProperties(
      width: lerpDouble(a.width, b.width, t)!,
      gap: lerpDouble(a.gap, b.gap, t)!,
      thickness: lerpDouble(a.thickness, b.thickness, t)!,
      color: Color.lerp(a.color, b.color, t)!,
      borderRadius: BorderRadius.lerp(
        a.borderRadius.optionallyResolve(context),
        b.borderRadius.optionallyResolve(context),
        t,
      )!,
    );
  }
}
