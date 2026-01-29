// BuildContext helpers for showing error UI.
// Adds context.showErrorSnackbar(appError) and context.showErrorDialog(appError).

import 'package:flutter/widgets.dart';

import '../core/app_error.dart';
import '../core/error_dialog.dart';
import '../core/error_snackbar.dart';

extension ContextErrorExtensions on BuildContext {
  void showErrorSnackbar(AppError error, {Duration? duration}) {
    ErrorSnackbar.show(context: this, error: error, duration: duration);
  }

  Future<T?> showErrorDialog<T>(
    AppError error, {
    bool barrierDismissible = true,
  }) {
    return ErrorDialog.show<T>(
      context: this,
      error: error,
      barrierDismissible: barrierDismissible,
    );
  }
}
