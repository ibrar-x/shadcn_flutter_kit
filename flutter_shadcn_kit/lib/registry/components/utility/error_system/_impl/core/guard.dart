// guard/guardSync: small helpers to run an operation and publish any error to a chosen AppErrorHub channel.
// This keeps UI reactive (ErrorSlot/AppErrorBanner) without forcing every call site to handle try/catch boilerplate.

import 'package:flutter/foundation.dart';

import 'app_error.dart';
import 'app_error_hub.dart';
import 'error_code.dart';
import 'error_mapper.dart';

typedef AsyncFn<T> = Future<T> Function();

Future<T?> guard<T>(
  AsyncFn<T> fn, {
  String? appScope,
  String? screenScope,
  ValueNotifier<AppError?>? channel,
  bool clearBeforeRun = true,
  ErrorMapper? fallbackMapper,
}) async {
  final notifier =
      channel ??
      (appScope != null
          ? AppErrorHub.I.app(appScope)
          : screenScope != null
          ? AppErrorHub.I.screen(screenScope)
          : AppErrorHub.I.app('global'));

  if (clearBeforeRun) {
    notifier.value = null;
  }

  try {
    return await fn();
  } on AppError catch (e) {
    notifier.value = e;
    return null;
  } catch (e, st) {
    notifier.value =
        fallbackMapper?.map(e, st) ??
        AppError(
          code: AppErrorCode.unknown,
          title: 'Unexpected Error',
          message: 'Something went wrong. Please try again.',
          technicalDetails: '$e\n$st',
        );
    return null;
  }
}

T? guardSync<T>(
  T Function() fn, {
  String? appScope,
  String? screenScope,
  ValueNotifier<AppError?>? channel,
  bool clearBeforeRun = true,
  ErrorMapper? fallbackMapper,
}) {
  final notifier =
      channel ??
      (appScope != null
          ? AppErrorHub.I.app(appScope)
          : screenScope != null
          ? AppErrorHub.I.screen(screenScope)
          : AppErrorHub.I.app('global'));

  if (clearBeforeRun) {
    notifier.value = null;
  }

  try {
    return fn();
  } on AppError catch (e) {
    notifier.value = e;
    return null;
  } catch (e, st) {
    notifier.value =
        fallbackMapper?.map(e, st) ??
        AppError(
          code: AppErrorCode.unknown,
          title: 'Unexpected Error',
          message: 'Something went wrong. Please try again.',
          technicalDetails: '$e\n$st',
        );
    return null;
  }
}
