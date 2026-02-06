import 'package:docs/pages/docs_page.dart';
import 'package:flutter/material.dart';

import '../../component_page.dart';
import '../../components_registry.dart';
import '../../../../ui/shadcn/shared/primitives/text.dart';
import 'error_system_quick_start_example.dart';

class ErrorSystemQuickStartPage extends StatelessWidget {
  const ErrorSystemQuickStartPage({super.key});

  static final Map<String, OnThisPage> _quickStartAnchors = {
    'Overview': OnThisPage('Overview'),
    'Installation': OnThisPage('Installation'),
    'Quick Start': OnThisPage('Quick Start'),
    'Custom rules': OnThisPage('Custom rules'),
    'Core Models': OnThisPage('Core Models'),
    'Error Mapping (Rules + Repositories)':
        OnThisPage('Error Mapping (Rules + Repositories)'),
    'Dual Scopes (AppErrorHub)': OnThisPage('Dual Scopes (AppErrorHub)'),
    'AppErrorGate (Full-Screen Overlay)':
        OnThisPage('AppErrorGate (Full-Screen Overlay)'),
    'ScreenErrorScope (Recommended)':
        OnThisPage('ScreenErrorScope (Recommended)'),
    'guard() (Optional)': OnThisPage('guard() (Optional)'),
    'UI Components': OnThisPage('UI Components'),
    'Theming': OnThisPage('Theming'),
    'Analytics, Localization, Testing':
        OnThisPage('Analytics, Localization, Testing'),
    'Best Practices': OnThisPage('Best Practices'),
  };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RegistryComponent>>(
      future: loadRegistryComponents(),
      builder: (context, snapshot) {
        final component = snapshot.data?.firstWhere(
          (item) => item.id == 'error_system',
          orElse: () => const RegistryComponent(
            id: 'error_system',
            name: 'Error System',
            description: 'Component not found in registry.',
            category: 'Utility',
            tags: [],
          ),
        );

        return ComponentPage(
          name: 'error_system',
          description: component?.description ?? '',
          displayName: component?.name ?? 'Error System',
          category: component?.category ?? 'Utility',
          onThisPageOverride: _quickStartAnchors,
          children: [
            const Text('Quick Start Guide').h2(),
            const SizedBox(height: 8),
            const Text(
              'Use this guide to set up error mapping, scopes, and UI. '
              'This is a standalone page so the sidebar matches the component.',
            ).muted(),
            const SizedBox(height: 16),
            ErrorSystemQuickStartGuide(onThisPage: _quickStartAnchors),
          ],
        );
      },
    );
  }
}
