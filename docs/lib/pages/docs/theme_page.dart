import 'package:docs/shadcn_ui.dart';
import 'package:docs/ui/shadcn/components/form/slider/_impl/core/shad_slider_models.dart'
    show ShadRangeValue;

import '../../theme/docs_theme.dart';
import '../../theme/theme_controller.dart';
import '../../ui/shadcn/shared/theme/preset_themes.dart';
import '../docs_page.dart';
import 'blocks.dart';

const Map<String, String> _themeModes = {
  'Light': 'light',
  'Dark': 'dark',
};

const List<String> _baseColors = [
  'Slate',
  'Zinc',
  'Gray',
  'Neutral',
  'Stone',
];

const List<String> _accentColors = [
  'Base',
  'Slate',
  'Gray',
  'Zinc',
  'Neutral',
  'Stone',
  'Red',
  'Orange',
  'Amber',
  'Yellow',
  'Lime',
  'Green',
  'Emerald',
  'Teal',
  'Cyan',
  'Sky',
  'Blue',
  'Indigo',
  'Violet',
  'Purple',
  'Fuchsia',
  'Pink',
  'Rose',
];

const Map<String, double> _radiusOptions = {
  'Sharp': 0.0,
  'Subtle': 0.25,
  'Default': 0.5,
  'Rounded': 0.75,
  'Pill': 1.5,
};

const Map<String, double> _scalingOptions = {
  'Compact': 0.85,
  'Default': 1.0,
  'Large': 1.15,
};

const Map<String, Density> _densityOptions = {
  'Compact': Density.compactDensity,
  'Reduced': Density.reducedDensity,
  'Default': Density.defaultDensity,
  'Spacious': Density.spaciousDensity,
};

const Map<String, double> _surfaceOpacityOptions = {
  'Solid': 1.0,
  'Frosted': 0.9,
  'Translucent': 0.8,
  'Ghosted': 0.7,
  'Invisible': 0.0,
};

