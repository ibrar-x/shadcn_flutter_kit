import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import '../../../shared/theme/theme.dart';

part '_impl/toast_theme.dart';
part '_impl/toast_entry.dart';
part '_impl/toast_controller.dart';

final ToastController _defaultToastController = ToastController();

/// Convenience helper to show a toast using a shared controller.
void showToast({
  required BuildContext context,
  required WidgetBuilder builder,
  Duration? duration,
  double? spacing,
}) {
  _defaultToastController.show(
    context: context,
    builder: builder,
    duration: duration,
    spacing: spacing,
  );
}
