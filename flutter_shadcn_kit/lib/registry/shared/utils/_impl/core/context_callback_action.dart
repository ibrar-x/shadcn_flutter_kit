part of '../../util.dart';


class ContextCallbackAction<T extends Intent> extends ContextAction<T> {
  final OnContextedCallback<T> onInvoke;
  ContextCallbackAction({required this.onInvoke});

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    return onInvoke(intent, context);
  }
}

typedef FormPendingWidgetBuilder = Widget Function(
  BuildContext context,
  Map<FormKey, Future<ValidationResult?>> pending,
  Widget? child,
);
