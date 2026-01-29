// ErrorSlot: reactive error rendering for a specific AppErrorHub channel.
// Use ErrorSlot.screen(scope: ...) for per-screen errors (typically inline), or ErrorSlot.app(scope: ...) for app-level channels.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'app_error.dart';
import 'app_error_hub.dart';
import 'error_scope.dart';
import 'error_state.dart';

class ErrorSlot extends StatelessWidget {
  const ErrorSlot._({
    super.key,
    required this.notifier,
    this.builder,
    this.empty = const SizedBox.shrink(),
  });

  /// Channel to listen to.
  final ValueListenable<AppError?> notifier;

  /// Optional renderer; defaults to [ErrorState].
  final Widget Function(BuildContext context, AppError error)? builder;

  /// Widget to render when there is no error.
  final Widget empty;

  factory ErrorSlot.screen({
    Key? key,
    required String scope,
    Widget Function(BuildContext context, AppError error)? builder,
    Widget empty = const SizedBox.shrink(),
  }) {
    return ErrorSlot._(
      key: key,
      notifier: AppErrorHub.I.screen(scope),
      builder: builder,
      empty: empty,
    );
  }

  factory ErrorSlot.scope({
    Key? key,
    required ErrorScope scope,
    Widget Function(BuildContext context, AppError error)? builder,
    Widget empty = const SizedBox.shrink(),
  }) {
    return ErrorSlot._(
      key: key,
      notifier: scope.notifier,
      builder: builder,
      empty: empty,
    );
  }

  factory ErrorSlot.app({
    Key? key,
    required String scope,
    Widget Function(BuildContext context, AppError error)? builder,
    Widget empty = const SizedBox.shrink(),
  }) {
    return ErrorSlot._(
      key: key,
      notifier: AppErrorHub.I.app(scope),
      builder: builder,
      empty: empty,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppError?>(
      valueListenable: notifier,
      builder: (context, error, _) {
        if (error == null) return empty;
        return builder?.call(context, error) ?? ErrorState(error: error);
      },
    );
  }
}
