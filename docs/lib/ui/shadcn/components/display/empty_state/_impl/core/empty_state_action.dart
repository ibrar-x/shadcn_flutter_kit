import 'package:flutter/widgets.dart';

import '../variants/empty_state_action_style.dart';

class EmptyStateAction {
  const EmptyStateAction({
    required this.label,
    this.onPressed,
    this.icon,
    this.trailingIcon,
    this.style = EmptyStateActionStyle.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Widget? trailingIcon;
  final EmptyStateActionStyle style;
}
