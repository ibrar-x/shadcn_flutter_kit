import 'package:flutter/widgets.dart';

import '../variants/empty_state_action_style.dart';

class EmptyStateAction {
  const EmptyStateAction({
    required this.label,
    this.onPressed,
    this.icon,
    this.style = EmptyStateActionStyle.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final EmptyStateActionStyle style;
}
