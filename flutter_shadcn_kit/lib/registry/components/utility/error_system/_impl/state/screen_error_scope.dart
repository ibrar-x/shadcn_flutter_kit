// ScreenErrorScope: widget that owns a screen-level error channel and disposes it automatically.
// Provides a typed HubScreenScope plus run/runSync helpers so screens can publish AppError without guard().

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../core/app_error.dart';
import '../core/hub_scopes.dart';

class ScreenErrorScope extends StatefulWidget {
  const ScreenErrorScope({
    super.key,
    required this.child,
    this.scopeKey,
    this.clearOnInit = false,
  });

  final Widget child;
  final String? scopeKey;
  final bool clearOnInit;

  static ScreenErrorScopeState of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<_ScreenErrorScopeHost>();
    assert(scope != null, 'ScreenErrorScope.of() called with no ancestor.');
    return scope!.state;
  }

  @override
  State<ScreenErrorScope> createState() => ScreenErrorScopeState();
}

class ScreenErrorScopeState extends State<ScreenErrorScope> {
  static int _counter = 0;

  late final String _key =
      widget.scopeKey ??
      'screen.${DateTime.now().microsecondsSinceEpoch}-${_counter++}';
  late final HubScreenScope scope = HubScreenScope(_key);

  ValueNotifier<AppError?> get notifier => scope.notifier;

  void set(AppError? error) => scope.notifier.value = error;

  void clear() => scope.clear();

  Future<T?> run<T>(
    Future<T> Function() fn, {
    bool clearBeforeRun = true,
  }) async {
    if (clearBeforeRun) scope.clear();
    try {
      return await fn();
    } on AppError catch (e) {
      set(e);
      return null;
    }
  }

  T? runSync<T>(T Function() fn, {bool clearBeforeRun = true}) {
    if (clearBeforeRun) scope.clear();
    try {
      return fn();
    } on AppError catch (e) {
      set(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.clearOnInit) {
      scope.clear();
    }
  }

  @override
  void dispose() {
    scope.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ScreenErrorScopeHost(state: this, child: widget.child);
  }
}

class _ScreenErrorScopeHost extends InheritedWidget {
  const _ScreenErrorScopeHost({required this.state, required super.child});

  final ScreenErrorScopeState state;

  @override
  bool updateShouldNotify(_ScreenErrorScopeHost oldWidget) => false;
}
