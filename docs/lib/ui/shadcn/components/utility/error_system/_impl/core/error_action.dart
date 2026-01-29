// ErrorAction: describes a user action rendered by error UI (Retry/Login/Settings/etc.).
// Factories set sensible defaults (label/icon/type/primary) for common actions.

import 'package:flutter/widgets.dart';

import '../../../../../shared/icons/radix_icons.dart';

class ErrorAction {
  const ErrorAction({
    required this.label,
    required this.onPressed,
    this.primary = false,
    this.icon,
    this.type = ErrorActionType.custom,
  });

  final String label;
  final VoidCallback onPressed;
  final bool primary;
  final IconData? icon;
  final ErrorActionType type;

  factory ErrorAction.retry(VoidCallback onRetry) {
    return ErrorAction(
      label: 'Retry',
      onPressed: onRetry,
      primary: true,
      icon: RadixIcons.reload,
      type: ErrorActionType.retry,
    );
  }

  factory ErrorAction.report(VoidCallback onReport) {
    return ErrorAction(
      label: 'Report',
      onPressed: onReport,
      icon: RadixIcons.questionMarkCircled,
      type: ErrorActionType.report,
    );
  }

  factory ErrorAction.back(VoidCallback onBack) {
    return ErrorAction(
      label: 'Go Back',
      onPressed: onBack,
      icon: RadixIcons.arrowLeft,
      type: ErrorActionType.navigate,
    );
  }

  factory ErrorAction.login(VoidCallback onLogin) {
    return ErrorAction(
      label: 'Log In',
      onPressed: onLogin,
      primary: true,
      icon: RadixIcons.enter,
      type: ErrorActionType.navigate,
    );
  }

  factory ErrorAction.settings(VoidCallback onSettings) {
    return ErrorAction(
      label: 'Settings',
      onPressed: onSettings,
      icon: RadixIcons.gear,
      type: ErrorActionType.navigate,
    );
  }

  factory ErrorAction.contactSupport(VoidCallback onContact) {
    return ErrorAction(
      label: 'Contact Support',
      onPressed: onContact,
      icon: RadixIcons.chatBubble,
      type: ErrorActionType.navigate,
    );
  }

  factory ErrorAction.dismiss(VoidCallback onDismiss) {
    return ErrorAction(
      label: 'Dismiss',
      onPressed: onDismiss,
      type: ErrorActionType.custom,
    );
  }
}

enum ErrorActionType { retry, report, navigate, custom }
