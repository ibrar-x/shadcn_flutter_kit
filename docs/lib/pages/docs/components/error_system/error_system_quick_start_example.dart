import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../blocks.dart';
import '../../../docs_page.dart';

class ErrorSystemQuickStartGuide extends StatelessWidget {
  const ErrorSystemQuickStartGuide({
    super.key,
    required this.onThisPage,
  });

  final Map<String, OnThisPage> onThisPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DocsSectionTitle(
          title: 'Overview',
          anchor: onThisPage['Overview'],
        ),
        const DocsParagraph(
          text:
              'Production-ready error handling that maps exceptions into a single '
              'AppError model and renders consistent UI across your app. It provides '
              'dual-scope error channels for app-level and screen-level errors.',
        ),
        const DocsBulletList(
          items: [
            'Map any exception to a user-facing AppError once.',
            'Centralize network/auth/api/validation rules.',
            'Render consistent error UI everywhere.',
            'Use app + screen scopes without boilerplate.',
          ],
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'Installation',
          anchor: onThisPage['Installation'],
        ),
        const DocsParagraph(text: 'Install via the CLI:'),
        const DocsCodeBlock(code: 'flutter_shadcn add error-system', mode: 'bash'),
        const Gap(16),
        DocsSectionTitle(
          title: 'Quick Start',
          anchor: onThisPage['Quick Start'],
        ),
        const DocsParagraph(text: '1) Create an ErrorMapper (once)'),
        const DocsCodeBlock(
          code: '''final mapper = RuleBasedErrorMapper(
  rules: [
    ...networkRules(onRetry: () {}, onReport: () {}, onSettings: () {}),
    ...authRules(onLogin: () {}, onRetry: () {}, onReport: () {}),
    ...apiRules(onRetry: () {}, onReport: () {}, onBack: () {}),
    ...validationRules(onRetry: () {}),
  ],
  fallback: fallbackRule,
);''',
        ),
        const Gap(12),
        const DocsParagraph(text: '2) Base repository'),
        const DocsCodeBlock(
          code: '''abstract class BaseRepository extends ErrorHandledRepository {
  BaseRepository() : super(errorMapper: mapper);
}''',
        ),
        const Gap(12),
        const DocsParagraph(text: '3) Use in repositories'),
        const DocsCodeBlock(
          code: '''class UserRepository extends BaseRepository {
  final ApiClient _api;
  UserRepository(this._api);

  Future<User> getUser(String id) {
    return execute(() => _api.getUser(id));
  }
}''',
        ),
        const Gap(12),
        const DocsParagraph(text: '4) Render in UI'),
        const DocsCodeBlock(
          code: '''ErrorState(
  error: AppError(
    code: AppErrorCode.network,
    title: 'Connection failed',
    message: 'Check your internet connection.',
    actions: [ErrorAction.retry(() {})],
  ),
);''',
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'Custom rules',
          anchor: onThisPage['Custom rules'],
        ),
        const DocsParagraph(
          text:
              'Add custom rules to map your domain-specific errors. Rules are evaluated in order, so place more specific matches first.',
        ),
        const DocsCodeBlock(
          code: '''final customRule = ErrorRule(
  match: (error) => error is PaymentException,
  map: (error) => AppError(
    code: AppErrorCode.payment,
    title: 'Payment failed',
    message: 'Please check your card details and try again.',
    actions: [ErrorAction.retry(() {})],
  ),
);

final mapper = RuleBasedErrorMapper(
  rules: [
    customRule,
    ...networkRules(onRetry: () {}, onReport: () {}, onSettings: () {}),
  ],
  fallback: fallbackRule,
);''',
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'Core Models',
          anchor: onThisPage['Core Models'],
        ),
        const DocsBulletList(
          items: [
            'AppError: user-facing error model (title/message/actions/code).',
            'AppErrorCode: category/severity enum for styling.',
            'ErrorAction: action metadata (retry/login/back).',
          ],
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'Error Mapping (Rules + Repositories)',
          anchor: onThisPage['Error Mapping (Rules + Repositories)'],
        ),
        const DocsParagraph(text: 'Rule-based mapping with a fallback:'),
        const DocsCodeBlock(
          code: '''final mapper = RuleBasedErrorMapper(
  rules: [
    ...networkRules(onRetry: () {}, onReport: () {}, onSettings: () {}),
    ...authRules(onLogin: () {}, onRetry: () {}, onReport: () {}),
  ],
  fallback: fallbackRule,
);''',
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'Dual Scopes (AppErrorHub)',
          anchor: onThisPage['Dual Scopes (AppErrorHub)'],
        ),
        const DocsParagraph(
          text: 'Use app-level for global blockers and screen-level for per-screen issues.',
        ),
        const DocsCodeBlock(
          code: '''// App-level (global)
AppErrorHub.I.app(AppErrorHub.networkUnavailable).value = AppError(...);

// Screen-level (manual)
AppErrorHub.I.screen('UserScreen').value = AppError(...);''',
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'AppErrorGate (Full-Screen Overlay)',
          anchor: onThisPage['AppErrorGate (Full-Screen Overlay)'],
        ),
        const DocsParagraph(
          text:
              'App-level errors should not replace the Navigator. Use a gate overlay '
              'so the user returns to the exact screen/state once the error clears.',
        ),
        const DocsCodeBlock(
          code: '''final globalScope = HubAppScope('global');

return AppErrorGate.scope(
  scope: globalScope,
  child: ShadcnApp(
    title: 'My App',
    theme: const ThemeData(),
    home: const MyHomePage(),
  ),
);''',
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'ScreenErrorScope (Recommended)',
          anchor: onThisPage['ScreenErrorScope (Recommended)'],
        ),
        const DocsParagraph(
          text:
              'Owns a screen channel and disposes it automatically, exposing '
              'run/runSync helpers for async work.',
        ),
        const DocsCodeBlock(
          code: '''ScreenErrorScope(
  child: Builder(
    builder: (context) {
      final s = ScreenErrorScope.of(context);
      return Column(
        children: [
          ErrorSlot.scope(scope: s.scope),
          PrimaryButton(
            onPressed: () => s.run(() => repo.execute(() async => apiCall())),
            child: const Text('Load'),
          ),
        ],
      );
    },
  ),
);''',
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'guard() (Optional)',
          anchor: onThisPage['guard() (Optional)'],
        ),
        const DocsParagraph(
          text: 'Use guard() for small call sites without a ScreenErrorScope.',
        ),
        const DocsCodeBlock(
          code: '''final scope = HubScreenScope('UserScreen');
await guard(() => repo.execute(() async => apiCall()), scope: scope);''',
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'UI Components',
          anchor: onThisPage['UI Components'],
        ),
        const DocsBulletList(
          items: [
            'ErrorState: full-page/section error UI.',
            'InlineError: compact inline message.',
            'ErrorDialog.show(...): blocking dialog.',
            'ErrorSnackbar.show(...): toast-style error.',
            'AppErrorBanner: global banner for app-level errors.',
            'ErrorSlot.scope(...): reactive slot that renders a scoped error.',
          ],
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'Theming',
          anchor: onThisPage['Theming'],
        ),
        const DocsParagraph(text: 'Theme via ComponentTheme<ErrorSystemTheme>:'),
        const DocsCodeBlock(
          code: '''ComponentTheme(
  data: const ErrorSystemTheme(
    bannerBackgroundColor: Color(0xFF1F1F1F),
  ),
  child: ...
);''',
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'Analytics, Localization, Testing',
          anchor: onThisPage['Analytics, Localization, Testing'],
        ),
        const DocsBulletList(
          items: [
            'Use ErrorReporter to integrate Crashlytics or custom analytics.',
            'Localize AppError strings inside rules or UI.',
            'Use fake ErrorScope or mock ErrorMapper for tests.',
          ],
        ),
        const Gap(16),
        DocsSectionTitle(
          title: 'Best Practices',
          anchor: onThisPage['Best Practices'],
        ),
        const DocsBulletList(
          items: [
            'Use ScreenErrorScope for new screens.',
            'Use AppErrorBanner only for app-level issues.',
            'Keep error messages short and user-facing.',
            'Use ErrorAction factories to standardize labels.',
          ],
        ),
      ],
    );
  }
}
