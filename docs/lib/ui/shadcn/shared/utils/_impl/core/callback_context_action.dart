part of '../../util.dart';


class CallbackContextAction<T extends Intent> extends ContextAction<T> {
  final OnContextInvokeCallback onInvoke;
  CallbackContextAction({required this.onInvoke});

  @override
  Object? invoke(T intent, [BuildContext? context]) {
    return onInvoke(intent, context);
  }
}

typedef OnContextedCallback<T extends Intent> = Object? Function(T intent,
    [BuildContext? context]);
