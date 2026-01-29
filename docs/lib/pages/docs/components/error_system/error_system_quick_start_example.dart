import 'package:flutter/widgets.dart';

import '../../blocks.dart';
import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/error_system/error_system.dart';

const ComponentExample errorSystemQuickStartExample = ComponentExample(
  title: 'Quick start',
  builder: _buildErrorSystemQuickStartExample,
  code: '''final mapper = RuleBasedErrorMapper(
  rules: [
    ...networkRules(onRetry: () {}, onReport: () {}, onSettings: () {}),
    ...authRules(onLogin: () {}, onRetry: () {}, onReport: () {}),
    ...apiRules(onRetry: () {}, onReport: () {}, onBack: () {}),
    ...validationRules(onRetry: () {}),
  ],
  fallback: fallbackRule,
);

abstract class BaseRepository extends ErrorHandledRepository {
  BaseRepository() : super(errorMapper: mapper);
}

ErrorState(
  error: AppError(
    code: AppErrorCode.network,
    title: 'Connection failed',
    message: 'Check your internet connection.',
    actions: [ErrorAction.retry(() {})],
  ),
);''',
);

Widget _buildErrorSystemQuickStartExample(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const DocsParagraph(
        text:
            'Map exceptions to AppError once in your repositories, then render consistent UI everywhere.',
      ),
      const DocsBulletList(
        items: [
          'Create a RuleBasedErrorMapper with built-in rules.',
          'Extend ErrorHandledRepository to map exceptions automatically.',
          'Render errors with ErrorState, ErrorSlot, or banners.',
        ],
      ),
      const SizedBox(height: 16),
      ErrorState(
        error: AppError(
          code: AppErrorCode.network,
          title: 'Connection failed',
          message: 'Check your internet connection and try again.',
          actions: [
            ErrorAction.retry(() {}),
            ErrorAction.report(() {}),
          ],
        ),
      ),
    ],
  );
}
