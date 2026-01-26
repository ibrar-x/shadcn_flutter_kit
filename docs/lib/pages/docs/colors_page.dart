import 'package:flutter/material.dart';

import '../docs_page.dart';
import 'blocks.dart';
import '../../ui/shadcn/components/layout/outlined_container/outlined_container.dart';
import '../../ui/shadcn/shared/primitives/text.dart';
import '../../ui/shadcn/shared/theme/color_scheme.dart' as shadcn_scheme;
import '../../ui/shadcn/shared/theme/generated_colors.dart' as shadcn_colors;
import '../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OnThisPage palettesKey = OnThisPage();
    final OnThisPage schemeKey = OnThisPage();

    return DocsPage(
      name: 'colors',
      onThisPage: {
        'Predefined palettes': palettesKey,
        'Semantic scheme': schemeKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Colors').h1(),
          const SizedBox(height: 8),
          const DocsParagraph(
            text:
                'The registry ships with shadcn-inspired palettes and semantic color schemes. Use palettes for custom UI and ColorScheme for component defaults.',
          ),
          DocsSectionTitle(title: 'Predefined palettes', anchor: palettesKey),
          const SizedBox(height: 12),
          _paletteRow('Slate', shadcn_colors.Colors.slate),
          const SizedBox(height: 12),
          _paletteRow('Blue', shadcn_colors.Colors.blue),
          const SizedBox(height: 12),
          _paletteRow('Emerald', shadcn_colors.Colors.emerald),
          const SizedBox(height: 12),
          _paletteRow('Rose', shadcn_colors.Colors.rose),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Semantic scheme', anchor: schemeKey),
          const SizedBox(height: 12),
          const DocsParagraph(
            text:
                'Semantic colors are exposed through Theme.of(context).colorScheme. These drive component defaults and keep surfaces, borders, and accents consistent.',
          ),
          const SizedBox(height: 12),
          _schemeGrid(shadcn_theme.Theme.of(context).colorScheme),
        ],
      ),
    );
  }

  Widget _paletteRow(String name, shadcn_scheme.ColorShades shades) {
    const displayed = [100, 300, 500, 700, 900];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name).semiBold(),
        const SizedBox(height: 8),
        Row(
          children: [
            for (final shade in displayed)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      OutlinedContainer(
                        child: Container(
                          height: 48,
                          color: shades[shade],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text('$shade').xSmall().muted(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _schemeGrid(shadcn_scheme.ColorScheme scheme) {
    final tokens = <String, Color>{
      'Background': scheme.background,
      'Foreground': scheme.foreground,
      'Card': scheme.card,
      'Primary': scheme.primary,
      'Accent': scheme.accent,
      'Muted': scheme.muted,
      'Border': scheme.border,
      'Destructive': scheme.destructive,
    };

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: tokens.entries.map((entry) {
        return SizedBox(
          width: 160,
          child: OutlinedContainer(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: entry.value,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(entry.key).small().semiBold(),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
