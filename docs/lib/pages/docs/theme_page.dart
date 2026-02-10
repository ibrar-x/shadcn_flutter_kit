import 'package:docs/shadcn_ui.dart';

import '../../theme/docs_theme.dart';
import '../../theme/theme_controller.dart';
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

const List<String> _densityOptions = [
  'Compact',
  'Reduced',
  'Default',
  'Spacious',
];

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
  String _baseColor = 'Slate';
  String _accentColor = 'Base';
  String _density = 'Default';

  bool _previewSwitch = true;
  CheckboxState _previewCheckbox = CheckboxState.checked;
  SliderValue _priceRange = const SliderValue.ranged(320, 800);

  @override
  Widget build(BuildContext context) {
    final controller = context.docsThemeController;
    final data = controller.data;

    return DocsPage(
      name: 'theme',
      onThisPage: const {},
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
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildKitchenPreview(
                      context,
                      threeColumns: showThreePreviewCols,
                    ),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 300,
                    child: _buildOptionsPanel(context),
                  ),
                ],
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
        Slider(
          min: 0,
          max: 1000,
          value: _priceRange,
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
            if (value != null) controller.setPreset(value);
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Base colors'),
        _stringSelect(
          value: _baseColor,
          values: _baseColors,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _baseColor = value);
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Accent colors'),
        _stringSelect(
          value: _accentColor,
          values: _accentColors,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _accentColor = value);
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
          value: _density,
          values: _densityOptions,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _density = value);
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
    required ValueChanged<String?> onChanged,
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
    final lines = <String>[
      'ShadcnApp(',
      "  theme: ThemeData(",
      "    // preset: ${controller.presetId}",
      "    radius: ${data.radius},",
      "    scaling: ${data.scaling},",
      "    surfaceOpacity: ${data.surfaceOpacity},",
      "    surfaceBlur: ${data.surfaceBlur},",
      '  ),',
      ')',
    ];
    return lines.join('\n');
  }
}
