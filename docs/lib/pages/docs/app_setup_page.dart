import 'package:flutter/material.dart';

import '../docs_page.dart';
import 'blocks.dart';
import '../../ui/shadcn/shared/primitives/text.dart';

class AppSetupPage extends StatefulWidget {
  const AppSetupPage({super.key});

  @override
  State<AppSetupPage> createState() => _AppSetupPageState();
}

class _AppSetupPageState extends State<AppSetupPage> {
  final OnThisPage layerKey = OnThisPage();
  final OnThisPage overlayKey = OnThisPage();
  final OnThisPage appKey = OnThisPage();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'app-setup',
      onThisPage: {
        'ShadcnLayer': layerKey,
        'OverlayManagerLayer': overlayKey,
        'ShadcnApp': appKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('App Setup').h1(),
          const SizedBox(height: 8),
          const DocsParagraph(
            text:
                'Use ShadcnLayer at the app root to enable overlays and theme primitives. '
                'OverlayManagerLayer is only needed if you are not using ShadcnLayer. '
                'ShadcnApp is a convenience wrapper that sets up theme + ShadcnLayer for you.',
          ),
          DocsSectionTitle(title: 'ShadcnLayer', anchor: layerKey),
          const SizedBox(height: 12),
          const DocsParagraph(
            text:
                'Recommended root wrapper. It injects overlay handling for popovers, tooltips, menus, and drawers.',
          ),
          const DocsCodeBlock(
            code: '''return shadcn.Theme(
  data: docsTheme.toShadcnTheme(),
  child: ShadcnLayer(
    child: MaterialApp.router(
      routerConfig: router,
    ),
  ),
);''',
          ),
          const SizedBox(height: 24),
          DocsSectionTitle(title: 'OverlayManagerLayer', anchor: overlayKey),
          const SizedBox(height: 12),
          const DocsParagraph(
            text:
                'Only use this if you are not using ShadcnLayer. It provides the overlay manager without other defaults.',
          ),
          const DocsCodeBlock(
            code: '''return OverlayManagerLayer(
  popoverHandler: OverlayHandler.popover,
  tooltipHandler: OverlayHandler.popover,
  menuHandler: OverlayHandler.popover,
  child: MaterialApp.router(
    routerConfig: router,
  ),
);''',
          ),
          const SizedBox(height: 24),
          DocsSectionTitle(title: 'ShadcnApp', anchor: appKey),
          const SizedBox(height: 12),
          const DocsParagraph(
            text:
                'Use ShadcnApp if you want a convenience wrapper that applies theme defaults and ShadcnLayer for you.',
          ),
          const DocsCodeBlock(
            code: '''return ShadcnApp(
  theme: docsTheme.toShadcnTheme(),
  materialTheme: docsTheme.toMaterialTheme(),
  routerConfig: router,
);''',
          ),
        ],
      ),
    );
  }
}
