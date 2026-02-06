import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../avatar/avatar.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/color_extensions.dart';
import '../../../shared/utils/style_value.dart';

part '_impl/themes/skeleton_theme.dart';

/// Applies Skeletonizer configuration using shadcn theming.
class ShadcnSkeletonizerConfigLayer extends StatelessWidget {
  const ShadcnSkeletonizerConfigLayer({
    super.key,
    required this.theme,
    required this.child,
    this.duration,
    this.fromColor,
    this.toColor,
    this.enableSwitchAnimation,
  });

  final material.ThemeData theme;
  final Widget child;
  final Duration? duration;
  final Color? fromColor;
  final Color? toColor;
  final bool? enableSwitchAnimation;

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<SkeletonTheme>(context);
    final durationValue = styleValue(
      widgetValue: duration,
      themeValue: compTheme?.duration,
      defaultValue: const Duration(seconds: 1),
    );
    final fromValue = styleValue(
      widgetValue: fromColor,
      themeValue: compTheme?.fromColor,
      defaultValue: theme.colorScheme.primary.scaleAlpha(0.05),
    );
    final toValue = styleValue(
      widgetValue: toColor,
      themeValue: compTheme?.toColor,
      defaultValue: theme.colorScheme.primary.scaleAlpha(0.1),
    );
    final enableSwitchAnimationValue = styleValue(
      widgetValue: enableSwitchAnimation,
      themeValue: compTheme?.enableSwitchAnimation,
      defaultValue: true,
    );

    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        effect: PulseEffect(
          duration: durationValue,
          from: fromValue,
          to: toValue,
        ),
        enableSwitchAnimation: enableSwitchAnimationValue,
      ),
      child: child,
    );
  }
}

/// Convenient skeleton extension helpers.
extension SkeletonExtension on Widget {
  Widget asSkeletonSliver({bool enabled = true}) {
    return Skeletonizer(enabled: enabled, ignoreContainers: false, child: this);
  }

  Widget asSkeleton({
    bool enabled = true,
    bool leaf = false,
    Widget? replacement,
    bool unite = false,
    AsyncSnapshot? snapshot,
  }) {
    if (snapshot != null) {
      enabled = !snapshot.hasData;
    }
    if (this is Avatar || this is Image) {
      return Skeleton.leaf(enabled: enabled, child: this);
    }
    if (unite) {
      return Skeleton.unite(unite: enabled, child: this);
    }
    if (replacement != null) {
      return Skeleton.replace(replace: enabled, child: replacement);
    }
    if (leaf) {
      return Skeleton.leaf(enabled: enabled, child: this);
    }
    return Skeletonizer(enabled: enabled, child: this);
  }

  Widget ignoreSkeleton() {
    return Skeleton.ignore(child: this);
  }

  Widget excludeSkeleton({bool exclude = true}) {
    return Skeleton.keep(keep: exclude, child: this);
  }
}
