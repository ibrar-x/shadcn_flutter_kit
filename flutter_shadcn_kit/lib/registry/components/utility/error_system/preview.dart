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
    const screenScope = 'preview.error_system';
    final sampleError = AppError(
      code: AppErrorCode.notFound,
      title: "Something's not right here",
      message:
          "We can’t find the page you’re looking for. Don’t worry, we can get you back home.",
      actions: [ErrorAction(label: 'Home', onPressed: () {}, primary: true)],
    );

    return Scaffold(
      headers: const [AppBar(title: Text('Error System'))],
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
                  AppErrorHub.I.app(AppErrorHub.networkUnavailable).value =
                      sampleError.copyWithActions([ErrorAction.retry(() {})]);
                },
                child: const Text('Trigger App Error'),
              ),
              GhostButton(
                onPressed: () => AppErrorHub.I.clearAllApp(),
                child: const Text('Clear App Errors'),
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
                    color: theme.colorScheme.muted,
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
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          Gap(24 * scaling),
          ErrorSlot.screen(
            scope: screenScope,
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
                        onPressed: () => AppErrorHub.I.clearScreen(screenScope),
                        child: const Text('Dismiss'),
                      ),
                      SecondaryButton(
                        onPressed: () =>
                            ErrorDialog.show(context: context, error: error),
                        child: const Text('Dialog'),
                      ),
                      SecondaryButton(
                        onPressed: () =>
                            ErrorSnackbar.show(context: context, error: error),
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
                  await guard<void>(() async {
                    throw sampleError;
                  }, screenScope: screenScope);
                },
                child: const Text('guard() -> Screen Error'),
              ),
              PrimaryButton(
                onPressed: () =>
                    ErrorDialog.show(context: context, error: sampleError),
                child: const Text('Show Error Dialog'),
              ),
              SecondaryButton(
                onPressed: () =>
                    ErrorSnackbar.show(context: context, error: sampleError),
                child: const Text('Show Error Snackbar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
