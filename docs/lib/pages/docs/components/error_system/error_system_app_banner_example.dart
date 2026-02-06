import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart';
import '../../../../ui/shadcn/components/utility/error_system/error_system.dart';
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample errorSystemAppBannerExample = ComponentExample(
  title: 'App-level banner + gate',
  builder: _buildErrorSystemAppBannerExample,
  code: '''final bannerScope = HubAppScope('app.banner');
final gateScope = HubAppScope('app');

// App shell (top-level)
AppErrorGate.scope(
  scope: gateScope,
  child: AppErrorBanner(
    watchScopes: ['app.banner'],
  ),
);

// Triggering errors
bannerScope.notifier.value = AppError(...); // banner
gateScope.notifier.value = AppError(...); // full-screen gate
''',
);

Widget _buildErrorSystemAppBannerExample(BuildContext context) {
  final bannerScope = HubAppScope('docs.app.banner');
  final gateScope = HubAppScope('docs.app');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text('Triggers the app-level banner or full-screen gate.')
          .small()
          .muted(),
      const SizedBox(height: 12),
      Center(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(
              onPressed: () {
                bannerScope.notifier.value = AppError(
                  code: AppErrorCode.noInternet,
                  title: 'You are offline',
                  message: 'Check your connection and try again.',
                  actions: [
                    ErrorAction.retry(bannerScope.clear),
                  ],
                );
              },
              child: const Text('Show banner'),
            ),
            SecondaryButton(
              onPressed: () {
                gateScope.notifier.value = AppError(
                  code: AppErrorCode.server,
                  title: 'Service unavailable',
                  message: 'We are fixing an outage. Please try again soon.',
                  actions: [
                    ErrorAction.retry(gateScope.clear),
                  ],
                );
              },
              child: const Text('Show app gate'),
            ),
            SecondaryButton(
              onPressed: () {
                bannerScope.clear();
                gateScope.clear();
              },
              child: const Text('Clear all'),
            ),
          ],
        ),
      ),
    ],
  );
}
