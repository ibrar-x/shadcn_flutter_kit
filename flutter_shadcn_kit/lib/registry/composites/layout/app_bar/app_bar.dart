import 'package:flutter/widgets.dart';

import '../../../components/control/button/button.dart' as button;
import '../../../components/layout/outlined_container/outlined_container.dart'
    /// Stores `layout` state/configuration for this implementation.
    as layout;
import '../../../components/layout/scaffold/scaffold.dart' as scaffold;

/// Type alias for `AppBar` used by public or internal APIs.
typedef AppBar = scaffold.AppBar;

/// Type alias for `OutlinedContainer` used by public or internal APIs.
typedef OutlinedContainer = layout.OutlinedContainer;

/// Type alias for `OutlineButton` used by public or internal APIs.
typedef OutlineButton = button.OutlineButton;

/// Type alias for `ButtonDensity` used by public or internal APIs.
typedef ButtonDensity = button.ButtonDensity;

/// Ready-to-use app bar composite with title/subtitle and optional framing.
class ShadAppBar extends StatelessWidget {
  /// Creates a `ShadAppBar` instance.
  const ShadAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading = const <Widget>[],
    this.trailing = const <Widget>[],
    this.outlined = false,
    this.padding,
    this.height,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.backgroundColor,
  });

  /// Stores `title` state/configuration for this implementation.
  final Widget title;

  /// Stores `subtitle` state/configuration for this implementation.
  final Widget? subtitle;

  /// Stores `leading` state/configuration for this implementation.
  final List<Widget> leading;

  /// Stores `trailing` state/configuration for this implementation.
  final List<Widget> trailing;

  /// Stores `outlined` state/configuration for this implementation.
  final bool outlined;

  /// Stores `padding` state/configuration for this implementation.
  final EdgeInsetsGeometry? padding;

  /// Stores `height` state/configuration for this implementation.
  final double? height;

  /// Stores `surfaceBlur` state/configuration for this implementation.
  final double? surfaceBlur;

  /// Stores `surfaceOpacity` state/configuration for this implementation.
  final double? surfaceOpacity;

  /// Stores `backgroundColor` state/configuration for this implementation.
  final Color? backgroundColor;

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final bar = AppBar(
      leading: leading,
      trailing: trailing,
      title: title,
      subtitle: subtitle,
      padding: padding,
      height: height,
      surfaceBlur: surfaceBlur,
      surfaceOpacity: surfaceOpacity,
      backgroundColor: backgroundColor,
    );
    if (!outlined) {
      return bar;
    }
    return OutlinedContainer(child: bar);
  }
}
