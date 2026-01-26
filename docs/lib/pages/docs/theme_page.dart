import 'package:flutter/material.dart';

import '../docs_page.dart';
import 'blocks.dart';
import '../../theme/theme_controller.dart';
import '../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../ui/shadcn/components/display/badge/badge.dart';
import '../../ui/shadcn/components/form/color_picker/color_picker.dart';
import '../../ui/shadcn/components/layout/card/card.dart';
import '../../ui/shadcn/shared/primitives/overlay.dart';
import '../../ui/shadcn/components/utility/color/color.dart' as color_utils;
import '../../ui/shadcn/shared/primitives/text.dart';
import '../../ui/shadcn/shared/theme/color_scheme.dart' as shadcn_scheme;
import '../../ui/shadcn/shared/utils/color_extensions.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  final OnThisPage customKey = OnThisPage();
  final OnThisPage presetKey = OnThisPage();
  final OnThisPage radiusKey = OnThisPage();
  final OnThisPage scalingKey = OnThisPage();
  final OnThisPage opacityKey = OnThisPage();
  final OnThisPage blurKey = OnThisPage();
  final OnThisPage codeKey = OnThisPage();

  @override
  Widget build(BuildContext context) {
    final controller = context.docsThemeController;
    final data = controller.data;
    final scheme = data.colorScheme;

    return DocsPage(
      name: 'theme',
      onThisPage: {
        'Custom color scheme': customKey,
        'Preset themes': presetKey,
        'Radius': radiusKey,
        'Scaling': scalingKey,
        'Surface opacity': opacityKey,
        'Surface blur': blurKey,
        'Install theme': codeKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Theme').h1(),
          const SizedBox(height: 12),
          const DocsParagraph(
            text: 'Customize the look and feel of your registry-based app.',
          ),
          DocsSectionTitle(title: 'Custom color scheme', anchor: customKey),
          const SizedBox(height: 8),
          const DocsParagraph(
            text:
                'Pick any token to create a custom scheme. Changes apply immediately so you can preview them live.',
          ),
          _buildColorGrid(context, scheme),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Preset themes', anchor: presetKey),
          const SizedBox(height: 8),
          const DocsParagraph(
            text:
                'Select a preset to quickly switch the primary palette. Default is included alongside all generated presets.',
          ),
          Row(
            children: [
              _modeButton(
                label: 'Light',
                selected: controller.brightness == Brightness.light,
                onPressed: () => controller.setBrightness(Brightness.light),
              ),
              const SizedBox(width: 8),
              _modeButton(
                label: 'Dark',
                selected: controller.brightness == Brightness.dark,
                onPressed: () => controller.setBrightness(Brightness.dark),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final preset in DocsThemeController.presets)
                _PresetChip(
                  preset: preset,
                  selected: controller.presetId == preset.id,
                  onTap: () => controller.setPreset(preset.id),
                ),
              if (controller.presetId == 'custom')
                const PrimaryBadge(child: Text('Custom')),
            ],
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Radius', anchor: radiusKey),
          const SizedBox(height: 8),
          _SliderRow(
            value: data.radius,
            minValue: 0,
            maxValue: 2,
            divisions: 20,
            label: data.radius.toStringAsFixed(2),
            onChanged: controller.setRadius,
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Scaling', anchor: scalingKey),
          const SizedBox(height: 8),
          _SliderRow(
            value: data.scaling,
            minValue: 0.5,
            maxValue: 1.5,
            divisions: 20,
            label: data.scaling.toStringAsFixed(2),
            onChanged: controller.setScaling,
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Surface opacity', anchor: opacityKey),
          const SizedBox(height: 8),
          _SliderRow(
            value: data.surfaceOpacity,
            minValue: 0,
            maxValue: 1,
            divisions: 20,
            label: data.surfaceOpacity.toStringAsFixed(2),
            onChanged: controller.setSurfaceOpacity,
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Surface blur', anchor: blurKey),
          const SizedBox(height: 8),
          _SliderRow(
            value: data.surfaceBlur,
            minValue: 0,
            maxValue: 20,
            divisions: 20,
            label: data.surfaceBlur.toStringAsFixed(1),
            onChanged: controller.setSurfaceBlur,
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Install theme', anchor: codeKey),
          const SizedBox(height: 8),
          DocsParagraph(
            text: controller.presetId == 'custom'
                ? 'Apply a custom theme JSON file using the CLI.'
                : 'Apply the selected preset theme using the CLI.',
          ),
          DocsCodeBlock(code: _buildThemeCliCommand(controller)),
        ],
      ),
    );
  }

  Widget _buildColorGrid(
      BuildContext context, shadcn_scheme.ColorScheme scheme) {
    final entries = scheme.toColorMap().entries.toList();
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (final entry in entries)
          _ColorTile(
            name: entry.key,
            color: entry.value,
            onTap: () => _openColorPicker(context, entry.key, scheme),
          ),
      ],
    );
  }

  void _openColorPicker(
    BuildContext context,
    String key,
    shadcn_scheme.ColorScheme scheme,
  ) {
    final controller = context.docsThemeController;
    showPopover(
      context: context,
      alignment: Alignment.topLeft,
      anchorAlignment: Alignment.bottomLeft,
      offset: const Offset(0, 8),
      widthConstraint: PopoverConstraint.intrinsic,
      heightConstraint: PopoverConstraint.intrinsic,
      builder: (context) {
        return SurfaceCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ColorPicker(
              value: color_utils.ColorDerivative.fromColor(
                scheme.toColorMap()[key]!,
              ),
              showAlpha: false,
              onChanged: (value) {
                final next = Map<String, Color>.from(scheme.toColorMap());
                next[key] = value.toColor();
                controller.setCustomScheme(
                  shadcn_scheme.ColorScheme.fromColors(
                    colors: next,
                    brightness: scheme.brightness,
                  ),
                );
                closeOverlay(context);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _modeButton({
    required String label,
    required bool selected,
    required VoidCallback onPressed,
  }) {
    if (selected) {
      return shadcn_buttons.OutlineButton(
        onPressed: onPressed,
        size: shadcn_buttons.ButtonSize.small,
        density: shadcn_buttons.ButtonDensity.compact,
        child: Text(label),
      );
    }
    return shadcn_buttons.GhostButton(
      onPressed: onPressed,
      size: shadcn_buttons.ButtonSize.small,
      density: shadcn_buttons.ButtonDensity.compact,
      child: Text(label),
    );
  }

  String _buildThemeCliCommand(DocsThemeController controller) {
    if (controller.presetId == 'custom') {
      return 'flutter_shadcn --experimental theme --apply-file /path/to/theme.json';
    }
    return 'flutter_shadcn theme --apply ${controller.presetId}';
  }
}

class _PresetChip extends StatelessWidget {
  final DocsThemePreset preset;
  final bool selected;
  final VoidCallback onTap;

  const _PresetChip({
    required this.preset,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = preset.light;
    final indicator = Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: scheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: scheme.primaryForeground,
          width: 2,
        ),
      ),
    );
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        indicator,
        const SizedBox(width: 6),
        Text(preset.name).small(),
      ],
    );
    final paddedChild = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: child,
    );

    if (selected) {
      return shadcn_buttons.PrimaryButton(
        onPressed: onTap,
        size: shadcn_buttons.ButtonSize.small,
        density: shadcn_buttons.ButtonDensity.normal,
        child: paddedChild,
      );
    }
    return shadcn_buttons.OutlineButton(
      onPressed: onTap,
      size: shadcn_buttons.ButtonSize.small,
      density: shadcn_buttons.ButtonDensity.normal,
      child: paddedChild,
    );
  }
}

class _ColorTile extends StatelessWidget {
  final String name;
  final Color color;
  final VoidCallback onTap;

  const _ColorTile({
    required this.name,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final labelColor = color.computeLuminance() > 0.5
        ? Colors.black.withValues(alpha: 0.8)
        : Colors.white.withValues(alpha: 0.9);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Text(name, style: TextStyle(color: labelColor)).xSmall(),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text(
                colorToHex(color),
                style: TextStyle(color: labelColor),
              ).xSmall(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  final double value;
  final double minValue;
  final double maxValue;
  final int divisions;
  final String label;
  final ValueChanged<double> onChanged;

  const _SliderRow({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.divisions,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Slider(
            value: value.clamp(minValue, maxValue),
            min: minValue,
            max: maxValue,
            divisions: divisions,
            label: label,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 48,
          child: Text(label).xSmall().muted(),
        ),
      ],
    );
  }
}