const Map<String, double> _surfaceBlurOptions = {
  'None': 0.0,
  'Soft': 4.0,
  'Medium': 8.0,
  'Strong': 12.0,
};

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  String? _baseColorOverride;
  String? _accentColorOverride;

  bool _previewSwitch = true;
  CheckboxState _previewCheckbox = CheckboxState.checked;
  ShadRangeValue _priceRange = const ShadRangeValue(320, 800);

  @override
  Widget build(BuildContext context) {
    final controller = context.docsThemeController;
    final data = controller.data;
    final showInlineOptions =
        MediaQuery.of(context).size.width < breakpointWidth2;

    return DocsPage(
      name: 'theme',
      onThisPage: const {},
      sidebar: SizedBox(
        width: 300,
        child: _buildOptionsPanel(context),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final showThreePreviewCols = constraints.maxWidth >= 1380;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Theme').h1(),
              const SizedBox(height: 12),
              const DocsParagraph(
                text:
                    'Tune visual tokens while previewing live UI blocks, matching the docs theme workflow.',
              ),
              const SizedBox(height: 14),
              if (showInlineOptions) ...[
                _buildOptionsPanel(context),
                const SizedBox(height: 24),
              ],
              _buildKitchenPreview(
                context,
                threeColumns: showThreePreviewCols,
              ),
              const SizedBox(height: 28),
              const Text('Code').h2(),
              const SizedBox(height: 8),
              DocsCodeBlock(code: _buildCodeSnippet(controller, data)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildKitchenPreview(BuildContext context,
      {required bool threeColumns}) {
    if (threeColumns) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildPaymentCard(context)),
          const SizedBox(width: 20),
          Expanded(child: _buildMiddlePreview(context)),
          const SizedBox(width: 20),
          Expanded(child: _buildAppearancePanel(context)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPaymentCard(context),
        const SizedBox(height: 20),
        _buildMiddlePreview(context),
        const SizedBox(height: 20),
        _buildAppearancePanel(context),
      ],
    );
  }

  Widget _buildPaymentCard(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Payment Method').large().semiBold(),
          const SizedBox(height: 6),
          const Text('All transactions are secure and encrypted.')
              .muted()
              .small(),
          const SizedBox(height: 16),
          const Text('Name on Card').medium(),
          const SizedBox(height: 8),
          const TextField(placeholder: Text('John Doe')),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Card Number').medium(),
                    const SizedBox(height: 8),
                    const TextField(placeholder: Text('1234 5678 9012 3456')),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('CVV').medium(),
                    const SizedBox(height: 8),
                    const TextField(placeholder: Text('123')),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Enter your 16-digit number.').muted().small(),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _smallSelect(
                  value: 'MM',
                  options: const ['MM', '01', '02', '03', '04', '05'],
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _smallSelect(
                  value: 'YYYY',
                  options: const ['YYYY', '2026', '2027', '2028', '2029'],
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Text('Billing Address').medium(),
          const SizedBox(height: 6),
          const Text('The billing address associated with your payment method')
              .muted()
              .small(),
          const SizedBox(height: 10),
          Checkbox(
            state: _previewCheckbox,
            onChanged: (value) {
              setState(() {
                _previewCheckbox = value;
              });
            },
            trailing: const Text('Same as shipping address'),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Text('Comments').medium(),
          const SizedBox(height: 8),
          const TextArea(
            minHeight: 90,
            maxHeight: 120,
            placeholder: Text('Add any additional comments'),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              PrimaryButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
              const SizedBox(width: 10),
              OutlineButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiddlePreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedContainer(
          borderStyle: BorderStyle.solid,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarGroup.toLeft(
                  offset: 0.7,
                  gap: 2,
                  children: const [
                    Avatar(initials: 'MJ'),
                    Avatar(initials: 'JS'),
                    Avatar(initials: 'ST'),
                  ],
                ),
                const SizedBox(height: 14),
                const Text('No Team Members').medium(),
                const SizedBox(height: 8),
                const Text('Invite your team to collaborate on this project.')
                    .muted()
                    .small()
                    .center(),
                const SizedBox(height: 12),
                SecondaryButton(
                  onPressed: () {},
                  leading: const Icon(Icons.add),
                  child: const Text('Invite Members'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            SecondaryBadge(child: Text('Syncing')),
            SizedBox(width: 8),
            SecondaryBadge(child: Text('Updating')),
            SizedBox(width: 8),
            OutlineBadge(child: Text('Loading')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            IconButton.outline(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: TextField(
                placeholder: Text('Send a message...'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text('Price Range').medium(),
        const SizedBox(height: 6),
        const Text('Set your budget range (\$320 - \$800)').muted().small(),
        const SizedBox(height: 8),
        Slider.range(
          min: 0,
          max: 1000,
          rangeValue: _priceRange,
          onChanged: (value) {
            setState(() {
              _priceRange = value;
            });
          },
        ),
        const SizedBox(height: 10),
        const TextField(
          placeholder: Text('Search...'),
          features: [
            InputFeature.leading(Icon(Icons.search)),
            InputFeature.trailing(Text('12 Results')),
          ],
        ),
        const SizedBox(height: 10),
        const TextField(
          placeholder: Text('https://example.com'),
        ),
        const SizedBox(height: 10),
        const TextArea(
          minHeight: 78,
          maxHeight: 90,
          placeholder: Text('Ask, Search, or Chat...'),
        ),
        const SizedBox(height: 10),
        const TextField(
          placeholder: Text('@sunarya-thito'),
          features: [
            InputFeature.trailing(Icon(Icons.check_circle_outline)),
          ],
        ),
      ],
    );
  }

  Widget _buildAppearancePanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Two-factor authentication'),
                    SizedBox(height: 4),
                    Text('Verify via email or phone number.'),
                  ],
                ),
              ),
              SecondaryButton(
                onPressed: () {},
                child: const Text('Enable'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Card(
          child: Row(
            children: [
              Icon(Icons.verified_outlined),
              SizedBox(width: 8),
              Expanded(child: Text('Your profile has been verified.')),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        const Text('Compute Environment').large().semiBold(),
        const SizedBox(height: 6),
        const Text('Select the compute environment for your cluster.')
            .muted()
            .small(),
        const SizedBox(height: 10),
        RadioGroup<bool>(
          value: true,
          onChanged: (_) {},
          child: const Column(
            children: [
              RadioCard(
                value: true,
                child: Basic(
                  title: Text('Kubernetes'),
                  subtitle:
                      Text('Run GPU workloads on a K8s configured cluster.'),
                  trailing: Radio(value: true),
                ),
              ),
              SizedBox(height: 8),
              RadioCard(
                value: false,
                child: Basic(
                  title: Text('Virtual Machine'),
                  subtitle:
                      Text('Access a VM configured cluster to run workloads.'),
                  trailing: Radio(value: false),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Divider(),
        const SizedBox(height: 14),
        const Row(
          children: [
            Expanded(
              child: Basic(
                title: Text('Number of GPUs'),
                subtitle: Text('You can add more later.'),
              ),
            ),
            SizedBox(
              width: 140,
              child: TextField(
                initialValue: '8',
                features: [
                  InputFeature.trailing(Icon(Icons.add)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Divider(),
        const SizedBox(height: 14),
        Row(
          children: [
            const Expanded(
              child: Basic(
                title: Text('Wallpaper Tinting'),
                subtitle: Text('Allow the wallpaper to be tinted.'),
              ),
            ),
            Switch(
              value: _previewSwitch,
              onChanged: (value) {
                setState(() {
                  _previewSwitch = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionsPanel(BuildContext context) {
    final controller = context.docsThemeController;
    final data = controller.data;
    final isDark = controller.brightness == Brightness.dark;
    final presetTokens = _activePresetTokens(controller);
    final baseColor = _inferBaseColor(
      presetId: controller.presetId,
      scheme: data.colorScheme,
      isDark: isDark,
    );
    final accentColor = _inferAccentColor(
      data.colorScheme.primary,
      _baseColorOverride ?? baseColor,
    );
    final selectedBaseColor = _baseColorOverride ?? baseColor;
    final selectedAccentColor = _accentColorOverride ?? accentColor;
    final densityLabel = _densityLabel(
      density: data.density,
      presetDensity: presetTokens.density,
    );
    final densityValues = ['Preset', ..._densityOptions.keys];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Theme options').h2(),
        const SizedBox(height: 14),
        _panelLabel('Theme mode'),
        _stringSelect(
          value: isDark ? 'Dark' : 'Light',
          values: _themeModes.keys.toList(),
          onChanged: (value) {
            if (value == null) return;
            controller.setBrightness(
              value == 'Dark' ? Brightness.dark : Brightness.light,
            );
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Preset themes'),
        _stringSelect(
          value: controller.presetId,
          values: DocsThemeController.presets.map((p) => p.id).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.setPreset(value);
              setState(() {
                _baseColorOverride = null;
                _accentColorOverride = null;
              });
            }
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Base colors'),
        _stringSelect(
          value: selectedBaseColor,
          values: _baseColors,
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _baseColorOverride = value == baseColor ? null : value;
            });
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Accent colors'),
        _stringSelect(
          value: selectedAccentColor,
          values: _accentColors,
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _accentColorOverride = value == accentColor ? null : value;
            });
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Radius'),
        _numericSelect(
          value: data.radius,
          options: _radiusOptions,
          onChanged: controller.setRadius,
        ),
        const SizedBox(height: 12),
        _panelLabel('Density'),
        _stringSelect(
          value: densityLabel,
          values: densityValues,
          onChanged: (value) {
            if (value == null) return;
            if (value == 'Preset') {
              controller.setDensity(presetTokens.density);
              return;
            }
            final density = _densityOptions[value];
            if (density != null) {
              controller.setDensity(density);
            }
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Scaling'),
        _numericSelect(
          value: data.scaling,
          options: _scalingOptions,
          onChanged: controller.setScaling,
        ),
        const SizedBox(height: 12),
        _panelLabel('Surface opacity'),
        _numericSelect(
          value: data.surfaceOpacity,
          options: _surfaceOpacityOptions,
          onChanged: controller.setSurfaceOpacity,
        ),
        const SizedBox(height: 12),
        _panelLabel('Surface blur'),
        _numericSelect(
          value: data.surfaceBlur,
          options: _surfaceBlurOptions,
          onChanged: controller.setSurfaceBlur,
        ),
      ],
    );
  }

  Widget _panelLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text).small().semiBold(),
    );
  }

  Widget _numericSelect({
    required double value,
    required Map<String, double> options,
    required ValueChanged<double> onChanged,
  }) {
    var selected = options.entries.first.key;
    for (final entry in options.entries) {
      if (entry.value == value) {
        selected = entry.key;
        break;
      }
    }
    return _stringSelect(
      value: selected,
      values: options.keys.toList(),
      onChanged: (choice) {
        if (choice == null) return;
        final next = options[choice];
        if (next != null) onChanged(next);
      },
    );
  }

  Widget _smallSelect({
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Select<String>(
      value: value,
      onChanged: onChanged,
      itemBuilder: (context, item) => Text(item),
      popup: SelectPopup.noVirtualization(
        items: SelectItemList(
          children: [
            for (final item in options)
              SelectItemButton(
                value: item,
                child: Text(item),
              ),
          ],
        ),
      ),
    );
  }

  Widget _stringSelect({
    required String value,
    required List<String> values,
    ValueChanged<String?>? onChanged,
  }) {
    return Select<String>(
      value: value,
      onChanged: onChanged,
      itemBuilder: (context, item) => Text(item),
      popup: SelectPopup.noVirtualization(
        items: SelectItemList(
          children: [
            for (final item in values)
              SelectItemButton(
                value: item,
                child: Text(item),
              ),
          ],
        ),
      ),
    );
  }

  String _buildCodeSnippet(DocsThemeController controller, DocsThemeData data) {
    final isDark = controller.brightness == Brightness.dark;
    final presetTokens = _activePresetTokens(controller);
    final baseColor = _inferBaseColor(
      presetId: controller.presetId,
      scheme: data.colorScheme,
      isDark: isDark,
    );
    final accentColor = _inferAccentColor(data.colorScheme.primary, baseColor);
    final selectedBase = _baseColorOverride ?? baseColor;
    final selectedAccent = _accentColorOverride ?? accentColor;
    final densityLabel = _densityLabel(
      density: data.density,
      presetDensity: presetTokens.density,
    );

    final extras = <String>[];
    if (!isDark) {
      extras.add('--mode light');
    }
    if (_baseColorOverride != null) {
      extras.add('--base ${selectedBase.toLowerCase()}');
    }
    if (_accentColorOverride != null) {
      extras.add('--accent ${selectedAccent.toLowerCase()}');
    }
    if (data.radius != presetTokens.radius) {
      extras.add('--radius ${data.radius}');
    }
    if (densityLabel != 'Preset') {
      extras.add('--density ${densityLabel.toLowerCase()}');
    }
    if (data.scaling != 1.0) {
      extras.add('--scaling ${data.scaling}');
    }
    if (data.surfaceOpacity != 1.0) {
      extras.add('--surface-opacity ${data.surfaceOpacity}');
    }
    if (data.surfaceBlur != 0.0) {
      extras.add('--surface-blur ${data.surfaceBlur}');
    }

    final lines = <String>[
      'flutter_shadcn theme --apply ${controller.presetId}',
      for (final extra in extras) '  $extra',
    ];
    if (lines.length > 1) {
      for (var i = 0; i < lines.length - 1; i += 1) {
        lines[i] = '${lines[i]} \\';
      }
    }
    return lines.join('\n');
  }

  RegistryThemePresetTokens _activePresetTokens(
      DocsThemeController controller) {
    final preset = DocsThemeController.presets.firstWhere(
      (entry) => entry.id == controller.presetId,
      orElse: () => DocsThemeController.presets.first,
    );
    return controller.brightness == Brightness.dark
        ? preset.darkTokens
        : preset.lightTokens;
  }

  String _densityLabel({
    required Density density,
    required Density presetDensity,
  }) {
    if (density == presetDensity) {
      return 'Preset';
    }
    return _densityOptions.entries
        .firstWhere(
          (entry) => entry.value == density,
          orElse: () => const MapEntry('Default', Density.defaultDensity),
        )
        .key;
  }

  String _inferBaseColor({
    required String presetId,
    required ColorScheme scheme,
    required bool isDark,
  }) {
    final lower = presetId.toLowerCase();
    for (final base in _baseColors) {
      if (lower.contains(base.toLowerCase())) {
        return base;
      }
    }

    const baseAnchors = <String, Color>{
      'Slate': Color(0xFF020617),
      'Zinc': Color(0xFF09090B),
      'Gray': Color(0xFF030712),
      'Neutral': Color(0xFF0A0A0A),
      'Stone': Color(0xFF0C0A09),
    };

    final sample = isDark ? scheme.background : scheme.foreground;
    var best = 'Slate';
    var minDistance = double.infinity;
    for (final entry in baseAnchors.entries) {
      final distance = _colorDistance(sample, entry.value);
      if (distance < minDistance) {
        minDistance = distance;
        best = entry.key;
      }
    }
    return best;
  }

  String _inferAccentColor(Color primary, String baseColor) {
    const accentAnchors = <String, Color>{
      'Slate': Color(0xFF64748B),
      'Gray': Color(0xFF6B7280),
      'Zinc': Color(0xFF71717A),
      'Neutral': Color(0xFF737373),
      'Stone': Color(0xFF78716C),
      'Red': Color(0xFFEF4444),
      'Orange': Color(0xFFF97316),
      'Amber': Color(0xFFF59E0B),
      'Yellow': Color(0xFFEAB308),
      'Lime': Color(0xFF84CC16),
      'Green': Color(0xFF22C55E),
      'Emerald': Color(0xFF10B981),
      'Teal': Color(0xFF14B8A6),
      'Cyan': Color(0xFF06B6D4),
      'Sky': Color(0xFF0EA5E9),
      'Blue': Color(0xFF3B82F6),
      'Indigo': Color(0xFF6366F1),
      'Violet': Color(0xFF8B5CF6),
      'Purple': Color(0xFFA855F7),
      'Fuchsia': Color(0xFFD946EF),
      'Pink': Color(0xFFEC4899),
      'Rose': Color(0xFFF43F5E),
    };

    var best = 'Base';
    var minDistance = double.infinity;
    for (final entry in accentAnchors.entries) {
      final distance = _colorDistance(primary, entry.value);
      if (distance < minDistance) {
        minDistance = distance;
        best = entry.key;
      }
    }

    final baseDistance = _colorDistance(
      primary,
      accentAnchors[baseColor] ?? accentAnchors['Slate']!,
    );
    if (baseDistance <= minDistance + 10) {
      return 'Base';
    }
    return best;
  }

  double _colorDistance(Color a, Color b) {
    final aValue = a.toARGB32();
    final bValue = b.toARGB32();
    final aRed = (aValue >> 16) & 0xFF;
    final aGreen = (aValue >> 8) & 0xFF;
    final aBlue = aValue & 0xFF;
    final bRed = (bValue >> 16) & 0xFF;
    final bGreen = (bValue >> 8) & 0xFF;
    final bBlue = bValue & 0xFF;
    final dr = (aRed - bRed).toDouble();
    final dg = (aGreen - bGreen).toDouble();
    final db = (aBlue - bBlue).toDouble();
    return (dr * dr) + (dg * dg) + (db * db);
  }
}
