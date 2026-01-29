// ScreenErrorMixin: State mixin that gives a screen its own AppErrorHub channel and disposes it automatically.
// Use guardScreen() for repository calls and pair with ErrorSlot.screen(scope: screenScope) to render errors reactively.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../core/app_error.dart';
import '../core/app_error_hub.dart';
import '../core/guard.dart';

@Deprecated(
  'Prefer ScreenErrorScope + ErrorSlot.scope(...) + ScreenErrorScopeState.run().',
)
mixin ScreenErrorMixin<T extends StatefulWidget> on State<T> {
  /// Unique key for the screen/feature scope (e.g. "LoginScreen", "UserProfile").
  String get screenScope;

  /// Channel for this screen (auto-disposed in [dispose]).
  ValueNotifier<AppError?> get errorNotifier =>
      AppErrorHub.I.screen(screenScope);

  /// Runs [fn] and publishes errors to this screen's channel.
  Future<R?> guardScreen<R>(Future<R> Function() fn) {
    return guard(fn, screenScope: screenScope);
  }

  /// Clears the current screen-level error (if any).
  void clearError() => AppErrorHub.I.clearScreen(screenScope);

  @override
  void dispose() {
    AppErrorHub.I.disposeScreen(screenScope);
    super.dispose();
  }
}
