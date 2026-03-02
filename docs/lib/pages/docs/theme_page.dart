import 'package:docs/shadcn_ui.dart';
import 'package:docs/ui/shadcn/components/form/slider/_impl/core/shad_slider_models.dart'
    show ShadRangeValue;

import '../../theme/theme_controller.dart';
import '../../ui/shadcn/shared/theme/preset_themes.dart';
import '../docs_page.dart';
import 'blocks.dart';

const Map<String, String> _themeModes = {
  'Light': 'light',
  'Dark': 'dark',
};

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
  late String _basePresetId;
  late String _accentPresetId;
  bool _presetSelectionsReady = false;

  bool _previewSwitch = true;
  CheckboxState _previewCheckbox = CheckboxState.checked;
  ShadRangeValue _priceRange = const ShadRangeValue(320, 800);
  int _gpuCount = 8;

  List<DocsThemePreset> get _presetOptions => DocsThemeController.presets;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_presetSelectionsReady) return;
    _initializePresetSelections(context.docsThemeController);
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.docsThemeController;
    final showInlineOptions =
        MediaQuery.of(context).size.width < breakpointWidth2;

    if (!_presetSelectionsReady) {
      _initializePresetSelections(controller);
    }

    return DocsPage(
      name: 'theme',
      onThisPage: const {},
      sidebar: SizedBox(
        width: 320,
        child: _buildOptionsPanel(context),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Theme').h1(),
              const SizedBox(height: 12),
              const DocsParagraph(
                text:
                    'Pick registry presets, mix base and accent from different themes, and preview the result in a full component kitchen.',
              ),
              const SizedBox(height: 14),
              if (showInlineOptions) ...[
                _buildOptionsPanel(context),
                const SizedBox(height: 24),
              ],
              _buildKitchenPreview(context),
              const SizedBox(height: 28),
              const Text('Code').h2(),
              const SizedBox(height: 8),
              DocsCodeBlock(code: _buildCodeSnippet()),
            ],
          );
        },
      ),
    );
  }

  void _initializePresetSelections(DocsThemeController controller) {
    final currentBrightness = controller.brightness;

    if (controller.presetId != 'custom' && _hasPreset(controller.presetId)) {
      _basePresetId = controller.presetId;
      _accentPresetId = controller.presetId;
    } else {
      _basePresetId = _closestBasePresetId(
        scheme: controller.data.colorScheme,
        brightness: currentBrightness,
      );
      _accentPresetId = _closestAccentPresetId(
        scheme: controller.data.colorScheme,
        brightness: currentBrightness,
      );
    }

    if (controller.presetId != 'custom' &&
        controller.presetId != _basePresetId) {
      controller.setPreset(_basePresetId);
    }

    _presetSelectionsReady = true;
  }

  bool _hasPreset(String id) {
    return _presetOptions.any((preset) => preset.id == id);
  }

  DocsThemePreset _presetForId(String id) {
    return _presetOptions.firstWhere(
      (preset) => preset.id == id,
      orElse: () => _presetOptions.first,
    );
  }

  ColorScheme _schemeForPreset(String id, Brightness brightness) {
    final preset = _presetForId(id);
    return brightness == Brightness.dark ? preset.dark : preset.light;
  }

  RegistryThemePresetTokens _tokensForPreset(String id, Brightness brightness) {
    final preset = _presetForId(id);
    return brightness == Brightness.dark
        ? preset.darkTokens
        : preset.lightTokens;
  }

  ColorScheme _mixedScheme({
    required ColorScheme baseScheme,
    required ColorScheme accentScheme,
  }) {
    return baseScheme.copyWith(
      primary: () => accentScheme.primary,
      primaryForeground: () => accentScheme.primaryForeground,
      accent: () => accentScheme.accent,
      accentForeground: () => accentScheme.accentForeground,
      ring: () => accentScheme.ring,
      chart1: () => accentScheme.chart1,
      chart2: () => accentScheme.chart2,
      chart3: () => accentScheme.chart3,
      chart4: () => accentScheme.chart4,
      chart5: () => accentScheme.chart5,
      sidebarPrimary: () => accentScheme.sidebarPrimary,
      sidebarPrimaryForeground: () => accentScheme.sidebarPrimaryForeground,
      sidebarAccent: () => accentScheme.sidebarAccent,
      sidebarAccentForeground: () => accentScheme.sidebarAccentForeground,
      sidebarRing: () => accentScheme.sidebarRing,
    );
  }

  ColorScheme _schemeForSelection(Brightness brightness) {
    final baseScheme = _schemeForPreset(_basePresetId, brightness);
    if (_basePresetId == _accentPresetId) {
      return baseScheme;
    }
    final accentScheme = _schemeForPreset(_accentPresetId, brightness);
    return _mixedScheme(baseScheme: baseScheme, accentScheme: accentScheme);
  }

  void _updateThemeMode(DocsThemeController controller, bool isDark) {
    controller.setBrightness(isDark ? Brightness.dark : Brightness.light);
    _applyPresetSelections(controller, baseChanged: false);
  }

  void _updateBasePreset(
      DocsThemeController controller, String nextBasePresetId) {
    if (_basePresetId == nextBasePresetId) return;
    setState(() {
      _basePresetId = nextBasePresetId;
    });
    _applyPresetSelections(controller, baseChanged: true);
  }

  void _updateAccentPreset(
      DocsThemeController controller, String nextAccentPresetId) {
    if (_accentPresetId == nextAccentPresetId) return;
    setState(() {
      _accentPresetId = nextAccentPresetId;
    });
    _applyPresetSelections(controller, baseChanged: false);
  }

  void _applyPresetSelections(
    DocsThemeController controller, {
    required bool baseChanged,
  }) {
    if (baseChanged) {
      controller.setPreset(_basePresetId);
    }

    if (_basePresetId == _accentPresetId) {
      if (controller.presetId != _basePresetId) {
        controller.setPreset(_basePresetId);
      }
      return;
    }

    final mixedScheme = _schemeForSelection(controller.brightness);
    controller.setCustomScheme(mixedScheme);
  }

  String _closestBasePresetId({
    required ColorScheme scheme,
    required Brightness brightness,
  }) {
    var bestPreset = _presetOptions.first.id;
    var bestDistance = double.infinity;

    for (final preset in _presetOptions) {
      final candidate =
          brightness == Brightness.dark ? preset.dark : preset.light;
      final distance = _baseSchemeDistance(scheme, candidate);
      if (distance < bestDistance) {
        bestDistance = distance;
        bestPreset = preset.id;
      }
    }

    return bestPreset;
  }

  String _closestAccentPresetId({
    required ColorScheme scheme,
    required Brightness brightness,
  }) {
    var bestPreset = _presetOptions.first.id;
    var bestDistance = double.infinity;

    for (final preset in _presetOptions) {
      final candidate =
          brightness == Brightness.dark ? preset.dark : preset.light;
      final distance = _accentSchemeDistance(scheme, candidate);
      if (distance < bestDistance) {
        bestDistance = distance;
        bestPreset = preset.id;
      }
    }

    return bestPreset;
  }

  double _baseSchemeDistance(ColorScheme lhs, ColorScheme rhs) {
    return _colorDistance(lhs.background, rhs.background) +
        _colorDistance(lhs.foreground, rhs.foreground) +
        _colorDistance(lhs.card, rhs.card) +
        _colorDistance(lhs.cardForeground, rhs.cardForeground) +
        _colorDistance(lhs.muted, rhs.muted) +
        _colorDistance(lhs.mutedForeground, rhs.mutedForeground) +
        _colorDistance(lhs.border, rhs.border) +
        _colorDistance(lhs.input, rhs.input) +
        _colorDistance(lhs.sidebar, rhs.sidebar) +
        _colorDistance(lhs.sidebarForeground, rhs.sidebarForeground);
  }

  double _accentSchemeDistance(ColorScheme lhs, ColorScheme rhs) {
    return _colorDistance(lhs.primary, rhs.primary) +
        _colorDistance(lhs.primaryForeground, rhs.primaryForeground) +
        _colorDistance(lhs.accent, rhs.accent) +
        _colorDistance(lhs.accentForeground, rhs.accentForeground) +
        _colorDistance(lhs.ring, rhs.ring) +
        _colorDistance(lhs.chart1, rhs.chart1) +
        _colorDistance(lhs.chart2, rhs.chart2) +
        _colorDistance(lhs.chart3, rhs.chart3) +
        _colorDistance(lhs.chart4, rhs.chart4) +
        _colorDistance(lhs.chart5, rhs.chart5) +
        _colorDistance(lhs.sidebarPrimary, rhs.sidebarPrimary) +
        _colorDistance(lhs.sidebarAccent, rhs.sidebarAccent) +
        _colorDistance(lhs.sidebarRing, rhs.sidebarRing);
  }

  double _colorDistance(Color lhs, Color rhs) {
    final lhsValue = lhs.toARGB32();
    final rhsValue = rhs.toARGB32();
    final lhsRed = (lhsValue >> 16) & 0xFF;
    final lhsGreen = (lhsValue >> 8) & 0xFF;
    final lhsBlue = lhsValue & 0xFF;
    final rhsRed = (rhsValue >> 16) & 0xFF;
    final rhsGreen = (rhsValue >> 8) & 0xFF;
    final rhsBlue = rhsValue & 0xFF;

    final dr = (lhsRed - rhsRed).toDouble();
    final dg = (lhsGreen - rhsGreen).toDouble();
    final db = (lhsBlue - rhsBlue).toDouble();

    return (dr * dr) + (dg * dg) + (db * db);
  }

  void _updateGpuCount(int next) {
    setState(() {
      _gpuCount = next.clamp(0, 64);
    });
  }

  void _changeGpuCount(int delta) {
    _updateGpuCount(_gpuCount + delta);
  }

  Widget _buildKitchenPreview(BuildContext context) {
    return MediaQueryVisibility(
      minWidth: 1350,
      alternateChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildKitchenPaymentMethod(context),
          const DensityGap(gapXl),
          _buildKitchenInputs(context),
          const DensityGap(gapXl),
          _buildKitchenAppearanceSettings(context),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildKitchenPaymentMethod(context)),
          const DensityGap(gapXl),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _buildKitchenInputs(context),
            ),
          ),
          const DensityGap(gapXl),
          Expanded(child: _buildKitchenAppearanceSettings(context)),
        ],
      ),
    );
  }

  Widget _buildKitchenPaymentMethod(BuildContext context) {
    final currentYear = DateTime.now().year;
    return Card(
      padding: const EdgeInsetsDensity.all(padSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payment Method').medium(),
          const DensityGap(gapXs),
          const Text('All transactions are secure and encrypted.')
              .muted()
              .small(),
          const DensityGap(gapLg),
          const Text('Name on Card').medium(),
          const DensityGap(gapSm),
          const TextField(
            placeholder: Text('John Doe'),
          ),
          const DensityGap(gapLg),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Card Number').medium(),
                    const DensityGap(gapSm),
                    const TextField(
                      placeholder: Text('1234 5678 9012 3456'),
                    ),
                  ],
                ),
              ),
              const DensityGap(gapLg),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('CVV').medium(),
                    const DensityGap(gapSm),
                    const TextField(
                      placeholder: Text('123'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const DensityGap(gapMd),
          const Text('Enter your 16-digit number.').muted(),
          const DensityGap(gapMd),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Month').medium(),
                    const DensityGap(gapSm),
                    Select<String>(
                      placeholder: const Text('MM'),
                      itemBuilder: (context, item) => Text(item),
                      value: null,
                      onChanged: (value) {},
                      popup: SelectPopup.noVirtualization(
                        items: SelectItemList(
                          children: [
                            for (var month = 1; month <= 12; month++)
                              SelectItemButton(
                                value: month.toString().padLeft(2, '0'),
                                child: Text(month.toString().padLeft(2, '0')),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const DensityGap(gapLg),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Year').medium(),
                    const DensityGap(gapSm),
                    Select<String>(
                      placeholder: const Text('YYYY'),
                      itemBuilder: (context, item) => Text(item),
                      value: null,
                      onChanged: (value) {},
                      popup: SelectPopup.noVirtualization(
                        items: SelectItemList(
                          children: [
                            for (var yearOffset = 0;
                                yearOffset < 12;
                                yearOffset++)
                              SelectItemButton(
                                value: (currentYear + yearOffset).toString(),
                                child:
                                    Text((currentYear + yearOffset).toString()),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const DensityGap(gapLg),
          const Divider(),
          const DensityGap(gapLg),
          const Text('Billing Address').medium(),
          const DensityGap(gapXs),
          const Text('The billing address associated with your payment method')
              .muted()
              .small(),
          const DensityGap(gapMd),
          Checkbox(
            state: _previewCheckbox,
            onChanged: (value) {
              setState(() {
                _previewCheckbox = value;
              });
            },
            trailing: const Text('Same as shipping address'),
          ),
          const DensityGap(gapLg),
          const Divider(),
          const DensityGap(gapLg),
          const Text('Comments').medium(),
          const DensityGap(gapSm),
          const TextArea(
            placeholder: Text('Add any additional comments'),
            expandableHeight: true,
            minHeight: 90,
            maxHeight: 150,
          ),
          const DensityGap(gapMd),
          Row(
            children: [
              PrimaryButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
              const DensityGap(gapMd),
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

  Widget _buildKitchenInputs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildKitchenMembers(),
        const DensityGap(gapLg),
        _buildKitchenBadges(),
        const DensityGap(gapLg),
        _buildKitchenChatBox(),
        const DensityGap(gapLg),
        _buildKitchenPriceRange(),
        const DensityGap(gapLg),
        _buildKitchenSearch(),
        const DensityGap(gapLg),
        _buildKitchenUrlField(),
        const DensityGap(gapLg),
        _buildKitchenAiComposer(),
        const DensityGap(gapLg),
        _buildKitchenMentions(),
      ],
    );
  }

  Widget _buildKitchenAppearanceSettings(BuildContext context) {
    return RadioGroup<bool>(
      value: true,
      onChanged: (value) {},
      child: Column(
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
                      DensityGap(gapXs),
                      Text('Verify via email or phone number.'),
                    ],
                  ),
                ),
                PrimaryButton(
                  density: ButtonDensity.dense,
                  onPressed: () {},
                  child: const Text('Enable'),
                ),
              ],
            ),
          ),
          const DensityGap(gapMd),
          const Card(
            child: Row(
              children: [
                Icon(LucideIcons.badgeCheck),
                DensityGap(gapSm),
                Expanded(child: Text('Your profile has been verified.')),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          const DensityGap(gapLg),
          Divider(
            child: const Text('Appearance Settings').muted().small(),
          ),
          const DensityGap(gapLg),
          const Text('Compute Environment').medium(),
          const DensityGap(gapXs),
          const Text('Select the compute environment for your cluster.')
              .muted()
              .small(),
          const DensityGap(gapMd),
          const RadioCard(
            value: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Kubernetes'),
                    Spacer(),
                    Radio(value: true),
                  ],
                ),
                DensityGap(gapSm),
                Text(
                  'Run GPU workloads on a K8s configured cluster. This is the default.',
                ),
              ],
            ),
          ),
          const DensityGap(gapSm),
          const RadioCard(
            value: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Virtual Machine'),
                    Spacer(),
                    Radio(value: false),
                  ],
                ),
                DensityGap(gapSm),
                Text(
                  'Access a VM configured cluster to run workloads. (Coming soon)',
                ),
              ],
            ),
          ),
          const DensityGap(gapLg),
          const Divider(),
          const DensityGap(gapLg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Number of GPUs'),
                    DensityGap(gapXs),
                    Text('You can add more later.'),
                  ],
                ),
              ),
              SizedBox(
                width: 148,
                child: ButtonGroup(
                  children: [
                    SizedBox(
                      width: 64,
                      child: TextField(
                        key: ValueKey<int>(_gpuCount),
                        initialValue: _gpuCount.toString(),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          final parsed = int.tryParse(value);
                          if (parsed != null) {
                            _updateGpuCount(parsed);
                          }
                        },
                      ),
                    ),
                    IconButton.outline(
                      density: ButtonDensity.iconDense,
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        _changeGpuCount(1);
                      },
                    ),
                    IconButton.outline(
                      density: ButtonDensity.iconDense,
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        _changeGpuCount(-1);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const DensityGap(gapLg),
          const Divider(),
          const DensityGap(gapLg),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wallpaper Tinting'),
                    DensityGap(gapXs),
                    Text('Allow the wallpaper to be tinted.'),
                  ],
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
      ),
    );
  }

  Widget _buildKitchenMembers() {
    return DashedContainer(
      child: DensityContainerPadding(
        padding: const EdgeInsetsDensity.all(padMd),
        child: Column(
          children: [
            AvatarGroup.toLeft(
              gap: 2,
              offset: 0.7,
              children: const [
                Avatar(initials: 'MJ'),
                Avatar(initials: 'JS'),
                Avatar(initials: 'ST'),
              ],
            ),
            const DensityGap(gapLg),
            const Text('No Team Members').small(),
            const DensityGap(gapSm),
            const Text('Invite your team to collaborate on this project.')
                .muted()
                .small()
                .center(),
            const DensityGap(gapMd),
            SecondaryButton(
              leading: const Icon(Icons.add),
              density: ButtonDensity.dense,
              onPressed: () {},
              child: const Text('Invite Members').small(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKitchenBadges() {
    return RepaintBoundary(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          PrimaryBadge(
            leading: const CircularProgressIndicator(
              onSurface: true,
              size: 10,
            ),
            child: const Text('Syncing').small(),
          ),
          SecondaryBadge(
            leading: const CircularProgressIndicator(size: 10),
            child: const Text('Updating').small(),
          ),
          OutlineBadge(
            leading: const CircularProgressIndicator(size: 10),
            child: const Text('Loading').small(),
          ),
        ],
      ),
    );
  }

  Widget _buildKitchenChatBox() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton.outline(icon: const Icon(Icons.add), onPressed: () {}),
          const DensityGap(gapSm),
          Expanded(
            child: TextField(
              placeholder: const Text('Send a message...'),
              padding: const DirectionalEdgeInsetsDensity.only(
                start: padSm,
                end: padXs,
                top: 0,
                bottom: 0,
              ),
              features: [
                InputFeature.trailing(
                  WidgetStatesProvider.boundary(
                    child: Tooltip(
                      tooltip: const TooltipContainer(child: Text('Voice mode'))
                          .call,
                      child: IconButton.ghost(
                        icon: const Icon(LucideIcons.audioLines),
                        onPressed: () {},
                        shape: ButtonShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKitchenPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Price Range').medium(),
        const DensityGap(gapXs),
        const Text('Set your budget range (\$320 - \$800)').muted(),
        const DensityGap(gapSm),
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
      ],
    );
  }

  Widget _buildKitchenSearch() {
    return const TextField(
      placeholder: Text('Search...'),
      features: [
        InputFeature.leading(Icon(Icons.search)),
        InputFeature.trailing(Text('12 Results')),
      ],
    );
  }

  Widget _buildKitchenUrlField() {
    return TextField(
      placeholder: const Text('example.com'),
      features: [
        const InputFeature.leading(Text('https://')),
        InputFeature.hint(
          popupBuilder: const TooltipContainer(
            child: Text('This is content in a tooltip'),
          ).call,
        ),
      ],
    );
  }

  Widget _buildKitchenAiComposer() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextArea(
            minHeight: 72,
            maxHeight: 88,
            placeholder: Text('Ask, Search, or Chat...'),
          ),
          const DensityGap(gapSm),
          const Divider(),
          const DensityGap(gapSm),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton.outline(
                  density: ButtonDensity.iconDense,
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
                const DensityGap(gapSm),
                SecondaryButton(
                  density: ButtonDensity.dense,
                  onPressed: () {},
                  child: const Text('Auto'),
                ),
                const Spacer(),
                const Text('52% Used').muted().small().center(),
                const DensityGap(gapSm),
                const VerticalDivider(),
                const DensityGap(gapSm),
                IconButton.primary(
                  density: ButtonDensity.iconDense,
                  icon: const Icon(Icons.arrow_upward),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKitchenMentions() {
    return TextField(
      placeholder: const Text('@sunarya-thito'),
      features: [
        InputFeature.trailing(
          IconButton.primary(
            density: ButtonDensity.iconDense,
            size: ButtonSize.small,
            shape: ButtonShape.circle,
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsPanel(BuildContext context) {
    final controller = context.docsThemeController;
    final data = controller.data;
    final isDark = controller.brightness == Brightness.dark;
    final presetTokens = _tokensForPreset(_basePresetId, controller.brightness);

    final radiusKey = _radiusOptions.entries
        .firstWhere(
          (entry) => entry.value == data.radius,
          orElse: () => const MapEntry('Default', 0.5),
        )
        .key;
    final scalingKey = _scalingOptions.entries
        .firstWhere(
          (entry) => entry.value == data.scaling,
          orElse: () => const MapEntry('Default', 1.0),
        )
        .key;
    final surfaceOpacityKey = _surfaceOpacityOptions.entries
        .firstWhere(
          (entry) => entry.value == data.surfaceOpacity,
          orElse: () => const MapEntry('Solid', 1.0),
        )
        .key;
    final surfaceBlurKey = _surfaceBlurOptions.entries
        .firstWhere(
          (entry) => entry.value == data.surfaceBlur,
          orElse: () => const MapEntry('None', 0.0),
        )
        .key;
    final densityLabel = _densityLabel(
      density: data.density,
      presetDensity: presetTokens.density,
    );

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
            _updateThemeMode(controller, value == 'Dark');
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Base preset (surface + tokens)'),
        _presetSelect(
          value: _basePresetId,
          brightness: controller.brightness,
          onChanged: (value) {
            if (value == null) return;
            _updateBasePreset(controller, value);
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Accent preset (primary + charts)'),
        _presetSelect(
          value: _accentPresetId,
          brightness: controller.brightness,
          onChanged: (value) {
            if (value == null) return;
            _updateAccentPreset(controller, value);
          },
        ),
        const SizedBox(height: 6),
        Text(
          _basePresetId == _accentPresetId
              ? 'Using one preset for both base and accent.'
              : 'Mix & match active: base and accent come from different presets.',
        ).small().muted(),
        const SizedBox(height: 12),
        _panelLabel('Radius'),
        _stringSelect(
          value: radiusKey,
          values: _radiusOptions.keys.toList(),
          onChanged: (value) {
            if (value == null) return;
            final next = _radiusOptions[value];
            if (next != null) {
              controller.setRadius(next);
            }
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Density'),
        _stringSelect(
          value: densityLabel,
          values: ['Preset', ..._densityOptions.keys],
          onChanged: (value) {
            if (value == null) return;
            if (value == 'Preset') {
              controller.setDensity(presetTokens.density);
              return;
            }
            final next = _densityOptions[value];
            if (next != null) {
              controller.setDensity(next);
            }
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Scaling'),
        _stringSelect(
          value: scalingKey,
          values: _scalingOptions.keys.toList(),
          onChanged: (value) {
            if (value == null) return;
            final next = _scalingOptions[value];
            if (next != null) {
              controller.setScaling(next);
            }
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Surface opacity'),
        _stringSelect(
          value: surfaceOpacityKey,
          values: _surfaceOpacityOptions.keys.toList(),
          onChanged: (value) {
            if (value == null) return;
            final next = _surfaceOpacityOptions[value];
            if (next != null) {
              controller.setSurfaceOpacity(next);
            }
          },
        ),
        const SizedBox(height: 12),
        _panelLabel('Surface blur'),
        _stringSelect(
          value: surfaceBlurKey,
          values: _surfaceBlurOptions.keys.toList(),
          onChanged: (value) {
            if (value == null) return;
            final next = _surfaceBlurOptions[value];
            if (next != null) {
              controller.setSurfaceBlur(next);
            }
          },
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

  Widget _presetSelect({
    required String value,
    required Brightness brightness,
    required ValueChanged<String?> onChanged,
  }) {
    return Select<String>(
      value: value,
      onChanged: onChanged,
      itemBuilder: (context, item) {
        final preset = _presetForId(item);
        final scheme = _schemeForPreset(item, brightness);
        return Row(
          children: [
            Icon(Icons.circle, size: 12, color: scheme.primary),
            const SizedBox(width: 8),
            Flexible(child: Text(preset.name)),
          ],
        );
      },
      popup: SelectPopup.noVirtualization(
        items: SelectItemList(
          children: [
            for (final preset in _presetOptions)
              SelectItemButton(
                value: preset.id,
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 12,
                      color: _schemeForPreset(preset.id, brightness).primary,
                    ),
                    const SizedBox(width: 8),
                    Flexible(child: Text(preset.name)),
                  ],
                ),
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

  String _buildCodeSnippet() {
    final lightScheme = _schemeForSelection(Brightness.light);
    final darkScheme = _schemeForSelection(Brightness.dark);
    final lightTokens = _tokensForPreset(_basePresetId, Brightness.light);
    final darkTokens = _tokensForPreset(_basePresetId, Brightness.dark);

    final lines = <String>[
      'RegistryThemePreset(',
      "  id: '${_generatedPresetId()}',",
      "  name: '${_escape(_generatedPresetName())}',",
      ..._buildColorSchemeLiteral(name: 'light', scheme: lightScheme),
      ..._buildColorSchemeLiteral(name: 'dark', scheme: darkScheme),
      ..._buildTokenLiteral(
        name: 'lightTokens',
        tokens: lightTokens,
        helperName: '_lightTokens',
      ),
      ..._buildTokenLiteral(
        name: 'darkTokens',
        tokens: darkTokens,
        helperName: '_darkTokens',
      ),
      '),',
    ];

    return lines.join('\n');
  }

  String _generatedPresetId() {
    if (_basePresetId == _accentPresetId) {
      return '$_basePresetId-custom';
    }
    return '$_basePresetId-$_accentPresetId-mix';
  }

  String _generatedPresetName() {
    final baseName = _presetForId(_basePresetId).name;
    final accentName = _presetForId(_accentPresetId).name;
    if (_basePresetId == _accentPresetId) {
      return '$baseName Custom';
    }
    return '$baseName + $accentName Accent';
  }

  Iterable<String> _buildColorSchemeLiteral({
    required String name,
    required ColorScheme scheme,
  }) sync* {
    yield '  $name: const ColorScheme(';
    yield '    brightness: Brightness.${scheme.brightness.name},';
    yield '    background: ${_colorLiteral(scheme.background)},';
    yield '    foreground: ${_colorLiteral(scheme.foreground)},';
    yield '    card: ${_colorLiteral(scheme.card)},';
    yield '    cardForeground: ${_colorLiteral(scheme.cardForeground)},';
    yield '    popover: ${_colorLiteral(scheme.popover)},';
    yield '    popoverForeground: ${_colorLiteral(scheme.popoverForeground)},';
    yield '    primary: ${_colorLiteral(scheme.primary)},';
    yield '    primaryForeground: ${_colorLiteral(scheme.primaryForeground)},';
    yield '    secondary: ${_colorLiteral(scheme.secondary)},';
    yield '    secondaryForeground: ${_colorLiteral(scheme.secondaryForeground)},';
    yield '    muted: ${_colorLiteral(scheme.muted)},';
    yield '    mutedForeground: ${_colorLiteral(scheme.mutedForeground)},';
    yield '    accent: ${_colorLiteral(scheme.accent)},';
    yield '    accentForeground: ${_colorLiteral(scheme.accentForeground)},';
    yield '    destructive: ${_colorLiteral(scheme.destructive)},';
    // ignore: deprecated_member_use_from_same_package
    yield '    destructiveForeground: ${_colorLiteral(scheme.destructiveForeground)},';
    yield '    border: ${_colorLiteral(scheme.border)},';
    yield '    input: ${_colorLiteral(scheme.input)},';
    yield '    ring: ${_colorLiteral(scheme.ring)},';
    yield '    chart1: ${_colorLiteral(scheme.chart1)},';
    yield '    chart2: ${_colorLiteral(scheme.chart2)},';
    yield '    chart3: ${_colorLiteral(scheme.chart3)},';
    yield '    chart4: ${_colorLiteral(scheme.chart4)},';
    yield '    chart5: ${_colorLiteral(scheme.chart5)},';
    yield '    sidebar: ${_colorLiteral(scheme.sidebar)},';
    yield '    sidebarForeground: ${_colorLiteral(scheme.sidebarForeground)},';
    yield '    sidebarPrimary: ${_colorLiteral(scheme.sidebarPrimary)},';
    yield '    sidebarPrimaryForeground: ${_colorLiteral(scheme.sidebarPrimaryForeground)},';
    yield '    sidebarAccent: ${_colorLiteral(scheme.sidebarAccent)},';
    yield '    sidebarAccentForeground: ${_colorLiteral(scheme.sidebarAccentForeground)},';
    yield '    sidebarBorder: ${_colorLiteral(scheme.sidebarBorder)},';
    yield '    sidebarRing: ${_colorLiteral(scheme.sidebarRing)},';
    yield '  ),';
  }

  Iterable<String> _buildTokenLiteral({
    required String name,
    required RegistryThemePresetTokens tokens,
    required String helperName,
  }) sync* {
    yield '  $name: $helperName(';
    yield '    radius: ${_formatNumber(tokens.radius)},';
    yield '    spacingBase: ${_formatNumber(tokens.spacing.base)},';
    yield* _buildShadowScaleLiteral(tokens.shadows, indent: 4);
    if (tokens.fontSans != null) {
      yield "    fontSans: '${_escape(tokens.fontSans!)}',";
    }
    if (tokens.fontSerif != null) {
      yield "    fontSerif: '${_escape(tokens.fontSerif!)}',";
    }
    if (tokens.fontMono != null) {
      yield "    fontMono: '${_escape(tokens.fontMono!)}',";
    }
    yield '  ),';
  }

  Iterable<String> _buildShadowScaleLiteral(ShadowScale scale,
      {required int indent}) sync* {
    final pad = ' ' * indent;
    yield '${pad}shadows: const ShadowScale(';
    yield '$pad  shadow2xs: ${_boxShadowListLiteral(scale.shadow2xs)},';
    yield '$pad  shadowXs: ${_boxShadowListLiteral(scale.shadowXs)},';
    yield '$pad  shadowSm: ${_boxShadowListLiteral(scale.shadowSm)},';
    yield '$pad  shadow: ${_boxShadowListLiteral(scale.shadow)},';
    yield '$pad  shadowMd: ${_boxShadowListLiteral(scale.shadowMd)},';
    yield '$pad  shadowLg: ${_boxShadowListLiteral(scale.shadowLg)},';
    yield '$pad  shadowXl: ${_boxShadowListLiteral(scale.shadowXl)},';
    yield '$pad  shadow2xl: ${_boxShadowListLiteral(scale.shadow2xl)},';
    yield '$pad),';
  }

  String _boxShadowListLiteral(List<BoxShadow> shadows) {
    if (shadows.isEmpty) {
      return 'const []';
    }
    return '[${shadows.map(_boxShadowLiteral).join(', ')}]';
  }

  String _boxShadowLiteral(BoxShadow shadow) {
    return 'const BoxShadow('
        'offset: Offset(${_formatNumber(shadow.offset.dx)}, ${_formatNumber(shadow.offset.dy)}), '
        'blurRadius: ${_formatNumber(shadow.blurRadius)}, '
        'spreadRadius: ${_formatNumber(shadow.spreadRadius)}, '
        'color: ${_colorLiteral(shadow.color)}'
        ')';
  }

  String _colorLiteral(Color color) {
    final hex =
        color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase();
    return 'Color(0x$hex)';
  }

  String _escape(String value) {
    return value.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
  }

  String _formatNumber(num value) {
    final rounded = value.toDouble();
    if (rounded == rounded.roundToDouble()) {
      return rounded.toStringAsFixed(1);
    }
    final text = rounded.toStringAsFixed(6);
    return text
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
}
