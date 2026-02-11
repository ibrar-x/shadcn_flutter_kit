import 'package:flutter/widgets.dart';

import '../../../components/control/button/button.dart' as button;

/// Type alias for `Toggle` used by public or internal APIs.
typedef Toggle = button.Toggle;

/// Type alias for `ToggleController` used by public or internal APIs.
typedef ToggleController = button.ToggleController;

/// Type alias for `ButtonStyle` used by public or internal APIs.
typedef ButtonStyle = button.ButtonStyle;

/// A ready-to-use toggle row with optional leading/trailing content.
class ToggleTile extends StatelessWidget {
  /// Creates a `ToggleTile` instance.
  const ToggleTile({
    super.key,
    required this.value,
    required this.title,
    this.onChanged,
    this.subtitle,
    this.leading,
    this.trailing,
    this.enabled,
    this.style = const ButtonStyle.ghost(),
    this.spacing = 8,
    this.mainAxisSize = MainAxisSize.min,
  });

  /// Stores `value` state/configuration for this implementation.
  final bool value;

  /// Stores `title` state/configuration for this implementation.
  final Widget title;

  /// Stores `onChanged` state/configuration for this implementation.
  final ValueChanged<bool>? onChanged;

  /// Stores `subtitle` state/configuration for this implementation.
  final Widget? subtitle;

  /// Stores `leading` state/configuration for this implementation.
  final Widget? leading;

  /// Stores `trailing` state/configuration for this implementation.
  final Widget? trailing;

  /// Stores `enabled` state/configuration for this implementation.
  final bool? enabled;

  /// Stores `style` state/configuration for this implementation.
  final ButtonStyle style;

  /// Stores `spacing` state/configuration for this implementation.
  final double spacing;

  /// Stores `mainAxisSize` state/configuration for this implementation.
  final MainAxisSize mainAxisSize;

  /// Executes `_buildLabel` behavior for this component/composite.
  Widget _buildLabel() {
    if (subtitle == null) {
      return title;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [title, const SizedBox(height: 2), subtitle!],
    );
  }

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Toggle(
      value: value,
      onChanged: onChanged,
      enabled: enabled,
      style: style,
      child: Row(
        mainAxisSize: mainAxisSize,
        children: [
          if (leading != null) ...[leading!, SizedBox(width: spacing)],
          Flexible(child: _buildLabel()),
          if (trailing != null) ...[SizedBox(width: spacing), trailing!],
        ],
      ),
    );
  }
}
