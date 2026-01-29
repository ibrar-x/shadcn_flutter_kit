// AppErrorGate: full-screen overlay for app-level blocking errors.
// Keeps the navigator subtree mounted so state is preserved while showing a global error UI.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';
import 'app_error.dart';
import 'error_scope.dart';
import 'error_state.dart';

class AppErrorGate extends StatelessWidget {
  const AppErrorGate({
    super.key,
    required this.child,
    required this.notifier,
    this.overlayBuilder,
    this.blockInteraction = true,
  });

  /// Subtree that should stay mounted (typically your Navigator/Scaffold tree).
  final Widget child;

  /// App-level error channel (use HubAppScope(...).notifier).
  final ValueListenable<AppError?> notifier;

  /// Optional custom overlay builder.
  final Widget Function(BuildContext context, AppError error)? overlayBuilder;

  /// When true, blocks pointer events behind the overlay.
  final bool blockInteraction;

  factory AppErrorGate.scope({
    Key? key,
    required Widget child,
    required ErrorScope scope,
    Widget Function(BuildContext context, AppError error)? overlayBuilder,
    bool blockInteraction = true,
  }) {
    return AppErrorGate(
      key: key,
      notifier: scope.notifier,
      overlayBuilder: overlayBuilder,
      blockInteraction: blockInteraction,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppError?>(
      valueListenable: notifier,
      builder: (context, error, _) {
        return Stack(
          children: [
            child,
            if (error != null)
              Positioned.fill(
                child: _AppErrorGateOverlay(
                  error: error,
                  overlayBuilder: overlayBuilder,
                  blockInteraction: blockInteraction,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _AppErrorGateOverlay extends StatelessWidget {
  const _AppErrorGateOverlay({
    required this.error,
    required this.overlayBuilder,
    required this.blockInteraction,
  });

  final AppError error;
  final Widget Function(BuildContext context, AppError error)? overlayBuilder;
  final bool blockInteraction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = theme.colorScheme.background;
    final content =
        overlayBuilder?.call(context, error) ?? ErrorState(error: error);
    final overlay = Container(
      color: background,
      alignment: Alignment.center,
      child: content,
    );
    if (!blockInteraction) return overlay;
    return AbsorbPointer(child: overlay);
  }
}
