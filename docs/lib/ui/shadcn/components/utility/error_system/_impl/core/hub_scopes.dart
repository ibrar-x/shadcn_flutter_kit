// Hub scopes: typed adapters that connect ErrorScope to AppErrorHub channels.
// Avoids passing raw string keys around and makes testing easy by swapping the scope implementation.

import 'package:flutter/foundation.dart';

import 'app_error.dart';
import 'app_error_hub.dart';
import 'error_scope.dart';

class HubAppScope implements ErrorScope {
  HubAppScope(this.key);

  final String key;

  @override
  ValueNotifier<AppError?> get notifier => AppErrorHub.I.app(key);

  @override
  void clear() => AppErrorHub.I.clearApp(key);
}

class HubScreenScope implements DisposableErrorScope {
  HubScreenScope(this.key);

  final String key;

  @override
  ValueNotifier<AppError?> get notifier => AppErrorHub.I.screen(key);

  @override
  void clear() => AppErrorHub.I.clearScreen(key);

  @override
  void dispose() => AppErrorHub.I.disposeScreen(key);
}
