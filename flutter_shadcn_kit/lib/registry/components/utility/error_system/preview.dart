// Error System preview screen.
// Demonstrates ErrorState, InlineError, ErrorDialog, and ErrorSnackbar in the gallery.

import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../layout/scaffold/scaffold.dart';
import '../../control/button/button.dart';
import '../../../shared/theme/theme.dart';
import 'error_system.dart';
import '../../../shared/icons/radix_icons.dart';

class ErrorSystemPreview extends StatelessWidget {
  const ErrorSystemPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final globalScope = HubAppScope('global');
    final sampleError = AppError(
      code: AppErrorCode.notFound,
      title: "Something's not right here",
      message:
          "We can’t find the page you’re looking for. Don’t worry, we can get you back home.",
      actions: [ErrorAction(label: 'Home', onPressed: () {}, primary: true)],
    );
    final gateError = AppError(
      code: AppErrorCode.noInternet,
      title: 'You are offline',
      message:
          'Reconnect to continue. We will restore your screen automatically.',
      actions: [ErrorAction.retry(() {})],
    );

    return Scaffold(
      headers: const [AppBar(title: Text('Error System'))],
      child: ScreenErrorScope(
        child: Builder(
          builder: (context) {
            final scope = ScreenErrorScope.of(context);
            return AppErrorGate.scope(
              scope: globalScope,
              child: ListView(
                padding: EdgeInsets.all(24 * scaling),
                children: [
                  AppErrorBanner(),
                  Gap(16 * scaling),
                  Wrap(
                    spacing: 12 * scaling,
                    runSpacing: 8 * scaling,
                    children: [
                      SecondaryButton(
                        onPressed: () {
                          AppErrorHub.I
                              .app(AppErrorHub.networkUnavailable)
                              .value = sampleError.copyWithActions([
                            ErrorAction.retry(() {}),
                          ]);
                        },
                        child: const Text('Trigger App Error'),
                      ),
                      GhostButton(
                        onPressed: () => AppErrorHub.I.clearAllApp(),
                        child: const Text('Clear App Errors'),
                      ),
                      SecondaryButton(
                        onPressed: () => globalScope.notifier.value = gateError,
                        child: const Text('Show App Gate'),
                      ),
                      GhostButton(
                        onPressed: globalScope.clear,
                        child: const Text('Clear App Gate'),
                      ),
                    ],
                  ),
                  Gap(24 * scaling),
                  ErrorState(
                    error: sampleError,
                    illustration: Column(
                      children: [
                        Text(
                          'Error',
                          style: theme.typography.x4Large.copyWith(
                            color: theme.colorScheme.secondaryForeground,
                          ),
                        ),
                        Gap(8 * scaling),
                        Container(
                          width: 220 * scaling,
                          height: 160 * scaling,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.border,
                            borderRadius: BorderRadius.circular(24 * scaling),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            RadixIcons.target,
                            size: 48 * scaling,
                            color: theme.colorScheme.secondaryForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(24 * scaling),
                  ErrorSlot.scope(
                    scope: scope.scope,
                    empty: const InlineError(message: 'No screen-level error.'),
                    builder: (context, error) {
                      final scaling = Theme.of(context).scaling;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InlineError(message: error.message),
                          Gap(8 * scaling),
                          Wrap(
                            spacing: 12 * scaling,
                            runSpacing: 8 * scaling,
                            children: [
                              GhostButton(
                                onPressed: scope.clear,
                                child: const Text('Dismiss'),
                              ),
                              SecondaryButton(
                                onPressed: () => ErrorDialog.show(
                                  context: context,
                                  error: error,
                                ),
                                child: const Text('Dialog'),
                              ),
                              SecondaryButton(
                                onPressed: () => ErrorSnackbar.show(
                                  context: context,
                                  error: error,
                                ),
                                child: const Text('Snackbar'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Gap(24 * scaling),
                  Wrap(
                    spacing: 12 * scaling,
                    runSpacing: 8 * scaling,
                    children: [
                      SecondaryButton(
                        onPressed: () async {
                          await scope.run<void>(() async {
                            throw sampleError;
                          });
                        },
                        child: const Text('run() -> Screen Error'),
                      ),
                      PrimaryButton(
                        onPressed: () => ErrorDialog.show(
                          context: context,
                          error: sampleError,
                        ),
                        child: const Text('Show Error Dialog'),
                      ),
                      SecondaryButton(
                        onPressed: () => ErrorSnackbar.show(
                          context: context,
                          error: sampleError,
                        ),
                        child: const Text('Show Error Snackbar'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
