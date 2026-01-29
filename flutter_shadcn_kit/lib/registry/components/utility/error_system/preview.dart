import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../layout/scaffold/scaffold.dart';
import '../../control/button/button.dart';
import '../../../shared/theme/theme.dart';
import 'error_system.dart';

class ErrorSystemPreview extends StatelessWidget {
  const ErrorSystemPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final sampleError = AppError(
      code: AppErrorCode.network,
      title: 'Connection failed',
      message: 'Check your internet connection and try again.',
      actions: [
        ErrorAction.retry(() {}),
        ErrorAction.settings(() {}),
      ],
    );

    return Scaffold(
      headers: const [AppBar(title: Text('Error System'))],
      child: ListView(
        padding: EdgeInsets.all(24 * scaling),
        children: [
          ErrorState(error: sampleError),
          Gap(24 * scaling),
          const InlineError(message: 'Unable to save. Please try again.'),
          Gap(24 * scaling),
          Wrap(
            spacing: 12 * scaling,
            runSpacing: 8 * scaling,
            children: [
              PrimaryButton(
                onPressed: () => ErrorDialog.show(context: context, error: sampleError),
                child: const Text('Show Error Dialog'),
              ),
              SecondaryButton(
                onPressed: () => ErrorSnackbar.show(context: context, error: sampleError),
                child: const Text('Show Error Snackbar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
