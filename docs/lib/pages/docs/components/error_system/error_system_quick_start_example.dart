import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../blocks.dart';
import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/navigation/tab_container/tab_container.dart'
    as shadcn_tab_container;
import '../../../../ui/shadcn/components/navigation/tab_list/tab_list.dart'
    as shadcn_tab_list;
import '../../../../ui/shadcn/components/utility/error_system/error_system.dart';
import '../../../../ui/shadcn/shared/primitives/text.dart';

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

AppErrorGate.scope(
  scope: HubAppScope('app'),
  child: ScreenErrorScope(
    child: Builder(
      builder: (context) {
        final scope = ScreenErrorScope.of(context);
        return ErrorSlot.scope(scope: scope.scope);
      },
    ),
  ),
);''',
);

Widget _buildErrorSystemQuickStartExample(BuildContext context) {
  return const _ErrorSystemQuickStartExample();
}

class _ErrorSystemQuickStartExample extends StatefulWidget {
  const _ErrorSystemQuickStartExample();

  @override
  State<_ErrorSystemQuickStartExample> createState() =>
      _ErrorSystemQuickStartExampleState();
}

class _ErrorSystemQuickStartExampleState
    extends State<_ErrorSystemQuickStartExample> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        shadcn_tab_list.TabList(
          index: index,
          onChanged: (value) => setState(() => index = value),
          children: const [
            shadcn_tab_container.TabItem(child: Text('Quick Start Guide')),
            shadcn_tab_container.TabItem(child: Text('App Setup')),
            shadcn_tab_container.TabItem(child: Text('Preview')),
          ],
        ),
        const Gap(16),
        IndexedStack(
          index: index,
          children: const [
            _QuickStartGuideTab(),
            _QuickStartAppSetupTab(),
            _QuickStartPreviewTab(),
          ],
        ),
      ],
    );
  }
}

class _QuickStartGuideTab extends StatelessWidget {
  const _QuickStartGuideTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        DocsParagraph(
          text:
              'Define error rules once, then reuse the same AppError UI across the app.',
        ),
        DocsBulletList(
          items: [
            'Create a RuleBasedErrorMapper for shared rules.',
            'Extend ErrorHandledRepository to map exceptions.',
            'Use AppErrorGate for global blocking errors.',
            'Use ScreenErrorScope + ErrorSlot for per-screen errors.',
          ],
        ),
        Gap(12),
        DocsCodeBlock(
          code: '''final mapper = RuleBasedErrorMapper(
  rules: [
    ...networkRules(onRetry: () {}, onReport: () {}, onSettings: () {}),
    ...authRules(onLogin: () {}, onRetry: () {}, onReport: () {}),
  ],
  fallback: fallbackRule,
);

abstract class BaseRepository extends ErrorHandledRepository {
  BaseRepository() : super(errorMapper: mapper);
}
''',
        ),
      ],
    );
  }
}

class _QuickStartAppSetupTab extends StatelessWidget {
  const _QuickStartAppSetupTab();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DocsParagraph(
          text:
              'App structure: use ShadcnLayer at the root to enable overlays '
              '(Drawer/Popover/Tooltip). OverlayManagerLayer is only needed '
              'if you are not using ShadcnLayer. ShadcnApp is a convenience '
              'wrapper that sets up theme + ShadcnLayer for you.',
        ),
        Gap(12),
        DocsBulletList(
          items: [
            'ShadcnLayer: required for overlays and recommended at app root.',
            'OverlayManagerLayer: optional if ShadcnLayer is already present.',
            'ShadcnApp: convenience wrapper for MaterialApp + ShadcnLayer.',
          ],
        ),
      ],
    );
  }
}

class _QuickStartPreviewTab extends StatelessWidget {
  const _QuickStartPreviewTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Preview: ErrorState UI').small().muted(),
        const Gap(12),
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
}
