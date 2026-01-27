import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../../shared/primitives/animated_value_builder.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/border_utils.dart';
import '../../../shared/utils/constants.dart';
import '../../../shared/utils/geometry_extensions.dart';
import '../../../shared/utils/style_value.dart';

part '_impl/themes/outlined_container_theme.dart';
part '_impl/core/dashed_painters.dart';
part '_impl/core/dashed_container_properties.dart';
part '_impl/core/dashed_line_properties.dart';
part '_impl/core/dashed_container.dart';
part '_impl/core/dashed_line.dart';
part '_impl/state/_outlined_container_state.dart';
part '_impl/core/outlined_container_2.dart';
part '_impl/core/dashed_painter.dart';

class SurfaceBlur extends StatelessWidget {
  const SurfaceBlur({
    super.key,
    required this.child,
    required this.surfaceBlur,
    this.borderRadius,
  });

  final Widget child;
  final double surfaceBlur;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (surfaceBlur <= 0) {
      return child;
    }
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: surfaceBlur,
                sigmaY: surfaceBlur,
              ),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

