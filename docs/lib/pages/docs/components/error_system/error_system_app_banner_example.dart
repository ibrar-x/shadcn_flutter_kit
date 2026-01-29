import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart';
import '../../../../ui/shadcn/components/utility/error_system/error_system.dart';
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample errorSystemAppBannerExample = ComponentExample(
  title: 'AppErrorBanner (global)',
  builder: _buildErrorSystemAppBannerExample,
  code: '''final scope = HubAppScope('global');

AppErrorBanner();

PrimaryButton(
  onPressed: () {
    scope.notifier.value = AppError(
      code: AppErrorCode.noInternet,
      title: 'You are offline',
      message: 'Check your connection.',
    );
  },
  child: Text('Show banner'),
);''',
);

Widget _buildErrorSystemAppBannerExample(BuildContext context) {
  final scope = HubAppScope('docs.error-banner');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text('App-level banner example').small().muted(),
      const SizedBox(height: 12),
      const AppErrorBanner(
        watchScopes: ['docs.error-banner'],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          PrimaryButton(
            onPressed: () {
              scope.notifier.value = AppError(
                code: AppErrorCode.noInternet,
                title: 'You are offline',
                message: 'Check your connection and try again.',
                actions: [
                  ErrorAction.retry(scope.clear),
                ],
              );
            },
            child: const Text('Show banner'),
          ),
          SecondaryButton(
            onPressed: scope.clear,
            child: const Text('Clear'),
          ),
        ],
      ),
    ],
  );
}
