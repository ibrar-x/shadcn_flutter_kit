import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart';
import '../../../../ui/shadcn/components/utility/error_system/error_system.dart';
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample errorSystemScreenScopeExample = ComponentExample(
  title: 'ScreenErrorScope + ErrorSlot',
  builder: _buildErrorSystemScreenScopeExample,
  code: '''ScreenErrorScope(
  child: Builder(
    builder: (context) {
      final scope = ScreenErrorScope.of(context);
      return Column(
        children: [
          ErrorSlot.scope(scope: scope.scope),
          PrimaryButton(
            onPressed: () {
              scope.set(
                AppError(
                  code: AppErrorCode.validation,
                  title: 'Missing fields',
                  message: 'Fill in the required fields.',
                ),
              );
            },
            child: Text('Trigger error'),
          ),
        ],
      );
    },
  ),
);''',
);

Widget _buildErrorSystemScreenScopeExample(BuildContext context) {
  return ScreenErrorScope(
    child: Builder(
      builder: (context) {
        final scope = ScreenErrorScope.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ErrorSlot.scope(
              scope: scope.scope,
              empty: const Text('No errors in this screen yet.').muted(),
            ),
            const SizedBox(height: 16),
            Center(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  PrimaryButton(
                    onPressed: () {
                      scope.set(
                        AppError(
                          code: AppErrorCode.validation,
                          title: 'Missing fields',
                          message: 'Fill in the required fields.',
                          actions: [
                            ErrorAction.retry(scope.clear),
                          ],
                        ),
                      );
                    },
                    child: const Text('Trigger error'),
                  ),
                  SecondaryButton(
                    onPressed: scope.clear,
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}
